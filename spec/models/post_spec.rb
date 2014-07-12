require 'spec_helper'

describe Post, 'Validations' do
  it { should validate_presence_of(:user_id) }
end

describe Post, 'Associations' do
	it { should belong_to(:user) }
	it { should have_many(:likes) }
end
