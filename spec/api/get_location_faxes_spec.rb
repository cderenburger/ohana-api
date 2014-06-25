require 'rails_helper'

describe 'GET /locations/:location_id/faxes' do
  context 'when location has faxes' do
    before :each do
      loc = create(:location)
      @first_fax = loc.faxes.
        create!(attributes_for(:fax))
      get api_endpoint(path: "/locations/#{loc.id}/faxes")
    end

    it 'returns a 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'includes the id attribute in the serialization' do
      expect(json.first['id']).to eq(@first_fax.id)
    end

    it 'includes the number attribute in the serialization' do
      expect(json.first['number']).to eq(@first_fax.number)
    end

    it 'includes the department attribute in the serialization' do
      expect(json.first['department']).to eq(@first_fax.department)
    end
  end

  context "when location doesn't have faxes" do
    before :each do
      loc = create(:location)
      get api_endpoint(path: "/locations/#{loc.id}/faxes")
    end

    it 'returns an empty array' do
      expect(json).to eq([])
    end

    it 'returns a 200 status' do
      expect(response).to have_http_status(200)
    end
  end
end
