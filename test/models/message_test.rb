# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from_id    :bigint
#  to_id      :integer
#
# Indexes
#
#  index_messages_on_from_id  (from_id)
#
# Foreign Keys
#
#  fk_rails_...  (from_id => users.id)
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
