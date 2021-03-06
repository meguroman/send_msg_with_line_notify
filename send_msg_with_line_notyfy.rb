require 'net/http'
require 'uri'

class Line
  TOKEN = "KorehaDummyNoTokenIdDayo3kmr5aQjM7kZ4swehzPBY"
  URI = URI.parse("https://notify-api.line.me/api/notify")

  def make_request(msg)
    request = Net::HTTP::Post.new(URI)
    request["Authorization"] = "Bearer #{TOKEN}"
    request.set_form_data(message: msg)
    request
  end

  def send(msg)
    request = make_request(msg)
    response = Net::HTTP.start(URI.hostname, URI.port, use_ssl: URI.scheme == "https") do |https|
      https.request(request)
    end
  end

end

line = Line.new
msg = ARGV[0]

res = line.send(msg)
puts res.code
puts res.body
