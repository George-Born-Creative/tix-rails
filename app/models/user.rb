# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :integer          default(0), not null
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  salutation             :string(255)
#  title                  :string(255)
#  role                   :string(255)      default("customer")
#  balance                :decimal(8, 2)    default(0.0), not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   
   scope :with_role, lambda { |*roles| {
     :conditions => { :role => roles.map {|r| r.to_s}}
  }}
   
  
  
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,  :middle_name, :last_name, :salutation, :title,
                  :role
   
  attr_accessor :full_name


  has_many :orders
  
  has_many :addresses, :as => :addressable, :dependent => :destroy
  has_many :phones, :as => :phonable, :dependent => :destroy
  
  has_many :tickets, :through => :orders
  belongs_to :account
  
  
  
  ROLES = %w[owner manager employee customer guest]
  
  validates_inclusion_of :role, :in => ROLES.map{|r| r.to_sym}
  
  def role
    read_attribute(:role).to_sym
  end
  
  def role=(value)
    write_attribute(:role, value.to_s)
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def email_hash # for gravatar
    Digest::MD5.hexdigest self.email.downcase.strip
  end
  
  def gravatar_url
    "http://www.gravatar.com/avatar/#{self.email_hash}.jpg"
  end
    
  
  
  def avatar_url # runs too slow without some kind of caching
    #default_url = "#{root_url}images/guest.png"
    #gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    #}"http://gravatar.com/avatar/#{gravatar_id}.png?s=48"#d=#{CGI.escape(default_url)}"
  end
  
  
  class << 
    def total_balance
      find(:all, 
           :select => 'sum(balance)'
           )
    end
  
    def average_balance
      find(:all, 
           :select => 'avg(balance) as balance'
           )
    end
  end
    
  
  
end
