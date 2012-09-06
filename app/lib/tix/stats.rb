module Tix
  class Stats
    
    def customer_balance_totals(account_id)
      Account.find(account_id).users.total_balance
    end
    
    
    def customer_balance_average(account_id)
      Account.find(account_id).users.total_balance
    end
    
  end
end