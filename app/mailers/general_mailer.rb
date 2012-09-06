class GeneralMailer < ActionMailer::Base

  def simple_notice(subject, body, tag='general-mailer')
    @body = body
    
    mail(
      :subject => subject,
      :to      => 'shaun@squiid.com',
      :from    => 'shaun@squiid.com',
      :tag     => tag
    )
  end
  
  

end