# == Schema Information
#
# Table name: listings
#
#  id                    :bigint           not null, primary key
#  service_id            :integer
#  owner_id              :integer
#  name                  :string           default(""), not null
#  description           :text
#  available_on          :datetime
#  price                 :decimal(10, 2)
#  deleted_at            :datetime
#  meta_description      :text
#  meta_keywords         :string
#  promotionable         :boolean          default(TRUE)
#  meta_title            :string
#  discontinue_on        :datetime
#  talk_type             :string
#  event_time            :datetime
#  event_place           :string
#  live_session_time     :datetime
#  live_session_end_time :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Listing < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :service
  has_many_attached :uploads, dependent: :destroy

  validates :uploads, content_type: { in: %i[gif png jpg jpeg mp4 3gp mkv],
                                      min: 1, max: 4,
                                      message: ' not a valid format, supports image/video' }
  validates_presence_of :name, :description, :price, :available_on, :currency

  enum video_preview_duration: { '5_Second': 0, '10_Second': 1 }

  def has_video?
    videos.any?
  end

  def videos
    uploads.select { |upload| upload.content_type.include?('video') }
  end

  def images
    uploads.select { |upload| upload.content_type.include?('image') }
  end
end
