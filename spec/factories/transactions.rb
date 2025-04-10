FactoryBot.define do
  factory :transaction do
    hash { SecureRandom.hex(10) }
    sender { "sender_#{SecureRandom.hex(5)}" }
    receiver { "receiver_#{SecureRandom.hex(5)}" }
    block_id { block_id } # Allows passing the block_id directly
    created_at { Time.current }

    after(:build) do |transaction|
      puts transaction.inspect
      puts transaction.block.id
      # puts "Transaction block: #{transaction.block.inspect}"
    end
  end
end