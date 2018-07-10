module API
  module V1
    class Cards < Grape::API
      desc 'Return hands'
      include CardHelper
      resource :cards do
        post 'check' do
          judge_results = {}
          errors = []
          results = []
          strength_array = []
          
          cards = params[:cards]

          cards.each do |card|
            split_card = card.split
            card_form = CardForm.new(split_card)

            error_messages = card_form.valid?

            if error_messages.empty?
              result_hash = {}
              hand_name = card_form.check_hands

              result_hash[:card] = card
              result_hash[:hand] = CardHelper::HAND_NAME[hand_name]

              strength_num = CardHelper::HAND_STRENGTH[hand_name]
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
              hand_name = CardHelper::HAND_NAME.key(result[:hand])
              if strength_array.min == CardHelper::HAND_STRENGTH[hand_name]
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
