class Action < ApplicationRecord
  belongs_to :txn, class_name: 'Transaction', foreign_key: 'transaction_id'

  validates :action_type, presence: true
end
