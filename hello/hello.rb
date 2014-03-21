class Hello
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hola Angie"]]
  end
end