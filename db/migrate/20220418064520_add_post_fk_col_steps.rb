class AddPostFkColSteps < ActiveRecord::Migration[6.1]
  def change
    add_reference :steps, :post, foreign_key: true
  end
end
