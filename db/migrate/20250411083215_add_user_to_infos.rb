class AddUserToInfos < ActiveRecord::Migration[7.1]
  def change
    add_reference :infos, :user, foreign_key: true
  end
end
