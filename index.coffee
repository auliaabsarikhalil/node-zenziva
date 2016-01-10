Zenziva 	= require './classes/Zenziva'
config 		= require './.config'
bodyParser 	= require 'body-parser'
express 	= require 'express'
kue 		= require "kue"
kueUI		= require "kue-ui"
app 		= express()
queue		= kue.createQueue()

##########################################################################################
#
# {
#    "phones" 	: ["PHONE_NUMBER_1", "PHONE_NUMBER_2"],
#    "message" 	: "Hello world !!!"
#	 "queue" 	: true
# 	 "priority"	: "high"
# }
#
##########################################################################################

app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }

app.use '/kue', kue.app
app.use '/kue-ui', kueUI.app

kueUI.setup({
    apiURL: '/kue',
    baseURL: '/kue-ui',
    updateInterval: config.kue.interval
})

app.post "/send", (req, res) ->
	
	data = req.body

	zenziva = new Zenziva data
	validated = zenziva.validate()
	return res.status(400).json({status:"error", message:validated }) if validated isnt true

	if data.queue
		job = queue.create "node-zenziva"
		job = job.priority data.priority if data.priority
		job.attempts(config.kue.attempts).backoff(config.kue.backoff).save()	
		return res.json({status:"success", message:"Successfully push into queue" })
	else
		zenziva.send (err, result) ->
			return res.status(400).json({status:"error", message:err }) if err
			return res.json({status:"success", message:result})

queue.process "node-zenziva", config.kue.maxActiveJobs, (job, done) ->
	zenziva = new Zenziva job.data
	zenziva.send done

server = app.listen config.port, config.host ,() ->
	host = server.address().address
	port = server.address().port
	console.log "Node Zenziva listening at http://#{host}:#{port}"