# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  caption           :string(255)
#  type              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  account_id        :integer
#

class Image < ActiveRecord::Base
  attr_accessible :caption, :title, :file, :tag_list
  attr_accessor :file_name
  belongs_to :imageable, :polymorphic => true
  belongs_to :account
  attr_accessible :tag_tokens
  
  attr_reader :tag_tokens
  
  acts_as_taggable_on :tags
   
  has_attached_file :file,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => S3_CREDENTIALS,
    :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" },
    :path =>  ":account_subdomain/:class/:attachment/:id_partition/:style/:filename"

  Paperclip.interpolates :account_subdomain do |attachment, style|
    attachment.instance.account.subdomain
  end
  
  validates_attachment_presence :file, :messgage => 'Please upload a file.'


  #http://spectator.in/2012/02/15/normalizing-paperclips-filenames/
  
  def tags_hash
    self.tags.collect {|t| {:id => t.name, :name => t.name }}
  end


  def file_name
    return nil unless self.file?
    File.basename(self.file.to_s).split('?')[0]
  end
  
end
