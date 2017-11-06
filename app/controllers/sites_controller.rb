# frozen_string_literal: true

class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @bookmarks = site.bookmarks
  end

  private

  def site
    @site ||= Site.find(params[:id])
  end
end
