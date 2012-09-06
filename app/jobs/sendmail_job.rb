class SendmailJob
  @queue = :zion
    
  def self.perform
    #TestMailer.letter('Hi from resque').deliver
    puts 'hi'
  end
  
end