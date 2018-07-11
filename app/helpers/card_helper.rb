module CardHelper
  HAND_NAME = { straight_flush: 'ストレートフラッシュ',
                four_of_a_kind: 'フォー・オブ・ア・カインド',
                full_house: 'フルハウス',
                flush: 'フラッシュ',
                straight: 'ストレート',
                three_of_a_kind: 'スリー・オブ・ア・カインド',
                two_pair: 'ツーペア',
                one_pair: 'ワンペア',
                high_card: 'ハイカード'
              }

  HAND_STRENGTH = { straight_flush: 1,
                    four_of_a_kind: 2,
                    full_house: 3,
                    flush: 4,
                    straight: 5,
                    three_of_a_kind: 6,
                    two_pair: 7,
                    one_pair: 8,
                    high_card: 9
                  }
end






