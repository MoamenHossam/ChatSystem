FactoryBot.define do
    factory :application do
        name {'Test Application'}
        token {Application.new.generate_token}
    end
  end