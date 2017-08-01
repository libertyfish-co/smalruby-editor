class Passcode
  include ActiveModel::Model
  attr_accessor :code

  validates :code, presence: true
  validates :code, length: {is: 6}
  validates :code, numericality: { only_integer: true }
end