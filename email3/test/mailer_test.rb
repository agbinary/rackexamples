require_relative "../lib/mailer"
require "minitest/autorun"
require "mocha/mini_test"

class MailerTest < Minitest::Test
  def test_send_email
    ENV["SENDGRID_USER"] = "user"
    ENV["SENDGRID_TOKEN"] = "key"

    hash = {
        :body => {
            "api_user" => "user",
            "api_key" => "key",
            "to" => "ang3l_gu@hotmail.com", "fromname" => "Angela",
            "from" => "ang3l_gu@hotmail.com",
            "subject" => "Hola",
            "html" => "Hola Angie!"
        }
    }

    response = mock

    response.expects(:code).returns(200)
    HTTParty.expects(:post).with("https://sendgrid.com/api/mail.send.json", hash).returns(response)

    app = Mailer.new("Angela", "ang3l_gu@hotmail.com", "ang3l_gu@hotmail.com")

    assert app.send_email("Hola", "Hola Angie!")

  end
end
