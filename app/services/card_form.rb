class CardForm
  include ActiveModel::Model
  attr_accessor :hands

  def initialize(array=nil)
    @hands = array
  end

  def valid

  end
end