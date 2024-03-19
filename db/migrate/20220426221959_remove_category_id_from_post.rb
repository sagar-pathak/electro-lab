class RemoveCategoryIdFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :categoryId, :integer
  end
end
