#More Simplistic version running on RSQLite
#Initialise Libraries
library(DBI)
library(RMySQL)
library(sqldf)
library("twitteR")
library("tm")

#necessary file for Windows
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
apitoken <- "4123804573-GJqGKJDXEalfrREL4MjVIwyXLyFVX31e6cC4DbU"
apisecret <- "FoQx4uYEXiXMukOhwA6zapDAT5s9IXJFj3LfjDAZMQMWe"
conskey <- "RHJkBog0391gr89wSB2wQ1v7l"
conssecret <- "2RLqMNtTAQmNhOBsLBvG61WmvAuitXZSXUZOmCWoNePQvgeNjR"
origop <- options("httr_oauth_cache")
options(httr_oauth_cache=TRUE)

#connects to the app
setup_twitter_oauth(conskey,conssecret,apitoken,apisecret)

#sets the cache (usually manually prompted but now automated)
options(httr_oauth_cache=origop)

#registers the backend database of where the tweets are redirected to
register_sqlite_backend("NeutralTrainingSet")

#starts query and searches
search_twitter_and_store("#Neutral",table_name = "tweets")