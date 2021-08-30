require 'rails_helper'

RSpec.describe 'videos/index', type: :view do
  # let(:video_category) { create(:video_category) }

  # before(:each) do
  #   assign(:videos, [
  #            Video.create!(
  #              title: 'Title',
  #              file: sample_video,
  #              video_category: video_category
  #            ),
  #            Video.create!(
  #              title: 'Title',
  #              file: sample_video,
  #              video_category: video_category
  #            )
  #          ])
  # end

  it 'renders a list of videos' do
    # render
    # assert_select 'tr>td', text: 'Title'.to_s, count: 2
    # assert_select 'tr>td', text: 'MyText'.to_s, count: 2

    pending "TODO: go more into shrine source code and make sure the sample feed file is not destroyed."

    raise StandardError
  end
end
