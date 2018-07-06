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
    error_messages.unshift('5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）') unless error_messages.empty?

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
      return 'ストレートフラッシュ'
    end
    if suit_cards.uniq.size == 1 && number_cards == [1, 10, 11, 12, 13]
      return 'ストレートフラッシュ'
    end
    return 'フォー・オブ・ア・カインド' if split_cards_count.values.include?(4)
    return 'フルハウス' if split_cards_count.values.sort & [2, 3] == [2, 3]
    return 'フラッシュ' if suit_cards.uniq.size == 1
    return 'ストレート' if serial_number_count == 5 || number_cards == [1, 10, 11, 12, 13]
    return 'スリー・オブ・ア・カインド' if split_cards_count.values.include?(3)
    return 'ツーペア' if split_cards_count.values.sort == [1, 2, 2]
    return 'ワンペア' if split_cards_count.values.sort == [1, 1, 1, 2]
    return 'ハイカード'
  end
end