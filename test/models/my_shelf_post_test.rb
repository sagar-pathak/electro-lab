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
require "test_helper"

class MyShelfPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
