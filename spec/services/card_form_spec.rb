require 'rails_helper'

describe CardForm do
  let(:card_form) { CardForm.new }
  let(:straight_flush) { 'C7 C6 C5 C4 C3' }
  let(:four_of_a_kind) { 'C10 D10 H10 S10 D5' }
  let(:full_house) { 'S10 H10 D10 S4 D4' }
  let(:flush) { 'H1 H12 H10 H5 H3' }
  let(:straight) { 'S8 S7 H6 H5 S4' }
  let(:three_of_a_kind) { 'S12 C12 D12 S5 C3' }
  let(:two_pair) { 'H13 D13 C2 D2 H11' }
  let(:one_pair) { 'C10 S10 S6 H4 H2' }
  let(:high_card) { 'D1 D10 S9 C5 C4' }

  describe 'method initialize' do
    context '@hands is present' do
      it 'can set instance variable correctly' do
        card_form.instance_variable_set(:@hands, high_card)
        expect(card_form.instance_variable_get(:@hands)).to eq high_card
      end
    end

    context '@hands is empty' do
      it 'not set instance variable' do
        expect(card_form.instance_variable_get(:@hands)).to eq nil
      end
    end
  end

  describe 'method valid?' do
    it "error_messages has 'カードが重複しています。'" do
      duplicate_hands = ["C7", "C7", "C5", "C4", "C3"]
      card_form.instance_variable_set(:@hands, duplicate_hands)
      expect(card_form.valid?.include?('カードが重複しています。')).to be true
    end

    it "error_messages has '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'"  do
      more_than_five_hands = ["C7", "C6", "C5", "C4", "C3", "H5"]
      card_form.instance_variable_set(:@hands, more_than_five_hands)
      expect(card_form.valid?.include?('5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）')).to be true
      expect(card_form.valid?.size).to be 1
    end

    it "error_messages has 'n番目のカード指定文字が不正です。'" do
      invalid_hands = ["K7", "H63", "T59", "L4", "C30"]
      card_form.instance_variable_set(:@hands, invalid_hands)
      invalid_hands.each_with_index do |hand, i|
        expect(card_form.valid?.include?("#{i+1}番目のカード指定文字が不正です。（#{hand}）")).to eq true
      end
    end

    it "first error in error_messages has '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'" do
      invalid_hands = ["K7", "H63", "T59", "L4", "C30"]
      card_form.instance_variable_set(:@hands, invalid_hands)
      expect(card_form.valid?[0]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
    end

    it "error_messages has nothing" do
      card_form.instance_variable_set(:@hands, high_card.split)
      expect(card_form.valid?).to be_empty
    end
  end

  describe 'method check_hands' do

    it "check_hands is 'ストレートフラッシュ'" do
      card_form.instance_variable_set(:@hands, straight_flush.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands).to eq 'ストレートフラッシュ'
    end

    it "check_hands is 'フォー・オブ・ア・カインド'" do
      card_form.instance_variable_set(:@hands, four_of_a_kind.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'フォー・オブ・ア・カインド'
    end

    it "check_hands is 'フルハウス'" do
      card_form.instance_variable_set(:@hands, full_house.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'フルハウス'
    end

    it "check_hands is 'フラッシュ'" do
      card_form.instance_variable_set(:@hands, flush.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'フラッシュ'
    end

    it "check_hands is 'ストレート'" do
      card_form.instance_variable_set(:@hands, straight.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'ストレート'
    end

    it "check_hands is 'スリー・オブ・ア・カインド'" do
      card_form.instance_variable_set(:@hands, three_of_a_kind.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'スリー・オブ・ア・カインド'
    end

    it "check_hands is 'ツーペア'" do
      card_form.instance_variable_set(:@hands, two_pair.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'ツーペア'
    end

    it "check_hands is 'ワンペア'" do
      card_form.instance_variable_set(:@hands, one_pair.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'ワンペア'
    end

    it "check_hands is 'ハイカード'" do
      card_form.instance_variable_set(:@hands, high_card.split)
      expect(card_form.valid?).to be_empty
      expect(card_form.check_hands). to eq 'ハイカード'
    end
  end
end