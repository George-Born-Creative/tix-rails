class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,  :middle_name, :last_name, :salutation, :title,
                  :role
   
  attr_accessor :full_name


  has_many :orders
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
    
  
end
