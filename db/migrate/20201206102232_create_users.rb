class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 35
      t.string :email, null: false, index: { unique: true }, limit: 255

      t.timestamps
    end
  end
end
