class AddPincodeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :pincode, :string, limit: 3
  end
end
