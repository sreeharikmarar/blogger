require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it {
      should validate_length_of(:name)
        .is_at_least(3)
    }

    it { should have_secure_password(:password) }
 
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }
  end
end
