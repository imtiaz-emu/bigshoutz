# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  CUSTOMER_TYPES = %w[fan celebrity talent].freeze

  attr_accessor :role

  has_and_belongs_to_many :roles
  has_one :profile, dependent: :destroy
  has_many :listings, class_name: 'Listing', foreign_key: 'owner_id'

  scope :celebrities, -> { joins(:roles, :profile).where(roles: { name: %w[Celebrity Talent] }) }
  scope :celebrities_with_complete_profile, -> {
    joins(:roles, :profile)
    .where.not(profile: { first_name: nil, last_name: nil })
    .where(roles: { name: %w[Celebrity Talent] })
  }

  after_create :create_profile
  after_validation :assign_role, on: %i[create]

  private

  # assign role from sign up. If invalid/no role provided - use 'Fan' as default role
  def assign_role
    role = Role.find_by(name: self.role&.capitalize)
    role = Role.find_by(name: 'Fan') if role.nil?

    return if self&.roles&.include?(role)

    self.roles << role
  end
end
