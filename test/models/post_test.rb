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
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
