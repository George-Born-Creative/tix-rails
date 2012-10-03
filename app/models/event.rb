# == Schema Information
#
# Table name: events
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  headline               :string(255)
#  supporting_act         :text
#  body                   :text
#  starts_at              :datetime
#  ends_at                :datetime
#  chart_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  headliner_id           :integer
#  secondary_headliner_id :integer
#  supporting_act_1       :string(255)
#  supporting_act_2       :string(255)
#  supporting_act_3       :string(255)
#  info                   :text
#  set_times              :text
#  price_freeform         :string(255)
#  account_id             :integer          default(0), not null
#  chart                  :string(255)
#  artist_id_old          :integer
#  cat                    :string(255)
#  announce_at            :datetime
#  on_sale_at             :datetime
#  off_sale_at            :datetime
#  remove_at              :datetime
#



class Event < ActiveRecord::Base
  attr_accessible :title, :price_freeform, :set_times, :info, :body,
                  :headliner, :secondary_headliner, :supporting_acts,
                  :headliner_id, :secondary_headliner_id, :supporting_acts,
                  :suggestion_1, :suggestion_2, :suggestion_3,
                  :artist_id_old, :chart, :tickets, :starts_at, 
                  :slug, :buytix_url_old,
                  :cat,                   # TODO move category into its own model
                  :announce_at, :on_sale_at, :starts_at, :off_sale_at, :remove_at
  
  attr_accessor :starts_at_formatted 
  
  TIMES = [:announce_at, :on_sale_at, :starts_at, :off_sale_at, :remove_at]
  
  alias_attribute :name, :title
  
  delegate :photo, :to => :headliner # :allow_nil => true
  alias :image :photo  
  
  # TODO: Validates Timeliness
  # https://github.com/adzap/validates_timeliness
  # attr_accessible :ends_at, :headline, :body, :image_uri, :image_thumb_uri
  
  validates_presence_of :starts_at
  validates_uniqueness_of :slug, :scope => :account_id
  
  before_save :set_default_times
  before_destroy :check_tickets
  
  belongs_to :chart, :autosave => true, :dependent => :destroy
  has_many :tickets
  belongs_to :account
  belongs_to :headliner, :class_name => 'Artist'
  belongs_to :secondary_headliner, :class_name => 'Artist'
  
  
  scope :announced, lambda {{ :conditions => ["announce_at < ? AND remove_at > ?", Time.now, Time.now] }}
  scope :on_sale, lambda {{ :conditions => ["on_sale_at < ? AND off_sale_at > ?", Time.now, Time.now] }}  

  def announced?
    now = DateTime.now.to_i
    now > self.announce_at.to_i && now < self.remove_at.to_i
  end
  
  def on_sale?
    now = DateTime.now.to_i
    now > self.on_sale_at.to_i && now < self.off_sale_at.to_i
  end
  
  def starts_in_future?
    future? self.starts_at
  end

  def inspect
    debug
  end
  
  def day_of? # is today within 24 hours of midnight of the start price
    _day_of? self.starts_at
  end
  
  def current_prices_arr
    return nil if self.chart.nil?
    
    prices = self.chart.sections.map do |section|
      unless section.current_price.nil? || section.current_price.base.nil?
        section.current_price.base
      end
    end
    prices
  end
  
  private
  
  def _day_of?(time) # check if time falls between  
    # midnight today and
    time.to_i >= Date.today.to_time.to_i &&
    # midnight tomorrow
    time.to_i < (Date.today+1).to_time.to_i
  end
  
  def set_default_times # called before save
    
    # TODO: Make these into account-level settings
    
    now = DateTime.now 
    self.off_sale_at = self.starts_at + 3.hours if self.off_sale_at.nil?
    self.remove_at = self.starts_at + 3.hours if self.remove_at.nil?
    
    # only set these if in the future
    if self.announce_at.nil? && self.starts_in_future?
      self.announce_at = now
      self.on_sale_at = now if self.on_sale_at.nil?
    end
  end
    
  def debug
    puts %{
      # =>   announced  #{self.announce_at} days: #{days_ago self.announce_at}
      # =>   on sale    #{self.on_sale_at} days: #{days_ago self.on_sale_at}
      # =>   starts     #{self.starts_at} days: #{days_ago self.starts_at}
      # =>   off_sale   #{self.off_sale_at} days: #{days_ago self.off_sale_at}
      # =>   remove     #{self.remove_at} days: #{days_ago self.remove_at}
    }
  end
  
  private 
  def future?(time)
    ( time.to_i - Time.now.to_i ) > 0
  end
    
  def days_ago(time)
    ( ( time.to_i - Time.now.to_i ) / 60 / 60 / 24) + 1
  end

  def check_tickets
    unless self.tickets.empty?
      errors[:base] << "Cannot delete event that has tickets" 
      return false
    end
  end

  
end


    
