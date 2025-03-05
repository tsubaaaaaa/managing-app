class AddHunterToInfo < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :hunter, :string
  end
end
