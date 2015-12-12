module.exports =
	common:
		port: 3593
		host:"localhost"

	development:
		host:"localhost"
		zenziva:
			userKey : 'USER_KEY'
			passKey : 'PASS_KEY'
			uri : 'https://reguler.zenziva.net/apps/smsapi.php'

	production:
		host:"localhost"
		zenziva:
			userKey : 'USER_KEY'
			passKey : 'PASS_KEY'
			uri : 'https://reguler.zenziva.net/apps/smsapi.php'