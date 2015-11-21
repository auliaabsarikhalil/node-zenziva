should = require 'should'
expect = require 'expect.js'
Zenziva = require '../classes/Zenziva'

data =
	phones 		: ['ENTER_PHONE_NUMBER']
	message		: 'YOUR_MESSAGE'
	
clone = (obj) ->

	return obj if obj == null or typeof obj != 'object'
	
	temp = obj.constructor()

	for key of obj
		temp[key] = clone(obj[key])
	
	temp

describe "Zenziva", () ->

	@timeout 1500000	

	it "should receive error when `phones` is not in the parameter", () ->

		passData = clone data

		delete passData.phones

		sms = new Zenziva passData

		sms.send (err, result) ->
			expect(err).not.to.eql(null)
			expect(result).eql(undefined)
			expect('phones is required' in err).to.eql(true)

	it "should receive error when `message` is not in the parameter", () ->
		
		passData = clone data

		delete passData.message

		sms = new Zenziva passData

		sms.send (err, result) ->
			expect(err).not.to.eql(null)
			expect(result).eql(undefined)
			expect('message is required' in err).to.eql(true)

	it "should receive error when `phones` is not a object", () ->
		
		passData = clone data

		passData.phones = ""

		sms = new Zenziva passData

		sms.send (err, result) ->
			expect(err).not.to.eql(null)
			expect(result).eql(undefined)
			expect('phones type is invalid, type should be object' in err).to.eql(true)

	it "should return error message when data failed to send to phone number", () ->
		
		passData = clone data

		passData.phones = ['']

		sms = new Zenziva passData

		sms.send (err, result) ->
			expect(err).not.to.eql(null)
			expect(result).to.eql(undefined)

	it "should return success message when data has been sent to Zenziva", (done) ->
		
		passData = clone data

		sms = new Zenziva passData

		sms.send (err, result) ->
			expect(err).to.eql(null)
			expect(result).not.to.eql(undefined)
			done()