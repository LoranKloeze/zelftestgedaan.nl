class SelfTest < ApplicationRecord
  validate :done_at_date_cannot_be_in_the_future

  def done_at_date_cannot_be_in_the_future
    if done_at.present? && done_at > Date.today
      errors.add(:expiration_date, "can't be in the future")
    end
  end
end
