# == Schema Information
#
# Table name: flagged_posts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_flagged_posts_on_post_id              (post_id)
#  index_flagged_posts_on_user_id              (user_id)
#  index_flagged_posts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class FlaggedPost < ApplicationRecord
    belongs_to(
        :post,
        class_name: 'Post',
        foreign_key: 'post_id',
        inverse_of: :flagged_posts
    )

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :flagged_posts
    )

    validates_uniqueness_of :post_id, scope: [:user_id]

end
