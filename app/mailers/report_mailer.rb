class ReportMailer < ActionMailer::Base

  DEV_EMAIL = 'shaun@squiid.com'
  
  add_template_helper(ApplicationHelper)

  def order_report(email, order_id)
     @order = Order.find(order_id)
     @account = @order.account
     
     subject = "Jammin' Java Order Completed (#{@order.id})"
 
      mail(
        :subject => subject,
        :to      => filter_email(email),
        :from    => 'Jammin\' Java <tickets@jamminjava.com>'
      )
  end
  
  def daily_report
  end
  
  def weekly_report
  end
  
  def monthly_report
  end
  
  private
  
  def filter_email(email)
    ENV['RAILS_ENV'] == 'production' ? email : DEV_EMAIL
  end
  

end