require './env'
require 'httparty'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Mailer
  def initialize(from_name, from, to)
    @from_name = from_name
    @from = from
    @to = to
  end

  def send_email(subject, message)
    url = "https://sendgrid.com/api/mail.send.json"
    response = HTTParty.post url, :body => {
        "api_user" => ENV["SENDGRID_USER"],
        "api_key" => ENV["SENDGRID_TOKEN"],
        "to" => @to, "fromname" => @from_name,
        "from" => @from,
        "subject" => subject,
        "html" => message
    }
    response.code == 200
  end
end