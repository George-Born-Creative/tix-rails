class Theme < ActiveRecord::Base
  attr_accessible :activated_at, :css_doc, :title, :background_image
  belongs_to :account
  has_paper_trail
  
  scope :active, where("activated_at is NOT NULL").order('activated_at DESC')
  
  
  
  has_attached_file :background_image,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" },
    :path =>  ":account_subdomain/:class/:attachment/:id_partition/:style/:filename"
  
  
  Paperclip.interpolates :account_subdomain do |attachment, style|
    attachment.instance.account.subdomain
  end
  
  
  
  def activate!
    self.update_attributes(:activated_at => DateTime.now)
  end
  
  def self.active_theme
    self.active.first
  end
end
