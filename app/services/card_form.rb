class CardForm
  include ActiveModel::Model
  attr_accessor :hands

  def initialize(array=nil)
    @hands = array
  end

  def valid?
    error_messages =[]

    return error_messages << 'カードが重複しています。' if @hands.size - @hands.uniq.size >= 1
    return error_messages << '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）' if @hands.size != 5

    regex = /^([SHDC]{1})(1[0123]|[1-9])$/

    @hands.each_with_index do |hand, i|
      error_messages << "#{i+1}番目のカード指定文字が不正です。（#{hand}）" if hand.scan(regex).empty?
    end

    error_messages << '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' unless error_messages.empty?

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

    serial_number_count = 0
    number_cards = number_cards.map{|num| num.to_i }.sort
    number_cards.each_with_index do |num, i|
      serial_number_count += 1 if number_cards[0]+i == num
    end

    split_cards_count = number_cards.group_by(&:itself).map{ |k, v| [k, v.count] }.to_h

    if suit_cards.uniq.size == 1 && serial_number_count == 5
      return :straight_flush
    end
    if suit_cards.uniq.size == 1 && number_cards == [1, 10, 11, 12, 13]
      return :straight_flush
    end
    return :four_of_a_kind if split_cards_count.values.sort == [1, 4]
    return :full_house if split_cards_count.values.sort == [2, 3]
    return :flush if suit_cards.uniq.size == 1
    return :straight if serial_number_count == 5 || number_cards == [1, 10, 11, 12, 13]
    return :three_of_a_kind if split_cards_count.values.sort == [1, 1, 3]
    return :two_pair if split_cards_count.values.sort == [1, 2, 2]
    return :one_pair if split_cards_count.values.sort == [1, 1, 1, 2]
    return :high_card
  end
end