# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :integer          not null, primary key
#  data_file_name    :string(255)      not null
#  data_content_type :string(255)
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :integer
#

class Ckeditor::AttachmentFile < Ckeditor::Asset
  
  has_attached_file :data,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => S3_CREDENTIALS,
    :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" },
    :path => ":attachment/:id/:style.:extension"
  
  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data
	
	def url_thumb
	  @url_thumb ||= Ckeditor::Utils.filethumb(filename)
	end
end
