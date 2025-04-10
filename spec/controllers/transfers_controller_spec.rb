require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  describe 'GET #index' do
    let!(:block) { create(:block) }
    let!(:transaction1) { create(:transaction, block_id: block.id.to_s.to_i, created_at: 2.days.ago) }
    let!(:transaction2) { create(:transaction, block: block, created_at: 1.day.ago) }
    let!(:action1) { create(:action, transaction: transaction1, action_type: 'transfer') }
    let!(:action2) { create(:action, transaction: transaction2, action_type: 'stake') }

    before do
      allow(FetchTransactionsJob).to receive(:perform_later)
    end

    context 'when action_type is provided' do
      it 'filters transactions by action_type' do
        get :index, params: { action_type: 'transfer' }

        expect(assigns(:transfers)).to match_array([transaction1])
        expect(FetchTransactionsJob).to have_received(:perform_later)
      end
    end

    context 'when action_type is not provided' do
      it 'returns all transactions ordered by created_at' do
        get :index

        expect(assigns(:transfers)).to eq([transaction2, transaction1])
        expect(FetchTransactionsJob).to have_received(:perform_later)
      end
    end

    context 'pagination' do
      it 'paginates the results' do
        # create_list(:transaction, 15)
        get :index, params: { page: 1, per_page: 10 }

        expect(assigns(:transfers).size).to eq(10)
      end
    end
  end
end