require 'rack/utils'
require './mailer'

class MailApp
  def call(env)
    request = Rack::Request.new(env)
    @response = Rack::Response.new
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
    @response.status = 404
    @response.headers["Content-Type"] = "text/plain"
    @response.write("Error 404: Page not found")
  end

  private

  def render(file)
    @response.headers["Content-Type"] = "text/html"
    @response.write(File.read(file))
    @response.finish
  end
end
