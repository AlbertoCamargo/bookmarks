require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let!(:bookmark) { create(:bookmark) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { site_id: bookmark.site.id }
      expect(:bookmarks).not_to be_empty
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: bookmark.id, site_id: bookmark.site.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found status code' do
      expect do
        get :edit, params: { id: 'not exists', site_id: bookmark.site.id }
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #create' do
    it 'redirects to index bookmarks' do
      data = {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      post :create, params: { bookmark: data }
      b = Bookmark.find_by_url('https://github.com/rspec/')
      expect(response).to redirect_to(site_path(b.site.id))
    end

    it 'creates a bookmark' do
      data = {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: { bookmark: data }
      end.to change { Bookmark.count }.by(1)
    end

    it 'does not create a bookmark because is invalid data' do
      data = {
        url: '/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
      expect do
        post :create, params: { bookmark: data }
      end.to_not(change { Bookmark.count })
    end
  end

  describe 'PUTS #update' do
    it 'redirects to index bookmarks' do
      put :update, params: {
        id: bookmark.id,
        bookmark: { title: 'changed' },
        site_id: bookmark.site.id
      }
      expect(response).to redirect_to(site_path(bookmark.site.id))
    end

    it 'updated a bookmark' do
      expected = 'changed'
      put :update, params: {
        id: bookmark.id,
        bookmark: { title: expected },
        site_id: bookmark.site.id
      }
      expect(bookmark.reload.title).to eq(expected)
    end

    it 'does not updates a bookmark because is invalid data' do
      put :update, params: {
        id: bookmark.id,
        bookmark: { url: '' },
        site_id: bookmark.site.id
      }
      expect(bookmark.reload.url).to_not eq('')
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to index bookmarks' do
      delete :destroy, params: { id: bookmark.id, site_id: bookmark.site.id }
      expect(response).to redirect_to(site_path(bookmark.site.id))
    end

    it 'deletes a bookmark' do
      expect do
        delete :destroy, params: { id: bookmark.id, site_id: bookmark.site.id }
      end.to change { Bookmark.count }.by(-1)
    end
  end
end
