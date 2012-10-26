# == Schema Information
#
# Table name: artists
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  body                    :text
#  description             :text
#  url                     :string(255)
#  myspace_url             :string(255)
#  facebook_url            :string(255)
#  audio_sample_url        :string(255)
#  video_url               :string(255)
#  twitter                 :string(255)
#  youtube1                :text
#  youtube2                :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  photo_file_name         :string(255)
#  photo_content_type      :string(255)
#  photo_file_size         :integer
#  photo_updated_at        :datetime
#  id_old                  :decimal(, )
#  account_id              :integer          default(0), not null
#  id_old_image            :integer
#  audio_sample_title      :string(255)
#  artist_id_old_secondary :integer
#


class Artist < ActiveRecord::Base
  attr_accessible :audio_sample_url, :description, :facebook_url, 
                  :image, :myspace_url, :twitter, :url, :video_url, 
                  :youtube1, :youtube2, :name, :body, :id_old, :photo,
                  :id_old_image, :audio_sample_title

  has_many :headliners, :class_name => 'Events'
  has_many :secondary_headliners, :class_name => 'Events'
  
  # has_and_belongs_to_many :events
  
  belongs_to :account
    
  has_attached_file :photo,
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
    
    validates_presence_of :name
    
    def self.search(search)
      if search
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end
    
    def to_paired_hash
      {:id => self.id, :name => self.name }
    end

end
