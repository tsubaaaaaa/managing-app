require 'net/http'
require 'json'

class InfosController < ApplicationController

  layout "read_only", only:[:read_only]

    def index

      @infos = Info.all

      if params[:search].present?
        search = "%#{params[:search]}%"
        #部分一致検索
        @infos = Info.where("CAST(identifier AS TEXT) LIKE ? OR hunter LIKE ?", search, search)
      end

      #日付絞込
      if params[:start_date].present? || params[:end_date].present?
        start_date = Date.parse(params[:start_date]) rescue nil
        end_date = Date.parse(params[:end_date]) rescue nil

        if start_date && end_date
          @infos = @infos.where("Hunteddate BETWEEN ? AND ?", start_date, end_date)
        elsif start_date
          @infos = @infos.where("Hunteddate >= ?", start_date)
        elsif end_date
          @infos = @infos.where("Hunteddate <= ?", end_date)
        end

      end

      #各種ソート
      sort_options = {
          "hunt_asc" => { Hunteddate: :asc },
          "hunt_desc" => { Hunteddate: :desc },
          "processed_asc" => { processed_date: :asc },
          "processed_desc" => { processed_date: :desc },
          "id_asc" => { id: :asc },
          "id_desc" => { id: :desc }
        }

        if params[:sort].present? && sort_options.key?(params[:sort])
          @infos = @infos.order(sort_options[params[:sort]])
        end

      #ページネーション
        @infos = @infos.page(params[:page]).per(5)

    end

    def new 
      @info = Info.new
    end

    def create #新規投稿を保存するためのアクション
    info = Info.new(info_params)
      if info.save
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
    end

    def show #投稿の詳細を表示するためのアクション
      @info = Info.find(params[:id])
    end

    def read_only
      @info = Info.find(params[:id])
    end

    def edit #投稿の編集画面を表示するためのアクション
      @info = Info.find(params[:id])
    end

    def update #投稿を編集して保存するためのアクション
      info = Info.find(params[:id])
      if info.update(info_params)
        redirect_to :action => "show", :id => info.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy #投稿を削除するためのアクション
      info = Info.find(params[:id])
      info.destroy
      redirect_to action: :index
    end

    private
    def info_params
      params.require(:info).permit(:identifier,
       :hunter, :Hunteddate, 
       :location, :method, 
       :species, :ages, 
       :weight, :butchering_date, 
       :processed_location, 
       :processed_date, 
       :processed_by)
    end

    

end
