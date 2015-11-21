Zenziva = require './classes/Zenziva'

data =
	phones 		: ['ENTER_PHONE_NUMBER']
	message		: 'YOUR_MESSAGE'

zenziva = new Zenziva data

zenziva.send (err, result) ->
	if err
		console.dir err
		return
	console.dir result 