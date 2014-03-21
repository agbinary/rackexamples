require './env'
require 'httparty'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Mailer
  def initialize (from, to, subject)
    @from=from
    @to=to
    @subject=subject
  end
  def send_email (message)
    url = "https://sendgrid.com/api/mail.send.json"
    response = HTTParty.post url, :body => {
        "api_user" => ENV["SENDGRID_USER"],
        "api_key" => ENV["SENDGRID_TOKEN"],
        "to" => @to,
        "from" => @from,
        "subject" => @subject,
        "html" => message
    }
    response.body
    puts "Enviado"
  end
end

mailer= Mailer.new("ang3l_gu@hotmail.com", "ang3l_gu@hotmail.com", "Hola")
mailer.send_email("Hola Angie! :D")