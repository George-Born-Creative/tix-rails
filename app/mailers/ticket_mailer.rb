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
  
  def gen_pdf
    DocRaptor.api_key ||= ENV["DOCRAPTOR_API_KEY"]
    pdf_html = render( :partial => 'front/orders/tickets.pdf.haml', :locals => {:order => @order, :account => @account})

    response = DocRaptor.create(:document_content => pdf_html,
                     :name             => "jammin_java_tickets.pdf",
                     :document_type    => "pdf",
                     :test             => true)
    response.body
  end

end