class AddPostFkColToFlaggedPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :flagged_posts, :post, foreign_key: true
  end
end
