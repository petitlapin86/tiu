require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "branches", :type => :request do

  shared_examples 'render_templates' do
    it 'renders a inspiration template' do
      get '/posts/inspiration'
      expect(response).to render_template(:inspiration)
    end

    it 'renders a recipes template' do
      get '/posts/recipes'
      expect(response).to render_template(:recipes)
    end

    it 'renders a tiugirls template' do
      get '/posts/tiugirls'
      expect(response).to render_template(:tiugirls)
    end
  end

  context 'non-signed in user' do
    it_behaves_like 'render_templates'
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it_behaves_like 'render_templates'
  end

end
