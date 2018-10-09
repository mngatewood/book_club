require 'rails_helper'

describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do

  end
end