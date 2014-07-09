require 'spec_helper'

describe Event, 'Validations' do
it { should validate_presence_of(:user_id) }
end

describe Event, 'Associations' do
	it { should belong_to(:user) }
	it { should have_many(:likes) }
end
