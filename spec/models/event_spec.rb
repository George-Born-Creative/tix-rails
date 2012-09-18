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
#  account_id             :integer          default(0), not null
#  chart                  :string(255)
#  artist_id_old          :integer
#  cat                    :string(255)
#

require 'spec_helper'

describe Event do


  it "should set_default_times" do# called before save
    now = DateTime.now
    e = Event.new(:starts_at => now)
    e.save
    e.announce_at.should eq now
    e.on_sale_at.should eq now
    e.off_sale_at.should eq e.starts_at + 3.hours
    e.remove_at.should eq e.starts_at + 3.hours
    
  end

  
end
