class ReplaceS3HttpWithHttpsInPageBody < ActiveRecord::Migration
  # Replace http://s3.amazonaws.com/thintix_production/
  # with     https://s3.amazonaws.com/thintix_production/
  def up
    Page.all.each do |page|
      page.update_attribute(:body, sub_http_with_https(page.body))
    end
    
    Widget.all.each do |widget|
      widget.update_attribute(:body, sub_http_with_https(widget.body))
    end
    
  end

  def down
  end
  
  def sub_http_with_https(str)
    str.gsub(/http:\/\/s3.amazonaws.com\/thintix_production\//, 'https://s3.amazonaws.com/thintix_production/')
  end
end
