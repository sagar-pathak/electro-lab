# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  downvote   :integer
#  upvote     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_votes_on_post_id  (post_id)
#  index_votes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Vote < ApplicationRecord
    belongs_to(
        :post,
        class_name: 'Post',
        foreign_key: 'post_id',
        inverse_of: :votes
    )

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :votes
    )

    validates_uniqueness_of :post_id, scope: [:user_id]
end
