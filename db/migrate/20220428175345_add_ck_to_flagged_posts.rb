class AddCkToFlaggedPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :flagged_posts, [:user_id, :post_id], :unique=> true
  end
end
