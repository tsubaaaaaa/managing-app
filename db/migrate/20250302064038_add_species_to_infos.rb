class AddSpeciesToInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :species, :string
  end
end
