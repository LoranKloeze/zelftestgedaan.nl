class SelfTest < ApplicationRecord

  validate :done_at_date_cannot_be_in_the_future, :done_at_date_cannot_be_far_in_the_past
  validates :done_at, presence: true

  def done_at_date_cannot_be_in_the_future
    if done_at.present? && done_at > Date.today
      errors.add(:expiration_date, "can't be in the future")
    end
  end

  def done_at_date_cannot_be_far_in_the_past
    if done_at.present? && done_at < Date.today - 1.month
      errors.add(:expiration_date, "can't be that far in the past")
    end
  end
end
