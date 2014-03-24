require 'rack/utils'
require 'nancy'
require './mailer'

class MailApp < Nancy::Base
  include Nancy::Render

  get "/" do
    render "views/form.html"
  end

  post "/send" do
    mailer = Mailer.new(params["from_name"], params["from"], params["to"])
    if mailer.send_email(params["subject"], params["message"])
      render "views/sent.html"
    else
      render "views/error.html"
    end
  end
end
