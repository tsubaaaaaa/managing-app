class AddHunteddateToInfo < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :Hunteddate, :date
  end
end
