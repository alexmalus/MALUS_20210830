class VideoCategory < ApplicationRecord
  validates_presence_of :name

  def self.to_select
    pluck(:name, :id)
  end
end
