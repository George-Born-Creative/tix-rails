class TicketMailer < ActionMailer::Base

  DEV_EMAIL = 'shaun@squiid.com'
  BOX_OFFICE_EMAIL = 'tickets@jamminjava.com'
 
  add_template_helper(ApplicationHelper)

  def send_tickets(account_id, order_id)
    @account = Account.find(account_id)
    @order = @account.orders.find(order_id)
    subject = "Your Jammin' Java Order (#{@order.id})"
    
      mail(
        :subject => subject,
        :to      => get_email,
        :from    => 'Jammin\' Java <tickets@jamminjava.com>',
        :bcc => get_bcc_email
      )
      @order.update_attribute(:tickets_delivered_at, Time.zone.now )
  end
  
  private
  
  def get_email
    ENV['RAILS_ENV'] == 'production' ? @order.email : DEV_EMAIL
  end

  def get_bcc_email
    ENV['RAILS_ENV'] == 'production' ? BOX_OFFICE_EMAIL : DEV_EMAIL
  end
end