class ChangeIdentifierToStringInInfos < ActiveRecord::Migration[7.1]
  def up
    change_column :infos, :identifier, :string
  end

  def down
    change_column :infos, :identifier, :integer
  end
end
