class Env
  def call(env)
    [200, {"Content-Type" => "text/html"}, [env.inspect]]
  end
end