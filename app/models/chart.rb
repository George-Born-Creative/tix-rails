# == Schema Information
#
# Table name: charts
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  background_image_url   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :integer          default(0), not null
#  label                  :string(255)
#  svg_file_file_name     :string(255)
#  svg_file_content_type  :string(255)
#  svg_file_file_size     :integer
#  svg_file_updated_at    :datetime
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#  svg_file_serialized    :text
#  width                  :decimal(, )
#  height                 :decimal(, )
#  background_color       :string(255)
#  master                 :boolean          default(FALSE)
#

require 'open-uri'
class Chart < ActiveRecord::Base
  attr_accessible :label, :name, :svg_file, :thumbnail,
                  :width, :height, :background_color, :master, :event

  alias_attribute :name, :label
  
  before_save :set_default_background_color
  DEFAULT_BACKGROUND_COLOR = '#000000'
  belongs_to :account
  has_many :sections, :dependent => :destroy, :order => 'index ASC'
  has_many :areas, :through => :sections, :inverse_of => :chart
  
  has_one :event
  
  after_save :serialize_chart
  
  scope :masters, :conditions => { :master => true }
  scope :slaves, :conditions => { :master => false }
  scope :indexed, :order => 'index ASC'
  
  
  has_attached_file :svg_file,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :path =>  ":account_subdomain/:class/:attachment/:id_partition/:style/:filename"
  
  
  
    has_attached_file :thumbnail,
      :storage => :s3,
      :bucket => ENV['S3_BUCKET_NAME'],
      :s3_credentials => {
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      },
      :styles => { :medium => "300x300>", :thumb => "100x100>" },
      :path =>  ":account_subdomain/:class/:attachment/:id_partition/:style/:filename"

  
  
  validates_presence_of :thumbnail
  validates_presence_of :svg_file
  validates_uniqueness_of :name, :scope => :account_id
  
  Paperclip.interpolates :account_subdomain do |attachment, style|
    attachment.instance.account.subdomain
  end
  
  def serialize_chart # todo: maybe add this to a background queue
    if self.svg_file?
      filename = self.svg_file.to_s      
      self.update_column(:svg_file_serialized, read_file(filename) )
    end
  end
  
  def read_file(url_or_filepath)
    str = ""
    begin
      open(url_or_filepath) { |f| f.each_line { |l| str += l  } }
    end
    str
  end
  
  def has_section?(section_label)
    !sections.find_by_label(section_label).nil?
  end
  
  def sections_incl_areas
    sections.includes(:areas)
  end

  def copy
    dup( :except => :master, :include => [:sections => [:dayof_price, :presale_price, :areas]] )
  end

  # CLASS METHODS

  def self.inventories_optimized_query(chart_id)
    res = ActiveRecord::Base.connection.execute("""SELECT 
      areas.id as area_id,
      areas.label as area_label,
      areas.max_tickets as max_tickets,
      orders.purchased_at,
      orders.expires_at,
      orders.state

    FROM sections

    LEFT OUTER JOIN areas
    ON areas.section_id = sections.id

    LEFT OUTER JOIN charts
    ON sections.chart_id = charts.id

    LEFT OUTER JOIN tickets
    ON tickets.area_id = areas.id

    LEFT OUTER JOIN orders
    ON tickets.order_id = orders.id

    WHERE charts.id = '#{chart_id}'""")
  end
  
  
  # An optimized query to get inventory via max_tickets adjustments
  
  def self.inventories_optimized(chart_id)
    res = self.inventories_optimized_query(chart_id)
    inventories = {}
    res.each do |row|
      area_id = row['area_id'].to_i
      max_tickets = row['max_tickets'].to_i
      
      inventories[area_id] = max_tickets if inventories[area_id].nil?
      
      if row['state'] == 'complete' || 
        (row['state'] == 'cart' && 
          row['expires_at'].to_time.in_time_zone > (Time.now - Order::LIFESPAN)
        )
        
        inventories[area_id] = inventories[area_id] - 1
      
      end
      
    end
    inventories
  end
  
 








  
  private
  def set_default_background_color
    if self.background_color.nil?
      self.background_color = DEFAULT_BACKGROUND_COLOR
    end
  end
  
end

