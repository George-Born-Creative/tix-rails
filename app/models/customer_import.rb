# == Schema Information
#
# Table name: customer_imports
#
#  id                :integer          not null, primary key
#  account_id        :integer
#  state             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#

class CustomerImport < ActiveRecord::Base
  attr_accessible :data
  default_scope :order => 'created_at DESC'
  belongs_to :account
  
  has_attached_file :data, :storage => :s3, :s3_credentials => S3_CREDENTIALS, :s3_protocol => :https
  
  #after_save :queue_import_job
  
  #validates_format_of :data, :with => %r{\.(csv)$}i, :message => "Must be a CSV format"
  #validates_attachment_content_type :data, :content_type => ['text/csv'], :message => "Mime type must be CSV"
  
  private
  
  def queue_import_job
    Delayed::Job.enqueue CustomerImportJob.new(self.id)
  end
      
end
