module Tix
  class Seed

    require_relative './jammin_java_importer'
    @account = Account.find_or_create_by_subdomain('jamminjava')

    def self.clear_data
      Account.delete_all
      Artist.delete_all
      Event.delete_all
      User.delete_all
    end


    def self.seed_data
      seed_artists
      seed_customers
      seed_events
    end


    def self.seed_artists
      Tix::JamminJavaImporter.import(
            "./db/fixtures/jamminjava/artists.csv",
            @account.artists)
    end

    def self.seed_customers
      Tix::JamminJavaImporter.import_customers(
            "./db/fixtures/jamminjava/customers.csv", 
            @account.users)
    end

    def self.seed_events
      Tix::JamminJavaImporter.import_events("./db/fixtures/jamminjava/events-adult.csv", @account.events, 'adult')
      Tix::JamminJavaImporter.import_events("./db/fixtures/jamminjava/events-kids.csv", @account.events, 'kids')
    end
    
    def self.fetch_artist_images
      puts "Starting artist import for account #{@account.subdomain} (#{@account.id})"
      Tix::JamminJavaImporter.import_artist_photos( @account.artists)
    end
    
    
    def self.generate_orders
      
    end
    
    
    # def self.assign_artists_to_events
    #   @account.events.all.each do |event|
    #     artist = @account.artists.find( event.artist_id_old,
    #                                     :select => '')
    #     unless artist.nil?
    #       event.headliner = artist
    #       event.save
    #     end
    #   end
    # end
    
    def self.generate_data
      
    end
  end
end
