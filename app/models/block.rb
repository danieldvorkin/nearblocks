class Block < ApplicationRecord
    has_many :transactions, dependent: :destroy

    validates :height, presence: true, uniqueness: true
    validates :block_hash, presence: true, uniqueness: true
end
