require 'httparty'

module Blockchain
  class TransactionFetcher
    include HTTParty

    def initialize
      @api_endpoint = ENV['NEAR_API_ENDPOINT']
      @api_key = ENV['NEAR_API_KEY']
    end

    def fetch_transactions
      response = self.class.get(@api_endpoint, query: { api_key: @api_key }, headers: headers)
      
      if response.success?
        transactions = response.parsed_response
        process_transactions(transactions)
      else
        Rails.logger.error("Failed to fetch transactions: #{response.code} - #{response.message}")
        []
      end
    rescue StandardError => e
      Rails.logger.error("Error fetching transactions: #{e.message}")
      []
    end

    private
    
    def headers
      {
        'Content-Type' => 'application/json'
      }
    end

    def process_transactions(transactions)
      return [] unless transactions.is_a?(Array)
      
      result = []
      
      transactions.each do |tx|
        transaction = process_transaction(tx)
        result << transaction if transaction
      end
      
      result
    end

    def process_transaction(tx)
      return nil unless tx.present?

      begin
        # Try to parse the timestamp
        created_at = Time.parse(tx['time'] || tx['created_at']) rescue Time.current

        # Process block outside of transaction to isolate issues
        block = Block.find_or_create_by(block_hash: tx['block_hash']) do |b|
          b.height = tx['height'].to_i  # Ensure height is an integer
          b.created_at = created_at
        end

        # Process transaction outside of transaction to isolate issues
        txn = Transaction.find_or_create_by(hash: tx['hash']) do |t|
          t.sender = tx['sender'].to_s
          t.receiver = tx['receiver'].to_s
          t.block_id = block.id  # Use block_id directly
          t.created_at = created_at
        end

        # Process actions separately
        process_actions(tx, txn) if txn

        # Log the transaction processing
        Rails.logger.info("Processed transaction: #{tx['hash']} in block: #{tx['block_hash']}")
        
        txn
      rescue => e
        Rails.logger.error("Failed to process transaction #{tx['hash']}: #{e.message}")
        nil
      end
    end

    def process_actions(tx, transaction)
      return unless tx['actions'].is_a?(Array)
      
      tx['actions'].each do |action|
        begin
          # Handle action data carefully
          action_type = action['type'].to_s
          
          # Convert action data to a safe format for jsonb
          action_data = {}
          if action['data'].is_a?(Hash)
            action['data'].each do |k, v|
              action_data[k.to_s] = v.to_s
            end
          end
          
          # Create action with explicit attributes
          Action.find_or_create_by!(
            transaction_id: transaction.id,
            action_type: action_type
          ) do |a|
            a.args = action_data
          end
        rescue => e
          Rails.logger.error("Failed to create action for txn #{transaction.hash}: #{e.message}")
          Rails.logger.error("Action data: #{action.inspect}")
          # Don't re-raise, so other actions can be processed
        end
      end
    end
  end
end