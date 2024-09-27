class CreateActivityLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_logs do |t|
      t.references :benutzer, null: false, foreign_key: true
      t.string :action
      t.text :details

      t.timestamps
    end
  end
end
