require 'rack/utils'
require './mailer'

class MailApp

  def call(env)
      case env["REQUEST_METHOD"]
        when "GET"
          case env["PATH_INFO"]
            when "/"
              return render("form.html")
          end
        when "POST"
          case env["PATH_INFO"]
            when "/send"
              form = Rack::Utils.parse_nested_query(env["rack.input"].read)
<<<<<<< HEAD
              mailer = Mailer.new(form["from_name"], form["from"], form["to"])
              if mailer.send_email(form["subject"], form["message"])
=======
              mailer = Mailer.new("Guillermo Iguaran", "guilleiguaran@gmail.com", "ang3l_gu@hotmail.com")
              if mailer.send_email("Hola", "Hola Angie!")
>>>>>>> 556c7888f43a50f1000dfb7536a460eacb612a23
                return render "sent.html"
              else
                return render "error.html"
              end
          end
      end
  end

   private

  def render(file)
    return [200, {"Content-Type" => "text/html"}, [File.read(file)]]
  end

end
