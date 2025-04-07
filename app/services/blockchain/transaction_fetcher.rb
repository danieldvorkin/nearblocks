require 'httparty'

module Blockchain
  class TransactionFetcher
    include HTTParty

    def initialize
      @api_endpoint = ENV['NEAR_API_ENDPOINT']
      @api_key = ENV['NEAR_API_KEY']
    end

    def fetch_transactions
      response = self.class.get("#{@api_endpoint}?api_key=#{@api_key}", headers: headers)
      
      if response.success?
        transactions = JSON.parse(response.body)

        transactions.each do |transaction|
          process_transaction(transaction)
        end
      else
        Rails.logger.error("Failed to fetch transactions: #{response.code} - #{response.message}")
      end
    rescue StandardError => e
      Rails.logger.error("Error fetching transactions: #{e.message}")
    end

    private
    
    def headers
      {
        'Content-Type' => 'application/json'
      }
    end

    def process_transaction(transaction)
      puts "Processing transaction: #{transaction['hash']}"
    end
  end
end