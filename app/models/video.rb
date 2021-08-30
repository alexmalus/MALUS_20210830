class Video < ApplicationRecord
  include VideoUploader::Attachment(:file)  # VideoUploader will attach and manage `file`

  belongs_to :video_category

  validates_presence_of :title, :file

  delegate :name, to: :video_category, prefix: :category
end
