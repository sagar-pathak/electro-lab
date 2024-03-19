class AddUserFkColToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :from, foreign_key: { to_table: :users }
  end
end
