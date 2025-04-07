class TransfersController < ApplicationController
  def index
    FetchTransactionsJob.perform_later
    
    @transfers = if params[:action_type].present?
             Transaction.joins(:actions)
                  .where(actions: { action_type: params[:action_type] })
                  .includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
                  .paginate(page: params[:page], per_page: 10)
           else
             Transaction.joins(:actions)
                  .includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
                  .paginate(page: params[:page], per_page: 10)
           end
  end
end
