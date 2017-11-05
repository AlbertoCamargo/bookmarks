# frozen_string_literal: true

class Bookmark < ApplicationRecord
  # Validations
  validates :url, :title, presence: true, uniqueness: true
  validate :validate_url
  validate :validate_shortening, unless: Proc.new { |b| b.shortening.blank? }

  # Callbacks
  before_save :set_site
  before_save :set_shortening_url, if: Proc.new { |b| b.shortening.blank? }

  def site
    Site.find(site_id)
  end

  def self.search(title = nil)
    query = 'title LIKE ?'
    Bookmark.where(query, "%#{title}%")
  end

  private

  def set_site
    url_host = URI.parse(url).host
    site = Site.find_or_create_by(url: url_host)
    self.site_id = site.id
  end

  def validate_url
    errors.add(:url, 'invalid url') unless uri_is_valid?(url)
  end

  def validate_shortening
    return if uri_is_valid?(shortening)
    errors.add(:shortening, 'invalid url shortening')
  end

  def set_shortening_url
    url_shortener_object = Google::UrlShortener::Url.new(long_url: url)
    self.shortening = url_shortener_object.shorten!
  end

  def uri_is_valid?(url)
    uri = URI.parse(url)
    return false if uri.host.blank?
    true
  rescue URI::InvalidURIError
    false
  end
end
