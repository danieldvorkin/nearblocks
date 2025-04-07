class Transaction < ApplicationRecord
  belongs_to :block
  has_many :actions, dependent: :destroy

  validates :hash, presence: true, uniqueness: true
  validates :signer_id, :receiver_id, presence: true
end
