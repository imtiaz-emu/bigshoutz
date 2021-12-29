class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: '200x200'
  end

  validate :acceptable_image_type?
  validate :acceptable_image_size?
  validates_presence_of :first_name, :last_name, :mobile_no, :gender, :date_of_birth

  enum gender: { 'Male': 0, 'Female': 1, 'Others': 2 }

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  private

  def acceptable_image_type?
    return unless photo.attached?
    return if photo.content_type.in? %w[image/png image/jpeg image/jpg]
    errors.add :photo, 'must be a PNG or JPG'
  end

  def acceptable_image_size?
    return unless photo.attached?
    return unless photo.byte_size > 1.megabyte
    errors.add :photo, 'must be less than 1MB'
  end
end
