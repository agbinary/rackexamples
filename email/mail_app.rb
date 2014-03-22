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
              mailer = Mailer.new("ang3l_gu@hotmail.com", "ang3l_gu@hotmail.com")
              if mailer.send_email("Hola", "Hola Angie!")
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