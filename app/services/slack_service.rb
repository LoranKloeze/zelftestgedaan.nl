class SlackService
  class << self
    def send_msg(msg)
      return unless webhook_url

      Net::HTTP.post(
        URI(webhook_url),
        { text: msg }.to_json,
        'Content-Type' => 'application/json'
      ).code == '200'
    end

    def webhook_url
      Rails.application.credentials.dig(:slack, :notes_webhook_url)
    end
  end
end
