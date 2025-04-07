class Action < ApplicationRecord
  belongs_to :transaction

  validates :action_type, presence: true
  validates :args, presence: true
end
