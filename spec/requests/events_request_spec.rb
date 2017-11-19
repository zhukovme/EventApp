require 'rails_helper'

RSpec.describe 'Events request', type: :request do
  let(:route) { '/api/events' }

  describe 'GET #index' do
    shared_examples_for 'with empty database' do
      let(:params) { {} }
      it 'reneders empty array' do
        get route, params: params
        expect(response).to be_success
        expect(response.body).to eq({ events: [] }.to_json)
      end
    end

    shared_examples_for 'without params' do
      let(:params) { {} }
      it 'reneders all events' do
        events = FactoryBot.create_list(:event_full, 6)
        events.map!(&:preview_attributes)
        get route, params: params
        expect(response).to be_success
        expect(response.body).to eq({ events: events }.to_json)
      end
    end

    shared_examples_for 'with date param' do
      it 'renders events by date' do
        FactoryBot.create_list(:event_not_today, 6)
        events = FactoryBot.create_list(:event_today, 6)
        events.map!(&:preview_attributes)
        get route, params: { date: date }
        expect(response).to be_success
        expect(response.body).to eq({ events: events }.to_json)
      end
    end

    shared_examples_for 'with categories param' do
      it 'renders events by categories' do
        FactoryBot.create_list(:event_full, 6)
        events = []
        categories.each do |category|
          events << FactoryBot.create(:event_full, category: category.strip)
        end
        events.map!(&:preview_attributes)
        get route, params: { categories: categories }
        expect(response).to be_success
        expect(response.body).to eq({ events: events }.to_json)
      end
    end

    shared_examples_for 'with limit param' do
      it 'renders events by limit' do 
        events = FactoryBot.create_list(:event_full, 6)
        events.map!(&:preview_attributes)
        events = events.take(limit.strip.to_i)
        get route, params: { limit: limit }
        expect(response).to be_success
        expect(response.body).to eq({ events: events }.to_json)
      end
    end

    context 'without params and empty database' do
      it_should_behave_like 'with empty database'
    end

    context 'without params' do
      it_should_behave_like 'without params'
    end

    context 'with valid date' do
      it_should_behave_like 'with date param' do
        let(:date) { Time.zone.now.strftime('%d.%m.%Y') }
      end
    end

    context 'with valid date surrounded by spaces' do
      it_should_behave_like 'with date param' do
        let(:date) { "   #{Time.zone.now.strftime('%d.%m.%Y')}  " }
      end
    end

    context 'with invalid date' do
      it_should_behave_like 'without params' do
        let(:params) { { date: '19.44.2017' } }
      end
    end

    context 'with invalid numeric date' do
      it_should_behave_like 'without params' do
        let(:params) { { date: '666' } }
      end
    end

    context 'with invalid string date' do
      it_should_behave_like 'without params' do
        let(:params) { { date: 'qwe' } }
      end
    end

    context 'with empty date' do
      it_should_behave_like 'without params' do
        let(:params) { { date: '' } }
      end
    end

    context 'with valid category' do
      it_should_behave_like 'with categories param' do
        let(:categories) { ['test'] }
      end
    end

    context 'with valid category suurounded by spaces' do
      it_should_behave_like 'with categories param' do
        let(:categories) { ['   test '] }
      end
    end

    context 'with valid categories' do
      it_should_behave_like 'with categories param' do
        let(:categories) { ['test', 'test_2'] }
      end
    end

    context 'with valid categories surrounded bu spaces' do
      it_should_behave_like 'with categories param' do
        let(:categories) { ['  test ', ' test_2 '] }
      end
    end

    context 'with non existing categories' do
      it_should_behave_like 'with empty database' do
        let(:params) { { categories: ['iddqd', 'idkfa'] } }
      end
    end

    context 'with empty categories' do
      it_should_behave_like 'with empty database' do
        let(:params) { { categories: [] } }
      end
    end

    context 'with positive limit in params' do
      it_should_behave_like 'with limit param' do
        let(:limit) { '3' }
      end
    end

    context 'with positive limit in params surrounded by spaces' do
      it_should_behave_like 'with limit param' do
        let(:limit) { '  3   ' }
      end
    end

    context 'with negative limit in params' do
      it_should_behave_like 'without params' do
        let(:params) { { limit: '-3' } }
      end
    end

    context 'with string limit in params' do
      it_should_behave_like 'without params' do
        let(:params) { { limit: 'asd' } }
      end
    end

    context 'with empty limit in params' do
      it_should_behave_like 'without params' do
        let(:params) { { limit: '' } }
      end
    end

    context 'with all possible params' do
      let(:date) { Time.zone.now.strftime('%d.%m.%Y') }
      let(:categories) { ['test', 'conference', 'test_2'] }
      let(:limit) { '2' }
      let(:params) { { date: date, categories: categories, limit: limit } }
      it 'renders events by requested params' do 
        FactoryBot.create_list(:event_not_today, 6)
        events = []
        categories.each do |category|
          events << FactoryBot.create(:event_today, category: category)
        end
        events.map!(&:preview_attributes)
        events = events.take(limit.strip.to_i)
        get route, params: params
        expect(response).to be_success
        expect(response.body).to eq({ events: events }.to_json)
      end
    end
  end

  describe 'GET #show' do
    context 'requested id exists' do
      it 'renders event' do
        event = FactoryBot.create(:event_full)
        get route + "/#{event.id}"
        expect(response).to be_success
        expect(response.body).to eq({ event: event }.to_json)
      end
    end

    context 'requested id does not exist' do
      it 'renders an error' do
        get route + '/11'
        expect(response).to be_not_found
        expect(response.body).to eq({ reason: :not_found }.to_json)
      end
    end
  end

  describe 'POST #create' do
    shared_examples_for 'valid params' do
      it 'creates an event' do
        expect {
          post route, params: { event: event }
        }.to change { Event.count }
        expect(response).to be_success
      end
    end

    shared_examples_for 'invalid params' do
      it 'renders an error' do
        expect {
          post route, params: { event: event }
        }.not_to change { Event.count }
        expect(response).to be_bad_request
      end
    end

    context 'with required params only' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event) }
      end
    end

    context 'with all possible params' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event_full) }
      end
    end

    context 'with required plus unwanted params' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event_with_unwanted) }
      end
    end

    context 'without required params' do
      it_should_behave_like 'invalid params' do
        let(:event) { FactoryBot.attributes_for(:event_without_required) }
      end
    end

    context 'with null required params' do
      it_should_behave_like 'invalid params' do
        let(:event) { FactoryBot.attributes_for(:event_with_null_required) }
      end
    end

    context 'with empty required params' do
      it_should_behave_like 'invalid params' do
        let(:event) { FactoryBot.attributes_for(:event_empty_required) }
      end
    end
  end

  describe 'PUT #update' do
    shared_examples_for 'valid params' do
      it 'updates an event' do
        event_db = FactoryBot.create(:event)
        put route + "/#{event_db.id}", params: { event: event }
        # expect {
        # }.to change { Event.count }
        expect(response).to be_success
      end
    end

    shared_examples_for 'invalid params' do
      it 'renders an error' do
        event_db = FactoryBot.create(:event)
        put route + "/#{event_db.id}", params: { event: event }
        # expect {
        # }.not_to change { Event.count }
        expect(response).to be_bad_request
      end
    end

    shared_examples_for 'event not found' do
      it 'renders an error' do
        put route + "/14", params: { event: event }
        # expect {
        # }.not_to change { Event.count }
        expect(response).to be_not_found
      end
    end

    context 'with required params only' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event) }
      end
    end

    context 'with all possible params' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event_full) }
      end
    end

    context 'with required plus unwanted params' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event_with_unwanted) }
      end
    end

    context 'without required params' do
      it_should_behave_like 'valid params' do
        let(:event) { FactoryBot.attributes_for(:event_without_required) }
      end
    end

    context 'with null required params' do
      it_should_behave_like 'invalid params' do
        let(:event) { FactoryBot.attributes_for(:event_with_null_required) }
      end
    end

    context 'with empty required params' do
      it_should_behave_like 'invalid params' do
        let(:event) { FactoryBot.attributes_for(:event_empty_required) }
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'requested id exists' do
      it 'deletes an event by id' do
        event = FactoryBot.create(:event_full)
        expect {
          delete route + "/#{event.id}"
        }.to change { Event.count }
        expect(response).to be_success
      end
    end

    context 'requested id does not exist' do
      it 'renders an error' do
        expect {
          delete route + "/12"
        }.not_to change { Event.count }
        expect(response).to be_not_found
      end
    end
  end
end
