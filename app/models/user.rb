# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  description            :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )

  has_many(
    :comments,
    class_name: 'Comment',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )

  has_many(
    :flagged_posts,
    class_name: 'FlaggedPost',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )

  has_many(
    :votes,
    class_name: 'Vote',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )

has_many(
    :messages,
    class_name: 'Message',
    foreign_key: 'from_id',
    inverse_of: :user,
    dependent: :destroy
  )

  has_many(
    :my_shelf_posts,
    class_name: 'MyShelfPost',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )

end
