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
#  account_id             :integer          not null
#  chart                  :string(255)
#  artist_id_old          :integer
#  cat                    :string(255)
#  announce_at            :datetime
#  on_sale_at             :datetime
#  off_sale_at            :datetime
#  remove_at              :datetime
#  buytix_url_old         :string(255)
#  slug                   :string(255)
#  disable_event_title    :boolean          default(FALSE)
#  external_ticket_url    :string(255)
#  sold_out               :boolean
#  free_event             :boolean
#  hide_buttons           :boolean
#



class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
    
  attr_accessible :title, :price_freeform, :set_times, :info, :body,
                  :headliner, :secondary_headliner, :supporting_acts,
                  :headliner_id, :secondary_headliner_id, 
                  :suggestion_1, :suggestion_2, :suggestion_3,
                  :artist_id_old, :chart, :tickets, :starts_at,
                  :slug, :buytix_url_old,
                  :cat,                   # TODO move category into its own model
                  :announce_at, :on_sale_at, :starts_at, :off_sale_at, :remove_at,
                  :supporting_acts, :supporting_act_ids, :supporting_act_ids_concat,
                  :disable_event_title, :external_ticket_url, :sold_out, :free_event,
                  :hide_buttons
                  
  attr_accessor :supporting_act_ids_concat
  
    
  before_save :set_supporting_act_ids
  before_save :set_default_times

  validates_uniqueness_of :slug, :scope => :account_id
  # http://rubydoc.info/github/norman/friendly_id/master/FriendlyId/Slugged
  def should_generate_new_friendly_id?
    new_record?
  end
   
  def set_supporting_act_ids
    unless self.supporting_act_ids_concat.blank?
      self.supporting_act_ids = self.supporting_act_ids_concat.split(',')
      self.touch
    end
    true
  end
  
  attr_accessor :starts_at_formatted 
  
  TIMES = [:announce_at, :on_sale_at, :starts_at]#, :off_sale_at, :remove_at]
  CATEGORIES = [:adult, :kids, :kids_weekday, :lobby, :brindley]
  
  
  alias_attribute :name, :title
  
  delegate :photo, :to => :headliner # :allow_nil => true
  alias :image :photo  
  
  # TODO: Validates Timeliness
  # https://github.com/adzap/validates_timeliness
  # attr_accessible :ends_at, :headline, :body, :image_uri, :image_thumb_ur
  
  
  validates_presence_of :starts_at
  validates_uniqueness_of :slug, :scope => :account_id, :allow_nil => true
  
  before_destroy :check_tickets
  
  belongs_to :chart, :autosave => true, :dependent => :destroy
  has_many :tickets
  has_many :orders, :through => :tickets, :uniq => true
  
  belongs_to :account
  belongs_to :headliner, :class_name => 'Artist'
  belongs_to :secondary_headliner, :class_name => 'Artist'
  has_and_belongs_to_many :supporting_acts, :class_name => 'Artist', :join_table => 'events_supporting_acts'
  accepts_nested_attributes_for :supporting_acts
  
  has_many :categories, :as => :categorizable
  validates_inclusion_of :cat, :in => CATEGORIES.map{|c| c.to_s}.join(' '), :allow_nil => true
  
  scope :announced, lambda {{ :conditions => ["announce_at < ? AND remove_at > ?", Time.zone.now, Time.zone.now] }}
  scope :on_sale, lambda {{ :conditions => ["on_sale_at < ? AND off_sale_at > ?", Time.zone.now, Time.zone.now] }}  
  scope :current, lambda {{ :conditions => ["starts_at >= ?", Time.zone.now - 5.hours] }}  
  scope :historical, lambda {{ :conditions => ["starts_at < ?", Time.zone.now] }}  
  scope :past, lambda {{ :conditions => ["starts_at < ?", Time.zone.now] }}  

  scope :today, lambda {{ :conditions => ["starts_at BETWEEN ? AND ?", Time.zone.today.beginning_of_day, Time.zone.today.end_of_day ] }}  
  
  
  scope :cat, lambda { |*cats| {
    :conditions => ['cat IN (?)', cats.flatten.map{|c| c.to_s} ]
  }}




  def announced?
    now = Time.zone.now
    now > self.announce_at && (self.remove_at.nil? || now < self.remove_at)
  end
  
  def on_sale?
    now = Time.zone.now
    on_sale = now > self.on_sale_at && (self.off_sale_at.nil? || now < self.off_sale_at)
    on_sale && announced?
  end
  
  def self.defaults
    today = Time.zone.now.to_date
   {:starts_at => today + 30, # 30 days from now
    :announce_at => today,
    :on_sale_at => today + 10,
    :off_sale_at => today + 30,
    :remove_at => today + 30 }
  end
  
  def starts_in_future?
    future? self.starts_at
  end

  
  def day_of? # is today within 24 hours of midnight of the start price
    _day_of? self.starts_at
  end
  
  def current_prices_arr
    return nil if self.chart.nil?
    
    prices = self.chart.sections.seatable.map do |section|
      unless section.current_price.nil? || section.current_price.base.nil?
        section.current_price.base
      end
    end
    prices
  end
  
  def current_prices_str
    return nil if self.chart.nil?
    
    #return self.chart.sections.seatable.order('label ASC').to_sql
    str = self.chart.sections.seatable.order('label DESC').reduce('') do |memo, section|
      base = "%.2f" % section.current_price.base
      base = base[0..-4] if base[-3,3] == '.00' # convert 10.00 to 10 otherwise full
      memo += "#{section.label} $#{base} / " 
    end
 
    str[0..-3] # return string without trailing slash
  end
  
  
  # e.g. "Some Artist + Some Other Artist + Some Third Arits"
  def artists_str
    headliners_str + supporting_acts_str
  end
  
  def headliners_str
    str = ""
    str = self.headliner.name unless self.headliner.nil?
    str += " + #{self.secondary_headliner.name}" unless self.secondary_headliner.nil?
    str
  end
  
  def supporting_acts_str
    str = ""
    unless self.supporting_acts.empty?
      str = self.supporting_acts.inject("") {|memo, artist| memo += " + #{artist.name}" }
    end
    str
  end
  
  def title_array # Returns the first and second headlines
    if self.disable_event_title
      return [ headliners_str, supporting_acts_str ]
    else
      return [ title, headliners_str + supporting_acts_str ]
    end
  end
  
  def title_with_artists
    if self.disable_event_title
      artists_str
    else
      "#{(self.title + " ") unless self.title.blank?}#{artists_str unless self.artists_str.blank?}"
    end
  end
  
  def set_times_formatted
    return nil if self.set_times.blank?
    set_times.gsub(/\n/, '<br/>')
  end
  
  def info_formatted
     return nil if self.info.blank?
     info.gsub(/\n/, '<br/>')
   end
  
  # Append today's date onto normal timestamp-based cache key
  # so cache resets at midnight each day. Needed so day-of
  # pricing takes effect
  def cache_key
    on_sale_str = on_sale? ? 'on_sale' : 'off_sale'
    [super, Time.zone.today.strftime('%Y-%m-%d'), on_sale_str].join('-')
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
    # TODO: When using .select, expecting these attrs to exist
    # may pose a probelm. Check if attr exists first.
    
    now = Time.zone.now 
    
    # Set default show start time to right now if its doesn't exist
    self.starts_at = Time.zone.now if self.starts_at.nil?
    
    # For now, these are always 3 hours after show start tim
    self.off_sale_at = self.starts_at + 3.hours
    self.remove_at = self.starts_at + 3.hours
    
    # only set these if in the future
    if self.starts_in_future?
      self.announce_at = now if self.announce_at.nil? 
      self.on_sale_at = now if self.on_sale_at.nil?
    end
    
  end
    
  
  private 
  def future?(time)
    ( time.to_i - Time.zone.now.to_i ) > 0
  end
    
  def days_ago(time)
    ( ( time.to_i - Time.zone.now.to_i ) / 60 / 60 / 24) + 1
  end

  def check_tickets
    unless self.tickets.empty?
      errors[:base] << "Cannot delete event that has tickets" 
      return false
    end
  end
  

  
end


    
