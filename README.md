# Node Zenziva
Code sample for integrate Zenziva sms service using nodejs

## How to run it
1. Setup your [Zenziva account](http://zenziva.net/)
2. [Install and setup coffee](https://www.npmjs.com/package/coffee-script)
3. Install all required modules : `npm install`
4. Setup app config at `.config.coffee` , see the sample code below
5. run : `coffee index.coffee`
6. Debug Mode : `DEBUG=Zenziva index.coffee`

```coffeescript

module.exports =
  zenziva:
  	userKey : 'USER_KEY'
  	passKey : 'PASS_KEY'
  	uri : 'https://reguler.zenziva.net/apps/smsapi.php'

```

## How to test it
1. Setup data variable at `test/android.coffee`, see the sample code below
2. run `npm test`

```coffeescript

data =
	phones 		: ['ENTER_PHONE_NUMBER']
	message		: 'YOUR_MESSAGE'

```