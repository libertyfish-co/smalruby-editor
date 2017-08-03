class Passcode
  include ActiveModel::Model
  attr_accessor :code

  validates :code, presence: true, length: {is: 6}, numericality: { only_integer: true }
end
