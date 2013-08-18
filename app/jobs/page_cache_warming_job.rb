class PageCacheWarmingJob < Struct.new(:account_id)
  
  def perform    
    @account = Account.find(account_id)
    clear_existing_jobs
    crawl_urls
    requeue
  end
  
  def refresh_interval
    (ENV['PAGE_CACHE_REFRESH'].to_i || 2).minutes.from_now
  end
  
  def crawl_urls
    hydra = Typhoeus::Hydra.hydra
   
    urls_to_crawl.each do |url|
      Rails.logger.debug "Queuing cache warm: #{url}"
      request = Typhoeus::Request.new(url)
      request.on_complete do |response|
        handle_response response
      end
      hydra.queue request
    end
    
    hydra.run
    
  end
  
  def handle_response(response)
    msg = ''
    
    if response.success?
      msg = 'HTTP request response'
    elsif response.timed_out?
      msg = 'HTTP request timeout'
    elsif response.code == 0
      msg = 'HTTP request returned ' + response.return_message
    else
      msg = 'HTTP request failed: ' + response.code.to_s
    end
    
    Rails.logger.debug "#{msg} for URL: #{response.effective_url}"
  end
  
  def urls_to_crawl
    slugs.map do |slug|
      "#{@account.host}#{slug}/?bust_cache=yes" 
    end
  end
  
  def slugs
    @account.pages.select(:slug).map(&:slug).map do |the_slug|
      sanitize_slug(the_slug)
    end
  end
  
  def sanitize_slug(slug)
    slug.gsub(' ', '-')
  end
  
  def clear_existing_jobs
    Delayed::Job.where('handler ILIKE ?', '%PageCacheWarmingJob%').delete_all  
  end
  
  def requeue
    Delayed::Job.enqueue( PageCacheWarmingJob.new(@account.id), run_at: refresh_interval, priority: 2)
  end
    
end