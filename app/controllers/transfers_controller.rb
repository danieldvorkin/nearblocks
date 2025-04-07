class TransfersController < ApplicationController
  def index
    FetchTransactionsJob.perform_later
    
    @transfers = Transaction.joins(:actions)
                           .where(actions: { action_type: 'Transfer' })
                           .includes(actions: [])
                           .order(created_at: :desc)
                           .distinct
  end
end
