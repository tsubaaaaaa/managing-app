class AddLocationToInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :latitude, :float
    add_column :infos, :longitude, :float
  end
end
