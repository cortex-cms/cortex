# == Schema Information
#
# Table name: tenants
#
#  id            :integer          not null, primary key
#  name          :string(50)       not null
#  subdomain     :string(50)
#  parent_id     :integer
#  lft           :integer
#  rgt           :integer
#  depth         :integer
#  contact_name  :string(50)
#  contact_email :string(200)
#  contact_phone :string(20)
#  deleted_at    :datetime
#  contract      :string(255)
#  did           :string(255)
#  active_at     :datetime
#  deactive_at   :datetime
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Tenant do
end
