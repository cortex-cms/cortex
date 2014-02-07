require 'spec_helper'

describe User do
  it 'has a valid factory' do
    create(:user).should be_valid
  end

  context 'validity' do
    let(:user) { create(:user) }
      
    it 'is invalid without an email' do
      user.email = nil
      user.should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  created_at             :datetime
#  updated_at             :datetime
#  tenant_id              :integer          not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#
