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

# TO TEST:
# times, associated acts, strings

require 'spec_helper'

describe Event do

  before :each do
    Account.destroy_all
    Event.destroy_all
  end
  
  it 'has a valid factory' do
    FactoryGirl.build_stubbed(:event).should be_valid
  end
  
  it 'is invalid with account' do
    FactoryGirl.build_stubbed(:event, account: nil).should_not be_valid
  end
  
  
  
end
