class Hello
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hello Angie"]]
  end
end