class AddFkUserToMyShelfPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :my_shelf_posts, :user, foreign_key: true
    add_reference :my_shelf_posts, :post, foreign_key: true
  end
end
