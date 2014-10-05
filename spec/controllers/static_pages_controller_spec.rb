require 'rails_helper'

describe StaticPagesController, type: :controller do

  describe "GET#index" do

    it "status is eq 200" do
      get :index
      expect(response.status).to eq 200
    end

  end

end
