require 'rails_helper'
describe Converter do
	it "should return an instance with base_url" do
		c = Converter.new
		expect(c.endpoint).not_to be_empty
	end
	it "should join currency to enpoint" do
		c = Converter.new
		e = c.get_endpoint_for('BTC','USD')
		e.should eq([ENV['CONVERTER_ENDPOINT'],'ticker','btc-usd'].join('/'))
	end

	it "should fetch json for a currency pair" do
		c = Converter.new
		json = c.get_ticker('BTC','USD')
		json.is_a?(String).should eq(true)
		val = JSON.parse(json)
		val.should have_key("ticker")
		val["ticker"].should have_key("base")
	end
	it "should convert a currency" do
		c = Converter.new
		v = c.get_conversion(1,'BTC','USD')
		v.is_a?(Float).should eq(true)
	end
end
