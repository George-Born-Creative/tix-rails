# == Schema Information
#
# Table name: ticket_templates
#
#  id                :integer          not null, primary key
#  label             :string(255)
#  meta              :string(255)
#  times_used        :integer          default(0), not null
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

require 'spec_helper'

describe TicketTemplate do
  pending "add some examples to (or delete) #{__FILE__}"
end
