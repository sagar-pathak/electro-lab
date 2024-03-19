class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.string :description
      t.string :image
      t.string :title

      t.timestamps
    end
  end
end
