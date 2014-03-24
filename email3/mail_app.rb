require 'rack/utils'
require './mailer'
require 'nancy'

class MailApp < Nancy::Base
  include Nancy::Render
  get "/" do
    render "form.html"
  end
  post "/send" do
    mailer = Mailer.new(params["from_name"], params["from"], params["to"])
    if mailer.send_email(params["subject"], params["message"])
      render "sent.html"
    else
      render "error.html"
    end
  end
end