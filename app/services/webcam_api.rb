require "open-uri"
require "base64"

url = '10.20.0.1:2000/cgi-bin/api.cgi?cmd=Snap&channel=0&rs=wuuPhkmUCeI9WG7C&user=admin&password=growbox'
image = URI.open(url).read
image_64 = Base64.encode64(image)
