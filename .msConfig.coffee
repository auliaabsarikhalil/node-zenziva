module.exports =
	common:
		port: 3593
		host:"localhost"
		kue:
			interval: 2000
			maxActiveJobs: 30
			attempts : 3
			backoff:
				type: "exponential"

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