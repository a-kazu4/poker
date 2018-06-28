puts "ポーカーの手を入力してください"

input = gets.chomp
# regex = /(([SHDC]{1})(1[0123]|[1-9]) ){4}(([SHDC]{1})(1[0123]|[1-9]))$/
# p regex.match(input)

cards = input.split(' ')

if cards.size != 5
  puts "5つのカード指定文字を半角スペース区切りで入力してください。（例：\"S1 H3 D9 C13 S11\"）"
end

if cards.size - cards.uniq.size >= 1
  puts 'カードが重複しています。'
end

regex = /([SHDC]{1})(1[0123]|[1-9])$/

suit_cards = []
number_cards = []

cards.each_with_index do |card, i|
  if card.scan(regex).empty?
    puts "#{i+1}番目のカード指定文字が不正です。（#{card}）"
  end
  card = card.split(/([SHDC]{1})/)
  card.delete_at(0)
  card
  suit_cards << card[0]
  number_cards << card[1]
end

p suit_cards
p number_cards

if suit_cards.uniq.size == 1
  puts 'フラッシュ'
end

sort_number_cards = number_cards.sort
p sort_number_cards
sort_number_cards.each_with_index do |num, i|
  p "#{i}回目"
end


split_cards_count = number_cards.group_by(&:itself).map{ |k, v| [k, v.count] }.to_h
p split_cards_count
p split_cards_count["2"]
