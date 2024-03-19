class CreateFlaggedPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :flagged_posts do |t|
      t.timestamps
    end
  end
end
