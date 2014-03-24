require './mail_app'
require 'minitest/autorun'
require 'rack/test'
require "mocha/mini_test"

class MailAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    MailApp.new
  end

  def test_request_method_get
    get "/"

    assert_equal "http://example.org/", last_request.url
    assert last_response.ok?
  end

  def test_request_method_post_sent
    Mailer.any_instance.expects(:send_email).returns(true)
    post "/send", {:fromname => "Angela", :from => "blabla@gmail.com", :to => "blabla@gmail.com", :subject => "Hola", :message => "Hola Angie!"}

    assert_equal "http://example.org/send", last_request.url
    assert_match /Email sent/, last_response.body
    assert last_response.ok?

  end

  def test_request_method_post_error
    Mailer.any_instance.expects(:send_email).returns(false)
    post "/send", {:fromname => "Angela", :from => "blabla@gmail.com", :to => "blabla@gmail.com", :subject => "Hola", :message => "Hola Angie!"}

    assert_equal "http://example.org/send", last_request.url
    assert_match /ERROR!/, last_response.body
    assert last_response.ok?

  end
end
