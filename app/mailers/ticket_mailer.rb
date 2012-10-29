class TicketMailer < ActionMailer::Base
  # layout 'application.pdf.haml'
    
  add_template_helper(ApplicationHelper)

  def send_tickets(account_id, order_id, attach_tickets=true)
    @account = Account.find(account_id)
    @order = @account.orders.find(order_id)
    subject = "Your Jammin' Java Order (#{@order.id})"
    
    attachments["tickets.pdf"] = gen_pdf() if attach_tickets

      mail(
        :subject => subject,
        :to      => 'shaun@squiid.com',
        :from    => 'Jammin\' Java<memberservices@jamminjava.com>'
      )
  end
  
  private
  
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