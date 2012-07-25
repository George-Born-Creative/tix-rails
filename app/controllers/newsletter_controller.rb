class NewsletterController < ApplicationController
  layout false
  def index
    @events = Event.limit(20)
  end
end