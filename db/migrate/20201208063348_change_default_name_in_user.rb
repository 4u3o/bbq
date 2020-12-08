class ChangeDefaultNameInUser < ActiveRecord::Migration[6.0]
  change_column_default :users, :name, from: 'userid', to: nil
end
