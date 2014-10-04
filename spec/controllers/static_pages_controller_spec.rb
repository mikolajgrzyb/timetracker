require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  it '#show' do
    get :show
    expect(response.status).to eq 200
  end

end
