class AddIdentifierToInfo < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :identifier, :integer
  end
end
