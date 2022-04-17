# == Schema Information
#
# Table name: listings
#
#  id                     :bigint           not null, primary key
#  service_id             :integer
#  owner_id               :integer
#  name                   :string           default(""), not null
#  description            :text
#  available_on           :datetime
#  price                  :decimal(10, 2)
#  deleted_at             :datetime
#  meta_description       :text
#  meta_keywords          :string
#  promotionable          :boolean          default(TRUE)
#  meta_title             :string
#  discontinue_on         :datetime
#  talk_type              :string
#  event_time             :datetime
#  event_place            :string
#  live_session_time      :datetime
#  live_session_end_time  :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  currency               :string
#  is_free                :boolean          default(FALSE)
#  event_address          :string
#  video_preview_duration :integer
#  vote_count             :integer          default(0)
#
class Listing < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :service
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :uploads, dependent: :destroy
  has_many :line_items, as: :line_item_able

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :uploads, content_type: { in: %i[gif png jpg jpeg mp4 3gp mkv],
                                      min: 1, max: 4,
                                      message: ' not a valid format, supports image/video' }
  validates_presence_of :name, :description, :available_on
  validate :price_is_present?

  enum video_preview_duration: { '5_Second': 1, '10_Second': 2 }

  def has_video?
    videos.any?
  end

  def videos
    uploads.select { |upload| upload.content_type.include?('video') }
  end

  def images
    uploads.select { |upload| upload.content_type.include?('image') }
  end

  def all_votes(user = nil)
    user ? votes.where(user_id: user.id) : votes
  end

  Service::DEFAULT_SERVICES.each do |service_name|
    define_method :"is_#{service_name.parameterize.underscore}?" do
      self.service.title == service_name
    end
  end

  private

  def price_is_present?
    return true if self.is_free

    if self.price.blank?
      errors.add(:price, ' Cannot be blank')
    end
  end

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
