class HeaderModifier

  def initialize(app)
   @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)
    @headers.delete 'Cache-Control'
    [@status, @headers, @response]
  end

end
