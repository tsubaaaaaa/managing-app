require 'net/http'
require 'json'

class InfosController < ApplicationController
  before_action :validate_access_token, only: [:read_only]
  before_action :restrict_read_only_access, except: [:read_only]

#reodonlyはユーザー認証をスルーするため、exceptを使用
#これ大事
  before_action :authenticate_user!, except: [:read_only]

  layout "read_only", only:[:read_only]

    def index
      if session[:read_only_access]
        redirect_to read_only_info_path(@info), alert: "閲覧モードではこのページにアクセスできません"
      end

      @infos = Info.all

      if params[:search].present?
        search = "%#{params[:search]}%"
        #部分一致検索
        @infos = @infos.where(
          "CAST(identifier AS TEXT) LIKE ?
          OR hunter LIKE ?
          OR species LIKE ?
          OR location LIKE ?
          OR processed_location LIKE ?
          OR processed_by LIKE ?",
           search, search, search, 
           search, search, search)
      end

      #日付絞込
      if params[:start_date].present? || params[:end_date].present?
        start_date = Date.parse(params[:start_date]) rescue nil
        end_date = Date.parse(params[:end_date]) rescue nil

        if start_date && end_date
          @infos = @infos.where(hunted_date: start_date..end_date)
        elsif start_date
          @infos = @infos.where("hunted_date >= ?", start_date)
        elsif end_date
          @infos = @infos.where("hunted_date <= ?", end_date)
        end        

      end

      #各種ソート
      sort_options = {
          "hunt_asc" => { hunted_date: :asc },
          "hunt_desc" => { hunted_date: :desc },
          "processed_asc" => { processed_date: :asc },
          "processed_desc" => { processed_date: :desc },
          "id_asc" => { identifier: :asc },
          "id_desc" => { identifier: :desc }
        }

        if params[:sort].present? && sort_options.key?(params[:sort])
          @infos = @infos.order(sort_options[params[:sort]])
        end

      #ページネーション
        @infos = @infos.all.page(params[:page]).per(10)

    end

    def new 
      @user = current_user
      @info = Info.new
    end

    def create # 新規投稿を保存するためのアクション

      if params[:info][:method_other].present?
        params[:info][:method] = params[:info][:method_other]
      end

      @info = Info.new(info_params)
      @info.user = current_user # 投稿者を現在のユーザーに設定

      if @info.save
        redirect_to action: "index", notice: '保存されました'
      else
        render :new
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
        flash[:notice] = "更新されました"
        redirect_to :action => "show", :id => info.id
      else
        flash[:alert] = "更新に失敗しました"
        redirect_to :action => "show", :id => info.id
      end
    end

    def destroy #投稿を削除するためのアクション
      info = Info.find(params[:id])
      info.destroy
      redirect_to action: :index
    end

    def read_only
      if @info.nil?
        render "infos/error", status: :forbidden  # エラーページを表示
      else
        session[:read_only_access] = true
      end
    end


    private


    def info_params
      params.require(:info).permit(:identifier,
       :hunter, :Hunteddate, 
       :location, :method, :method_other,
       :species, :ages, 
       :weight, :butchering_date, 
       :processed_location, 
       :processed_date, 
       :processed_by)
    end
      
        # read_onlyのユーザーを他のページにアクセスさせない
     # 認証トークンをチェック
    def validate_access_token
      @info = Info.find_by(id: params[:id], access_token: params[:token])
    end

    # read_only モードのユーザーを他のページにアクセスさせない
    def restrict_read_only_access
      if session[:read_only_access] && action_name != "read_only"
        redirect_to read_only_info_path(@info), alert: "閲覧モードではこのページにアクセスできません"
      end
    end

end
