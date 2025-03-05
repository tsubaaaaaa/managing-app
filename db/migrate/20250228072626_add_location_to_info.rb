class AddLocationToInfo < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :location, :string
  end
end
