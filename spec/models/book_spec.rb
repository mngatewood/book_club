require 'rails_helper'

describe Book, type: :model do

  describe 'Validations' do
  end

  describe 'Relationships' do
    it { should have_many(:reviews) }
  end
end