class Transaction < ApplicationRecord
  belongs_to :block
  has_many :actions, foreign_key: 'transaction_id', dependent: :destroy

  validates :hash, presence: true, uniqueness: true
  validates :sender, :receiver, presence: true
end
