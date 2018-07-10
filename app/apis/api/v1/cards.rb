module API
  module V1
    class Cards < Grape::API
      desc 'Return hands'
      resource :cards do
        post 'check' do
          judge_results = {}
          errors = []
          results = []
          strength_array = []
          strength_of_hands = { "ストレートフラッシュ" => 1,
                                "フォー・オブ・ア・カインド" => 2,
                                "フルハウス" => 3,
                                "フラッシュ" => 4,
                                "ストレート" => 5,
                                "スリー・オブ・ア・カインド" => 6,
                                "ツーペア" => 7,
                                "ワンペア" => 8,
                                "ハイカード" => 9,
                              }

          cards = params[:cards]

          cards.each do |card|
            split_card = card.split
            card_form = CardForm.new(split_card)

            error_messages = card_form.valid?

            if error_messages.empty?
              result_hash = {}

              result_hash[:card] = card
              result_hash[:hand] = card_form.check_hands

              strength_num = strength_of_hands[result_hash[:hand]]
              strength_array << strength_num

              results.push(result_hash)
            else
              error_messages.each do |msg|
                error_hash = {}

                error_hash[:card] = card
                error_hash[:msg] = msg

                errors.push(error_hash)
              end
            end
          end

          unless results.empty?
            results.each do |result|
              if strength_array.min == strength_of_hands[result[:hand]]
                result[:best] = true
              else
                result[:best] = false
              end
            end
          end

          judge_results[:result] = results unless results.empty?
          judge_results[:error] = errors unless errors.empty?

          return judge_results
        end
      end
    end
  end
end
