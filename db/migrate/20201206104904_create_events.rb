class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, null: false, limit: 255
      t.text :description
      t.string :address, null: false
      t.datetime :datetime, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
