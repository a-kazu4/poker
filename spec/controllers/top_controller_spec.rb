require 'rails_helper'

describe TopController, type: :controller do

  describe 'GET #new' do
    let(:card_form) { CardForm.new }

    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq 200
    end

    it 'assigns the requested card_form to @card_form' do
      get :new
      expect(assigns :card_form).to_not be_nil
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #judge' do
    let(:card_form) { CardForm.new() }

    context 'normal' do
      it 'has a 302 status code' do
        hands = 'C7 C6 C5 C4 C3'
        post :judge, params: { card_form: { hands: hands } }
        expect(response.status).to eq 302
      end

      it 'assigns the requested card_form to @card_form' do
        hands = 'C7 C6 C5 C4 C3'
        post :judge, params: { card_form: { hands: hands } }
        expect(assigns :card_form).to_not be_nil
      end

      it 'can redirect to top_path' do
        hands = 'C7 C6 C5 C4 C3'
        post :judge, params: { card_form: { hands: hands } }
        expect(response).to redirect_to top_path
      end
    end

    context 'abnormal' do
      it 'has a 200 status code' do
        hands = 'C7 C6 C5 C4 C3 K11'
        post :judge, params: { card_form: { hands: hands } }
        expect(response.status).to eq 200
      end
    end
  end
end