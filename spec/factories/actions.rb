FactoryBot.define do
  factory :action do
    association :transaction
    action_type { 'TRANSFER' }
    args { { amount: '1000', token: 'NEAR' } }
  end
end