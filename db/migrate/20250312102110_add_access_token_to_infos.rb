class AddAccessTokenToInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :access_token, :string
  end
end
