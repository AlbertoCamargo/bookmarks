require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let!(:bookmark) { create(:bookmark) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(:sites).not_to be_empty
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: bookmark.site.id }
      expect(:bookmarks).not_to be_empty
      expect(response).to have_http_status(:success)
    end
  end
end
