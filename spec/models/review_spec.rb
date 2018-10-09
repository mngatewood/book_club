require 'rails_helper'

describe Review, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:review) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end