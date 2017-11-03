# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  context 'validation and creation' do
    let!(:site) { create(:site) }
    let(:valid_attributes) do
      {
        title: 'valid',
        url: 'https://github.com/rspec/',
        shortening: 'https://goo.gl/AfoQuV'
      }
    end

    it 'is invalid' do
      expect(Bookmark.new(shortening: 'https://goo.gl/')).to_not be_valid
      expect(Bookmark.new(title: 'valid')).to_not be_valid
      expect(Bookmark.new(url: 'https://github.com/rspec/')).to_not be_valid
      expect(Bookmark.new(url: '/rspec/', title: 'title')).to_not be_valid
    end

    it 'has errrors. not site and bad url' do
      b = Bookmark.new(url: '/rspec/', title: 'title')
      b.valid?
      expect(b.errors.messages.length).to eq(1)
    end

    it 'is valid' do
      expect(Bookmark.new(valid_attributes)).to be_valid
    end

    it 'creates a bookmark' do
      expect do
        Bookmark.create(valid_attributes)
      end.to change { Bookmark.count }.by(1)
    end

    it 'finds a site if it exist' do
      bookmark = Bookmark.create(valid_attributes)
      bookmark.site.url == site.url
    end

    it 'creates a site if it does not exist' do
      expect do
        Bookmark.create(
          title: 'valid',
          url: 'https://relishapp.com/rspec/rspec-expectations',
          shortening: 'https://goo.gl/AfoQuV'
        )
      end.to change { Site.count }.by(1)
    end
  end

  context 'search bookmark' do
    let!(:bookmark) { create(:bookmark) }

    it 'find a bookmark' do
      expect(Bookmark.search(nil, nil, 'goo').count).to eq(1)
      expect(Bookmark.search('orbi').count).to eq(1)
      expect(Bookmark.search(nil, 'github').count).to eq(1)
    end

    it 'does not find a bookmark' do
      expect(Bookmark.search('it does not exist').count).to eq(1)
    end
  end
end
