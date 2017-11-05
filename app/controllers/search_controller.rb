# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @bookmarks = Bookmark.search(params[:search])
  end
end
