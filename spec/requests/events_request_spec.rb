require 'rails_helper'

RSpec.describe 'Events request', type: :request do

  describe 'POST #create' do
    let(:route) { '/api/events' }

    shared_examples_for "valid attributes" do
      it 'creates an event' do
        expect {
          post route, params: { event: event }
        }.to change { Event.count }
        expect(response).to have_http_status(:ok)
      end
    end

    shared_examples_for "invalid attributes" do
      it 'does not create an event' do
        expect {
          post route, params: { event: event }
        }.not_to change { Event.count }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with required attributes only' do
      it_should_behave_like "valid attributes" do
        let(:event) { FactoryBot.attributes_for(:event) }
      end
    end

    context 'with all possible attributes' do
      it_should_behave_like "valid attributes" do
        let(:event) { FactoryBot.attributes_for(:event_full) }
      end
    end

    context 'without required attributes' do
      it_should_behave_like "invalid attributes" do
        let(:event) { FactoryBot.attributes_for(:event_without_required) }
      end
    end

    context 'with empty required attributes' do
      it_should_behave_like "invalid attributes" do
        let(:event) { FactoryBot.attributes_for(:event_empty_required) }
      end
    end
  end
end
