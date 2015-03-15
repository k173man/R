# need to register as a dev, add an app, etc.

myapp = oauth_app(
	"twitter", 
	key="yourConsumerKeyHere", 
	secret="yourConsumerSecretHere"
)
sig = sign_oauth1.0(
	myapp,
	token = "yourTokenHere", 
	token_secret = "yourTokenSecretHere"
)
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
# content(...) recognizes that homeTL is JSON data
json1 = content(homeTL)
# content(...) produces data that's hard to read; :: operator is used to fully qualify a function (in this case fromJSON() & toJSON())
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
