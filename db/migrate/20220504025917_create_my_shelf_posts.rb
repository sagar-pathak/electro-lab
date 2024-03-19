class CreateMyShelfPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :my_shelf_posts do |t|

      t.timestamps
    end
  end
end
