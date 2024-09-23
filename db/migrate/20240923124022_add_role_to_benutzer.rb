class AddRoleToBenutzer < ActiveRecord::Migration[7.2]
  def change
    add_column :benutzers, :role, :string, default: 'student', null: false
  end
end
