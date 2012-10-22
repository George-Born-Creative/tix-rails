# == Schema Information
#
# Table name: sections
#
#  id                     :integer          not null, primary key
#  label                  :string(255)
#  default_base_price     :decimal(8, 2)    default(0.0), not null
#  default_service_charge :decimal(8, 2)    default(0.0), not null
#  chart_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  seatable               :boolean          default(FALSE), not null
#  color                  :string(255)
#  dayof_price_id         :integer
#  presale_price_id       :integer
#

class Section < ActiveRecord::Base
  belongs_to :chart
  belongs_to :account
  
  before_save :add_default_prices
  
  has_many :areas, :dependent => :destroy
  # has_many :prices, :dependent => :destroy
  
  
  belongs_to :presale_price, :dependent => :destroy, :class_name => 'Price', :foreign_key => 'presale_price_id'
  belongs_to :dayof_price, :dependent => :destroy, :class_name => 'Price', :foreign_key => 'dayof_price_id'
  
  scope :seatable, :conditions => {:seatable => true}
  
  attr_accessible :chart_id, :label, :seatable, :color, :account_id, :index#, :presale_price, :dayof_price
  
  
  def current_price
    return nil if self.chart.nil? || self.chart.event.nil?
    _day_of?(self.chart.event.starts_at) ? self.dayof_price : self.presale_price
  end
  
  def current_price_name
    return nil if self.chart.nil? || self.chart.event.nil?
    _day_of?(self.chart.event.starts_at) ? 'Day Of' : 'Presale'
  end
  

  private
  
  def add_default_prices
    self.presale_price = get_new_price() if self.presale_price.nil?
    self.dayof_price = get_new_price() if self.dayof_price.nil?
  end
  
  def get_new_price
    price_model = Price.create( :base => 10.00, :service => 3.00)  
  end
  
  
  
  def _day_of?(time) # check if time falls between  
    # midnight today and
    time.to_i >= Date.today.to_time.to_i &&
    # midnight tomorrow
    time.to_i < (Date.today+1).to_time.to_i
  end
  
  
end
