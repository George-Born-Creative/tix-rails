# == Schema Information
#
# Table name: ticket_templates
#
#  id                :integer          not null, primary key
#  label             :string(255)
#  meta              :string(255)
#  times_used        :integer          default(0), not null
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class TicketTemplate < ActiveRecord::Base
  attr_accessible :file, :label, :meta, :thumbnail
  belongs_to :account
  
  has_attached_file :file,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :path =>  ":account_subdomain/:class/:attachment/:id_partition/:style/:filename"
    
  
  validates_presence_of :label
  validates_presence_of :file
  validates_uniqueness_of :label, :scope => :account_id
  
  Paperclip.interpolates :account_subdomain do |attachment, style|
    attachment.instance.account.subdomain
  end
  
end
