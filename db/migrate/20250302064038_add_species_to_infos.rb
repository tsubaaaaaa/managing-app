class AddSpeciesToInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :infos, :method, :string
    add_column :infos, :species, :string
    add_column :infos, :ages, :string
    add_column :infos, :sex, :string
    add_column :infos, :weight, :string
    add_column :infos, :butchering_date, :date
    add_column :infos, :processed_location, :string
    add_column :infos, :processed_date, :date
    add_column :infos, :processed_by, :string
    add_column :infos, :access_token, :string
    
  

  end
end
