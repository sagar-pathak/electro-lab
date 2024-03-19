class AddUserFkColToFlaggedPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :flagged_posts, :user, foreign_key: true
  end
end
