FactoryBot.define do
    factory :chat do
        name {'Test Application'}
        number {Random.rand(1000)}
    end
  end