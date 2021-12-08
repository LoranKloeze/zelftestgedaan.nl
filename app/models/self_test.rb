class SelfTest < ApplicationRecord
  validate :done_at_date_cannot_be_in_the_future, :done_at_date_cannot_be_far_in_the_past
  validates :done_at, presence: true

  after_create :send_to_slack

  scope :grouped_by_done, lambda {
    select('done_at, COUNT(*) as total, COUNT(*) FILTER(WHERE is_positive = true) as total_positive')
      .group(:done_at)
      .order(done_at: :desc)
  }

  def done_at_date_cannot_be_in_the_future
    errors.add(:expiration_date, "can't be in the future") if done_at.present? && done_at > Date.today
  end

  def done_at_date_cannot_be_far_in_the_past
    errors.add(:expiration_date, "can't be that far in the past") if done_at.present? && done_at < Date.today - 1.month
  end

  def send_to_slack
    return unless Rails.env == 'production'

    status = is_positive ? '🥵' : '😊'
    SlackService.send_msg("Nieuwe zelftestuitslag toegevoegd: #{done_at} - #{status} ")
  end
end
