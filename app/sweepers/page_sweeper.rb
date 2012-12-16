class PageSweeper < ActionController::Caching::Sweeper
  # observe Page, Event
  # 
  # def after_update(page)
  #   expire_fragment '/page/' + page.slug
  # end
  # 
  # def after_save(page)
  #   expire_fragment '/page/' + page.slug
  # end
end