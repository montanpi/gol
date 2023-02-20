class AddMatrixToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :matrix, :text, default: ''
  end
end
