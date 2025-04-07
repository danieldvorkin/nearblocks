class TransfersController < ApplicationController
  def index
    FetchTransactionsJob.perform_later
    
    @transfers = if params[:action_type].present?
             Transaction.joins(:actions)
                  .where(actions: { action_type: params[:action_type] })
                  .includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
           else
             Transaction.joins(:actions)
                  .includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
           end
  end
end
