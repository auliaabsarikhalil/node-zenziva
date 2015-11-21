config = require '../.config'
request = require 'request'
debug = require('debug')('Zenziva')

class Zenziva

	constructor: (data) ->

		debug "Creating Sms Object"

		return throw new Error "Initialize parameter can not be empty" if not data

		@data = data

	validate: () ->

		debug "Validating parameter"

		data 		= @data
		errors 		= []
		required 	= ['phones', 'message']

		required.forEach (key) ->

			if typeof data["#{key}"] is "undefined"
				errors.push "#{key} is required"

			if key == 'phones' and typeof data["#{key}"] is not "object"
				errors.push "#{key} type is invalid, type should be object"

		return true if errors.length == 0

		return errors

	send: (cb) ->

		response = @validate()

		return cb response if response isnt true

		debug "Sending the sms"

		data  = @data

		options =
			method : "GET"
			uri : config.zenziva.uri
			qs :
				userkey	: config.zenziva.userKey
				passkey	: config.zenziva.passKey
				pesan 	: data.message

		phones = data.phones

		for phone in phones

			options.qs.nohp = phone

			request options, (err, result, body) =>
				
				return cb err if err	
				
				status = @parse body

				return cb body if status != 0

				return cb null, body

	parse: (xml) ->

		status = 0

		try
			status = xml.match(/<status>(.*?)<\/status>/g)[0]
			status = status.replace(/<\/?status>/g,'')
			status = parseInt status

			return status

		return status

module.exports = Zenziva