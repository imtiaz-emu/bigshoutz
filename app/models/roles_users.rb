# == Schema Information
#
# Table name: roles_users
#
#  role_id :bigint
#  user_id :bigint
#
class RolesUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
