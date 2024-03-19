# == Schema Information
#
# Table name: my_shelf_posts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_my_shelf_posts_on_post_id  (post_id)
#  index_my_shelf_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class MyShelfPost < ApplicationRecord
    belongs_to(
        :post,
        class_name: 'Post',
        foreign_key: 'post_id',
        inverse_of: :my_shelf_posts
    )

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :my_shelf_posts
    )
end
