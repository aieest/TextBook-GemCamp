class Feedback < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  enum :remarks, {
    Unmarked: 0,
    VeryBad: 1,
    Bad: 2,
    Okay: 3,
    Good: 4,
    VeryGood: 5,
  }
end