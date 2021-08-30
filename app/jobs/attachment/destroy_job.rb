class Attachment::DestroyJob < ApplicationJob
  def perform(data)
    destroy_file(data['original'])
    destroy_file(data['small_thumb'])
    destroy_file(data['medium_thumb'])
    destroy_file(data['large_thumb'])
  end

  private

  def destroy_file(data)
    Shrine::Attacher.from_data(data).destroy
  end
end
