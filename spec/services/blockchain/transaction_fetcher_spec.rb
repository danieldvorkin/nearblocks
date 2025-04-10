require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Blockchain::TransactionFetcher do
  let(:api_endpoint) { 'https://api.near.org/txns' }
  let(:api_key) { 'test-api-key' }
  let(:fetcher) { described_class.new }

  before do
    stub_const('ENV', ENV.to_hash.merge(
      'NEAR_API_ENDPOINT' => api_endpoint,
      'NEAR_API_KEY' => api_key
    ))
  end

  describe '#fetch_transactions' do
    context 'when API returns successful response' do
      let(:tx_data) do
        [{
          'hash' => 'abc123',
          'sender' => 'alice.near',
          'receiver' => 'bob.near',
          'block_hash' => 'blockxyz',
          'height' => 42,
          'time' => '2024-01-01T12:00:00Z',
          'actions' => [
            { 'type' => 'TRANSFER', 'data' => { 'amount' => 1000, 'token' => 'NEAR' } },
            { 'type' => 'STAKE', 'data' => { 'amount' => 500, 'validator' => 'validator.near' } }
          ]
        }]
      end

      let(:parsed_time) { Time.parse('2024-01-01T12:00:00Z') }

      before do
        stub_request(:get, api_endpoint)
          .with(query: { api_key: api_key })
          .to_return(status: 200, body: tx_data.to_json, headers: { 'Content-Type' => 'application/json' })

        # Stubbing Block model
        block = instance_double(Block, id: 1, block_hash: 'blockxyz', height: 42, created_at: parsed_time)
        allow(Block).to receive(:find_or_create_by).with(block_hash: 'blockxyz').and_return(block)

        # Stubbing Transaction model
        txn = instance_double(Transaction, id: 1, hash: 'abc123', sender: 'alice.near', receiver: 'bob.near', created_at: parsed_time)
        allow(Transaction).to receive(:find_or_create_by).with(hash: 'abc123').and_return(txn)

        # Stubbing Action model
        action = instance_double(Action, id: 1, action_type: 'TRANSFER', args: { 'amount' => '1000', 'token' => 'NEAR' })
        allow(Action).to receive(:find_or_create_by!).with(transaction_id: 1, action_type: 'TRANSFER').and_return(action)
        # Stubbing second action
        second_action = instance_double(Action, id: 2, action_type: 'STAKE', args: { 'amount' => '500', 'validator' => 'validator.near' })
        allow(Action).to receive(:find_or_create_by!).with(transaction_id: 1, action_type: 'STAKE').and_return(second_action)
      end

      it 'returns array of processed transactions with expected attributes' do
        result = fetcher.fetch_transactions

        expect(result).to be_an(Array)
        expect(result.size).to eq(1)

        txn = result.first
        expect(txn.hash).to eq('abc123')
        expect(txn.sender).to eq('alice.near')
        expect(txn.receiver).to eq('bob.near')
        expect(txn.created_at.to_s).to eq(parsed_time.to_s)

        expect(Block).to have_received(:find_or_create_by).with(block_hash: 'blockxyz')
        expect(Transaction).to have_received(:find_or_create_by).with(hash: 'abc123')
        expect(Action).to have_received(:find_or_create_by!).with(
          transaction_id: kind_of(Integer),
          action_type: 'TRANSFER'
        )
        expect(Action).to have_received(:find_or_create_by!).with(
            transaction_id: kind_of(Integer),
            action_type: 'STAKE'
        )
      end
    end

    context 'when API returns error' do
      before do
        stub_request(:get, api_endpoint)
          .with(query: { api_key: api_key })
          .to_return(status: 500, body: 'Internal Server Error')
      end

      it 'returns an empty array and logs error' do
        expect(Rails.logger).to receive(:error).with(/Failed to fetch transactions/)

        result = fetcher.fetch_transactions
        expect(result).to eq([])
      end
    end

    context 'when an exception is raised' do
      before do
        allow(described_class).to receive(:get).and_raise(StandardError.new('network issue'))
      end

      it 'rescues the error and returns an empty array' do
        expect(Rails.logger).to receive(:error).with(/Error fetching transactions/)

        result = fetcher.fetch_transactions
        expect(result).to eq([])
      end
    end
  end
end
