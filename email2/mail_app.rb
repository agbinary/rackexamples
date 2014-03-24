require 'rack/utils'
require './mailer'

class MailApp
  def call(env)
    request = Rack::Request.new(env)
    if request.get?
      case env["PATH_INFO"]
        when "/"
          return render "form.html"
      end
    elsif request.post?
      case env["PATH_INFO"]
        when "/send"
          mailer = Mailer.new(request.params["from_name"], request.params["from"], request.params["to"])
          if mailer.send_email(request.params["subject"], request.params["message"])
            return render "sent.html"
          else
            return render "error.html"
          end
      end
    end
    [404, {"Content-Type" => "text/plain"}, ["Error 404: Page not found"]]
  end

  private

  def render(file)
    return [200, {"Content-Type" => "text/html"}, [File.read(file)]]
  end
end
