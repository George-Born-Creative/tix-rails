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
#

require 'open-uri'
class Chart < ActiveRecord::Base
  attr_accessible :label, :name, :background_image_url, :svg_file, :thumbnail,
                  :width, :height

  alias_attribute :name, :label
  
  belongs_to :account
  has_many :sections, :dependent => :destroy
  has_many :events
  
  after_save :serialize_chart
  
  
  
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
  
  
end

