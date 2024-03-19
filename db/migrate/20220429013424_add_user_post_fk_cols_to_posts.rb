class AddUserPostFkColsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :post, foreign_key: true
  end
end
