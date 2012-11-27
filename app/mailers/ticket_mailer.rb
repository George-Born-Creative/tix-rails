class TicketMailer < ActionMailer::Base

  DEV_EMAIL = 'shaun@squiid.com'
  add_template_helper(ApplicationHelper)

  def send_tickets(account_id, order_id, attach_tickets=true)
    @account = Account.find(account_id)
    @order = @account.orders.find(order_id)
    subject = "Your Jammin' Java Order (#{@order.id})"
    
    attachments["tickets.pdf"] = gen_pdf() if attach_tickets

      mail(
        :subject => subject,
        :to      => get_email,
        :from    => 'Jammin\' Java<memberservices@jamminjava.com>'
      )
  end
  
  private
  
  def get_email
    #puts "get_email CALLED"
    #puts ENV['RAILS_ENV'] == 'production'
    
    ENV['RAILS_ENV'] == 'production' ? @order.email : DEV_EMAIL
  end
  

end