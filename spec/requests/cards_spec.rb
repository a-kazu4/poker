require 'rails_helper'

describe 'API_Cards', type: :request do
  describe 'POST /api/v1/cards/check' do
    let(:valid_path) { '/api/v1/cards/check' }
    let(:invalid_path) { '/api/v1' }
    let(:valid_params) { { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] } }

    context 'normal' do
      it 'has a 201 status code' do
        post valid_path, params: valid_params
        expect(response.status).to eq 201
      end
    end

    context 'abnormal' do
      it 'has a 500 status code with invalid_path' do
        post invalid_path, params: valid_params
        expect(response.status).to eq 500
        expect(response.body).to eq "{\"error\":[{\"msg\":\"不正なURLです。\"}]}"
      end
    end
  end
end