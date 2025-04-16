class RenameHunteddateToHuntedDate < ActiveRecord::Migration[7.1]
  def change
    rename_column :infos, :Hunteddate, :hunted_date
  end
end
