#install the necessary packages
install.packages("twitteR")
install.packages("tm")

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

#the cainfo parameter is necessary only on Windows
r_stats2 <- searchTwitter("#Trump", n=15000)

#[Testing] using search and db to test if extraction can be uploaded to a database

#should get 1500
length(r_stats2)
#[1] 1500

#save text
r_stats_text <- sapply(r_stats2, function(x) x$getText())

#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))

#clean up
r_stats_text_corpus <- tm_map(r_stats_text_corpus, content_transformer(tolower)) 
r_stats_text_corpus <- tm_map(r_stats_text_corpus, removePunctuation)
r_stats_text_corpus <- tm_map(r_stats_text_corpus, function(x)removeWords(x,stopwords()))
