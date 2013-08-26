# == Schema Information
#
# Table name: events
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  headline               :string(255)
#  supporting_act         :text
#  body                   :text
#  starts_at              :datetime
#  ends_at                :datetime
#  chart_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  headliner_id           :integer
#  secondary_headliner_id :integer
#  supporting_act_1       :string(255)
#  supporting_act_2       :string(255)
#  supporting_act_3       :string(255)
#  info                   :text
#  set_times              :text
#  price_freeform         :string(255)
#  account_id             :integer          not null
#  chart                  :string(255)
#  artist_id_old          :integer
#  cat                    :string(255)
#  announce_at            :datetime
#  on_sale_at             :datetime
#  off_sale_at            :datetime
#  remove_at              :datetime
#  buytix_url_old         :string(255)
#  slug                   :string(255)
#  disable_event_title    :boolean          default(FALSE)
#  external_ticket_url    :string(255)
#  sold_out               :boolean
#  free_event             :boolean
#  hide_buttons           :boolean
#

require 'spec_helper'

describe Event do


  pending "should set_default_times" do# called before save
    # now = DateTime.now
    # e = Event.new(:starts_at => now)
    # e.save
    # e.announce_at.should eq now
    # e.on_sale_at.should eq now
    # e.off_sale_at.should eq e.starts_at + 3.hours
    # e.remove_at.should eq e.starts_at + 3.hours
  end

  
end
