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
#  account_id             :integer          not null
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  salutation             :string(255)
#  title                  :string(255)
#  role                   :string(255)      default("customer")
#  balance                :decimal(8, 2)    default(0.0), not null
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  newsletter_opt_in      :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  ROLES = %w[owner manager employee customer guest]
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :token_authenticatable
         #:confirmable
   
   scope :with_role, lambda { |*roles| {
     :conditions => { :role => roles.map {|r| r.to_s}}
   }}
   
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,  :middle_name, :last_name, :salutation, :title,
                  :role, :account_id, :phone, :newsletter_opt_in, :accept_terms_conditions,
                  :address_attributes, :phone_attributes
 
  # http://rubydoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
  # Reset token with every save
  before_save :reset_authentication_token
   
  attr_accessor :full_name

  has_many :orders
  
  has_one :address, :as => :addressable, :dependent => :destroy
  has_one :phone, :as => :phonable, :dependent => :destroy
  
  accepts_nested_attributes_for :address, :phone

  has_many :tickets, :through => :orders
  belongs_to :account
  
  def has_at_least_role(role)
    # owner manager employee customer guest
    case role
      when :super
        return true if (self.role == :super)
      when :owner
        return true if (self.role == :super)
        return true if (self.role == :owner)
      when :manager
        return true if (self.role == :super)
        return true if (self.role == :owner)
        return true if (self.role == :manager)
      when :employee
        return true if (self.role == :owner)  
        return true if (self.role == :super)
        return true if (self.role == :manager)
        return true if (self.role == :employee)
      when :customer
        return true if (self.role == :super)
        return true if (self.role == :owner)
        return true if (self.role == :manager) 
        return true if (self.role == :employee)
        return true if (self.role == :customer)
      else
        return false
    end
    return false
  end
  
  
  validates_inclusion_of :role, :in => ROLES.map{|r| r.to_sym}
  # validates :accept_terms_conditions, :acceptance => true
  
  
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
  
  def total_sales
    #TODO: cache
    return 0 if self.orders.empty?
    
    return self.orders.reduce(0) do |memo, order|
      memo += order.total
    end
  end
  
  protected
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    account_id = conditions.delete(:account_id)
    where(conditions).where(["lower(email) = :value", { :value => email.downcase }]).where("account_id = ?", account_id).first
  end
  
  
  def self.total_balance
    find(:all, 
         :select => 'sum(balance)'
         )
  end
  
  def self.most_valuable_customers(opts={})
    raise 'Most valuable customers requires an account ID' if opts[:account_id].blank?
    
    opts.reverse_merge!({
      :limit => 100
    })
    
    # Sanitize. TODO escape the fragment properly
    opts[:limit] = opts[:limit].to_i
        
    query = """SELECT users.id, users.first_name, users.last_name, users.email, sum(orders.total)
    FROM users
    RIGHT OUTER JOIN orders
    ON orders.user_id = users.id OR orders.agent_id = users.id
    WHERE users.account_id = #{opts[:account_id]}
    GROUP BY users.id, users.last_name, users.first_name
    HAVING sum(orders.total) > 0
    ORDER BY sum(orders.total) DESC
    LIMIT #{opts[:limit]}"""

    res = ActiveRecord::Base.connection.execute(query)  
  end
  
end
