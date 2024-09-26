class CreateUebungs < ActiveRecord::Migration[6.0]
  def change
    create_table :uebungs do |t|
      t.string :title
      t.text :description
      t.references :benutzer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
