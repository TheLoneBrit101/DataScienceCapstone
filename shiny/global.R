## Stupid Backoff
library(quanteda)
library(RColorBrewer)
library(data.table)
library(markdown)
library(wordcloud)
library(shiny)


t1gram <- readRDS('data/t1gram.RDS')
t2gram <- readRDS('data/t2gram.RDS')
t3gram <- readRDS('data/t3gram.RDS')
t4gram <- readRDS('data/t4gramT.RDS')
t5gram <- readRDS('data/t5gram.RDS')

setorder(t1gram,-freq)
setorder(t2gram,-score)
setorder(t3gram,-score)
setorder(t4gram,-score)
setorder(t5gram,-score)

t1gramCut <- head(t1gram)

# profwords <- n.readLines("base-list-of-bad-words_text-file_2018_07_30.txt",
#                          n =76, skip = 12)

word_predict <- function(input) {
    sen <- tokens(input, remove_numbers = TRUE,  remove_punct = TRUE,
                  remove_symbols = TRUE, remove_hyphens = TRUE)
    sen <- tokens_tolower(sen)
    # sen <- tokens_remove(sen, profwords)
    
    #length
    ## sen_length <- ntoken(sen)[[1]]
    sen <- unlist(sen, use.names=FALSE)
    sen_length <- length(sen)
    w <- vector()
    sc <- vector()
    limit <- 6
    
    if (sen_length == 0){
        return("Please enter something...")
    }
    else {
        # 5gram
        if (sen_length >= 4){
            words5 <- paste(tail(sen,4),collapse = ' ')
            t5 <- t5gram[w1w2w3w4==words5]
            if (nrow(t5) != 0){
                n5 <- if(nrow(t5)<limit) nrow(t5) else limit
                for (i in 1:n5){
                    w <- c(w,t5[i]$w5)
                    sc <- c( sc, t5[i]$score)
                }
            }
        }
        # 4gram
        if (sen_length == 3 | length(w) <= 5){
            words4 <- paste(tail(sen,3),collapse = ' ')
            t4 <- t4gram[w1w2w3==words4]
            if (nrow(t4) != 0){
                n4 <- if(nrow(t4)<limit) nrow(t4) else limit
                for (i in 1:n4){
                    w <- c(w,t4[i]$w4)
                    sc <- c( sc, t4[i]$score)
                }
            }
        }
        # 3gram
        if (sen_length == 2 | length(w) <= 5){
            words3 <- paste(tail(sen,2),collapse = ' ')
            t3 <- t3gram[w1w2==words3]
            if (nrow(t3) != 0){
                n3 <- if(nrow(t3)<limit) nrow(t3) else limit
                for (i in 1:n3){
                    w <- c(w,t3[i]$w3)
                    sc <- c( sc, t3[i]$score)
                }
            }
        }
        # 2gram
        if (sen_length == 1 | length(w) <= 5){
            words2 <- paste(tail(sen,1),collapse = ' ')
            t2 <- t2gram[w1==words2]
            if (nrow(t2) != 0){
                n2 <- if(nrow(t2)<limit) nrow(t2) else limit
                for (i in 1:n2){
                    w <- c(w,t2[i]$w2)
                    sc <- c( sc, t2[i]$score)
                }
            }
        }
        if (length(w)==0){
            w <- c(w,t1gramCut$term)
            sc <- c(sc,t1gramCut$freq)
        }
    
    result <- data.table(word=w,score=sc)
    setkey(result, word)
    result <- unique(result,by="word")
    setorder(result,-score)
    head(result,5)
    }
}