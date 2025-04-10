FactoryBot.define do
  factory :block do
    sequence(:height) { |n| n.to_i }  # Ensures uniqueness of the height
    sequence(:block_hash) { |n| "blockhash#{n}#{SecureRandom.hex(6)}" }  # Ensures uniqueness of the block_hash
    created_at { Time.current }
  end
end