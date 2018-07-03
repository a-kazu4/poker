class CardForm
  include ActiveModel::Model
  attr_accessor :hands

  def initialize(array=nil)
    @hands = array
  end

  def valid?
    error_messages =[]

    if @hands.size != 5
      error_messages << "5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"
    end

    if @hands.size - @hands.uniq.size >= 1
      error_messages << 'カードが重複しています。'
    end

    regex = /([SHDC]{1})(1[0123]|[1-9])$/

    @hands.each_with_index do |hand, i|
      if hand.scan(regex).empty?
        error_messages << "#{i+1}番目のカード指定文字が不正です。（#{hand}）"
      end
    end

    return error_messages
  end

  def check_hands
    suit_cards = []
    number_cards = []

    @hands.each_with_index do |hand, i|
      hand = hand.split(/([SHDC]{1})/)
      hand.delete_at(0)
      suit_cards << hand[0]
      number_cards << hand[1]
    end

    number_cards = number_cards.map{|num| num.to_i }.sort


    return 'フラッシュ' if suit_cards.uniq.size == 1

    count = 0
    number_cards.each_with_index do |num, i|
      count += 1 if number_cards[0]+i == num
    end
    return 'ストレート' if count == 5

    split_cards_count = number_cards.group_by(&:itself).map{ |k, v| [k, v.count] }.to_h
    return 'フォー・オブ・ア・カインド' if split_cards_count.values.include?(4)
    return 'フルハウス' if split_cards_count.values.sort & [2, 3] == [2, 3]
    return 'スリーカード' if split_cards_count.values.include?(3)
    return 'ツーペア' if split_cards_count.values.sort == [1, 2, 2]
    return 'ワンペア' if split_cards_count.values.sort == [1, 1, 1, 2]
    return 'ハイカード'

  end
end