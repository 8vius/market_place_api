class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    @default || version(request)
  end

  private

  def version(req)
    req.headers['Accept'].include?("application/vnd.marketplace.v#{@version}")
  end
end
