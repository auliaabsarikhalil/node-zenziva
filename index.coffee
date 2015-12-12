Zenziva 	= require './classes/Zenziva'
config 		= require './.config'
bodyParser 	= require 'body-parser'
express 	= require 'express'
app 		= express()

app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }

##########################################################################################
#
# {
#    "phones" : ["PHONE_NUMBER_1", "PHONE_NUMBER_2"],
#    "message" : "Hello world !!!"
# }
#
##########################################################################################

app.post "/send", (req, res) ->
	zenziva = new Zenziva data
	zenziva.send (err, result) ->
		return res.status(500).json({status:"error", message:err }) if err
		return res.json({status:"success", message:result})

server = app.listen config.port, config.host ,() ->
	host = server.address().address
	port = server.address().port
	console.log "Node Zenziva listening at http://#{host}:#{port}"