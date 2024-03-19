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
require "test_helper"

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
