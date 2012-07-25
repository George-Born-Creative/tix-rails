class TestMailer < ActionMailer::Base

  def tagged_message
    mail(
      :subject => 'hello',
      :to      => 'shaun@squiid.com',
      :from    => 'shaun@squiid.com',
      :tag     => 'test-mailer'
    )
  end

end