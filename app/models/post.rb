# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  description  :string
#  isFlagged    :boolean
#  thumbnailImg :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :posts
    )

    belongs_to(
        :category,
        class_name: 'Category',
        foreign_key: 'category_id',
        inverse_of: :posts
    )

    has_many(
        :steps,
        class_name: 'Step',
        foreign_key: 'post_id',
        inverse_of: :post,
        dependent: :destroy
    )

    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: 'post_id',
        inverse_of: :post,
        dependent: :destroy
    )

    has_many(
        :flagged_posts,
        class_name: 'FlaggedPost',
        foreign_key: 'post_id',
        inverse_of: :post,
        dependent: :destroy
    )

    has_many(
        :votes,
        class_name: 'Vote',
        foreign_key: 'post_id',
        inverse_of: :post,
        dependent: :destroy
    )

    has_many(
        :my_shelf_posts,
        class_name: 'MyShelfPost',
        foreign_key: 'user_id',
        inverse_of: :post,
        dependent: :destroy
      )

end
