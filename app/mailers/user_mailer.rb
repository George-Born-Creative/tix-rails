class UserMailer < ActionMailer::Base

  DEV_EMAIL = 'shaun@squiid.com'

   
  add_template_helper(ApplicationHelper)

  def send_welcome_email(user_id)
    @user = User.find(user_id)
    
    subject = "#{@user.first_name}, welcome to Jammin' Java"

    mail(
      :subject => subject,
      :to      => get_email,
      :from    => 'Jammin\' Java<tickets@jamminjava.com>',
    )
  end

  private

  def get_email
    ENV['RAILS_ENV'] == 'production' ? @user.email : DEV_EMAIL
  end



end