require 'spec_helper'

describe Folder, 'Validations' do
  it { should validate_presence_of(:user_id) }
end

describe Folder, 'Associations' do
  it { should belong_to(:user) }
  it { should have_many(:posts) }
end
