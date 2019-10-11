require 'net/http'
require 'uri'
class Converter
	attr_accessor :endpoint
	def initialize
		@endpoint = ENV['CONVERTER_ENDPOINT']
	end
	def get_endpoint_for(c1,c2)
		return [@endpoint,'ticker',c1.downcase + "-" + c2.downcase].join('/')
	end
	def get_ticker(c1,c2)
		e = get_endpoint_for(c1,c2)
		contents = Net::HTTP.get(URI.parse(e))
		return contents
	end
	def get_conversion(amnt,c1,c2)
		json = get_ticker(c1,c2)
		json = JSON.parse(json)
		price = json['ticker']['price'].to_f
		return amnt * price
	end

end
