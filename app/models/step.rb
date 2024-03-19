# == Schema Information
#
# Table name: steps
#
#  id          :bigint           not null, primary key
#  description :string
#  image       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  post_id     :bigint
#
# Indexes
#
#  index_steps_on_post_id  (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
class Step < ApplicationRecord
    belongs_to(
        :post,
        class_name: 'Post',
        foreign_key: 'post_id',
        inverse_of: :steps
    )
end
