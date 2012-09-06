# To Add Later (ignore for now)
 
# company  # lastlogindate # comments # last_updated
# enabled # website # maillist

require "csv"
require 'open-uri'

class CustomerImportJob < Struct.new(:customer_import_id)
  
  # Takes a CustomerImport ID. 
  # Grabs account number and CSV data file stored there.
  # Parses file as CSV
  # Loops through CSV rows. For each row
  #  -formats data correctly
  #  -increases "accepted count" if save successful
  #  -else adds row to "fail count"
  # Sends a summary email with "accepted count" and list of failures
  # TODO: Put failures back into new CSV for error correction
  
  attr_accessor :report

  def perform
    @accepted_count = 0 # number of records saved successfully
    @rejected = [] # array of rejected records
    @report = ''
    
    @customer_import = CustomerImport.find( customer_import_id)
    @account = @customer_import.account
    
    file_url = @customer_import.data.url
    csv_text = open(file_url)
    csv = CSV.parse(csv_text, :headers => true)
        
    csv.each_with_index do |row, i|
      puts "Processing row #{i}"
      process_row(row)
    end
    
    build_report
    deliver_report
    @customer_import.state = 'complete'
    @customer_import.save
  end

  def deliver_report
    subject = "Tix: #{@accepted_count} accounts added with #{@rejected.size} rejections"
    GeneralMailer.delay.simple_notice(subject, @report, 'customer-import-report')
  end
  
  def build_report
   report "#{@accepted_count} Customers imported successfully"

    unless @rejected.empty?
      report "#{@rejected.size} Customers were rejected:"
      @rejected.each do |u|
        report "#{u.full_name} (#{u.email})"
        u.errors.each do |e|
          report e
        end
      end
    end
  end
    
  
  private
  
  def report(line) # adds one line to report
    @report += "#{line}<br/>"
  end
  
  
  def process_row(row)
    # User 
    first_name = row['first_name']
    last_name = row['last_name']
    email = row['email']
    password = row['password']
    puts "#{first_name} #{last_name} password is '#{password}'"
    
    # Address
    address_line_1 = row['address_line_1']
    address_line_2 = row['address_line_2']
    city = row['city']
    state = row['state']
    postal_code = row['zip']
    country = row['country']
    
    # Phone
    phone = row['phone']
    
    puts "### ADDRESS #{address_line_1} #{address_line_2} #{row}"
    
    begin 
    
      user = @account.users.new(   :first_name => first_name.titleize,
                                  :last_name => last_name.titleize,
                                  :email => email,
                                  :password => password
                                )
                              
    
    
      user.addresses.new(  :address_line_1 => address_line_1.titleize,
                                      :address_line_2 => address_line_2,
                                      :locality => city.titleize,
                                      :admin_area => state,
                                      :postal_code => postal_code,
                                      :country => country
                                    )
                                  
      user.phones.new( :number => phone )
          
      if user.save
        @accepted_count += 1
      else
        @rejected.push user
      end
    
    rescue
      @rejected.push user
    end
    
  end
  
  
end
