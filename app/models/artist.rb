class Artist < ActiveRecord::Base
  attr_accessible :audio_sample_url, :description, :facebook_url, 
                  :image, :myspace_url, :twitter, :url, :video_url, 
                  :youtube1, :youtube2, :name, :body, :id_old, :photo


  has_many :headliners, :class_name => 'Events'
  has_many :secondary_headliners, :class_name => 'Events'
  
  
  has_attached_file :photo,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :path => "jamminjava/:attachment/:style/:filename"
    
    
    

end
