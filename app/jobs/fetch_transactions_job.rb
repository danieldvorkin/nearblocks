class FetchTransactionsJob < ApplicationJob
  queue_as :default
  
  def perform
    Blockchain::TransactionFetcher.new.fetch_transactions
  end
end