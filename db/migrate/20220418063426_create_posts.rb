class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :categoryId
      t.string :description
      t.integer :downVote
      t.boolean :isFlagged
      t.string :thumbnailImg
      t.string :title
      t.integer :upVote

      t.timestamps
    end
  end
end
