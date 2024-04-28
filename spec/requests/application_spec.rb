require 'rails_helper'
require 'shoulda/matchers' 

RSpec.describe Application, type: :model do
    describe Application do
        it { is_expected.to validate_presence_of :name }
      end
end