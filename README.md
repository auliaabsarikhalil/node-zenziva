# Node Zenziva
This is a service for sending a sms using [Zenziva](http://zenziva.net/) service

## Setup

Everything you need to setup before run the code:

1. Setup your [Zenziva account](http://zenziva.net/)
2. [Install and setup coffee](https://www.npmjs.com/package/coffee-script)
3. [Install and setup redis](http://redis.io/)
4. Install all required modules : `npm install`
5. Setup app config at `.msConfig.coffee` , see the sample code below
6. Create `.env` file, just rename `.env.example` and define your environment

```coffeescript

module.exports =
	# choose based on evironment
	common:
		port: 3593
		host:"localhost"
		kue:
			interval: 2000
			maxActiveJobs: 30
			attempts : 3
			backoff:
				type: "exponential"

```

## Debug mode
For debug mode you can run : `DEBUG=Zenziva index.coffee`

## How to test it
1. Setup data variable at `test/zenziva.coffee`, see the sample code below
2. run `npm test`

```coffeescript

data =
	phones 		: ['ENTER_PHONE_NUMBER']
	message		: 'YOUR_MESSAGE'

```

## How to use it
1. run : `coffee index.coffee`
2. Send JSON data to `HOST:5393/send`, example

```json
{
   "phones" : ["PHONE_NUMBER_1", "PHONE_NUMBER_2"],
   "message" : "Hello world !!!",
   "queue"	: true,
   "priority" : "high"
}
```

## Params Glossary
| Params        | Type     | Description |
| ------------- |:-------------:| ------------|
| phones | Array | List of phone number that will be sent  |
| message | String | message that you want to sent |
| queue | Boolean | if true than your request will be push into queue |
| priority | String | define your queue priority `"low", "normal", "medium", "high"`, or `"critical"` . by default its `"normal"` |

## Monitor your queue
You can monitor your queue by accessing `/kue` and if you want to see it more beautiful you can access `/kue-ui`