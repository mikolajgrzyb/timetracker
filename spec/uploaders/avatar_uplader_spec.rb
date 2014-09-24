require 'carrierwave/test/matchers'

describe AvatarUploader do

  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }

  before do
    AvatarUploader.enable_processing = true
    @uploader = AvatarUploader.new(user, :avatar)
    @uploader.store!(File.open("#{Rails.root}/spec/data/Amarok.png"))
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  context "the thumb version" do

    it "should scale down a landscape image to be exactly 50 by 50 pixels" do
      expect(@uploader.thumb).to have_dimensions(50, 50)
    end

  end

end
