# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]

  # GET sites/:site_id/bookmarks
  def index
    @bookmarks = site.bookmarks
  end

  # GET sites/1/bookmarks/:id
  def show; end

  def new
    @bookmark = Bookmark.new
  end

  def edit; end

  # POST /bookmarks
  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      redirect_to(
        site_path(@bookmark.site.id),
        notice: 'Bookmark was successfully created.'
      )
    else
      render :new
    end
  end

  # PATCH/PUT /bookmarks/1
  def update
    if @bookmark.update(bookmark_params)
      redirect_to(
        site_path(@bookmark.site.id),
        notice: 'Bookmark was successfully updated.'
      )
    else
      render :edit
    end
  end

  # DELETE /bookmarks/1
  def destroy
    @bookmark.destroy
    redirect_to root_url, notice: 'Bookmark was successfully destroyed.'
  end

  private

  def set_bookmark
    @bookmark = site.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :shortening)
  end

  def site
    @site ||= Site.find(params[:site_id])
  end
end
