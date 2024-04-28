require 'rails_helper'
require 'shoulda/matchers' 

RSpec.describe Application, type: :model do
    describe Application do
        it { should validate_presence_of(:name).on(:create) }
      end
end