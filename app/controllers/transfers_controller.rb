class TransfersController < ApplicationController
  def index
    # Schedule API sync job if needed
    if !Rails.cache.exist?('fetch_transactions_job_ran')
      Rails.logger.info "Scheduling FetchTransactionsJob"
      FetchTransactionsJob.perform_later
      Rails.cache.write('fetch_transactions_job_ran', true, expires_in: 1.minute)
    else
      Rails.logger.info "FetchTransactionsJob Cached - not running api sync"
    end
    
    # 1. joins is for filtering: It ensures that the SQL query includes the actions table so that the where condition can be applied.
    # 2. includes is for performance: It preloads the actions association to reduce the number of database queries when accessing actions later.
    # 3. Combining them: Using both joins and includes allows you to filter records based on the actions table while also optimizing performance when accessing the actions data.
    @transfers = if params[:action_type].present?
             Transaction.joins(:actions)
                  .where(actions: { action_type: params[:action_type] })
                  .includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
                  .paginate(page: params[:page], per_page: 10)
           else
             Transaction.includes(actions: [])
                  .order(created_at: :desc)
                  .distinct
                  .paginate(page: params[:page], per_page: 10)
           end
  end
end
