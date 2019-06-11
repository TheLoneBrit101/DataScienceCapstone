# DataScienceCapstone
## Coursera Swiftkey Capstone Project

This is the Coursera Data Science Specialization Capstone Project sponsored by Swiftkey.

The app uses a 5-gram back-off model with Stupid Backoff to predict the next word in a sentence.

The app can be found [here](https://thelonebrit101.shinyapps.io/Capstone/), and may be subject to change as I improve and add upon it. 

Unstructured .txt files, were provided by Swiftkey, from three sources: blogs, news, and twitter.

First an exploratory data analysis was carried out - the report of which can be found [here](http://rpubs.com/TheLoneBrit101/490490
)
The data was then cleaned, by removing symbols, numbers, and profanity, and a 5-gram probabilistic language model was built using the quanteda package.

Using Stupid Backoff to rank the 'next-word' in a sequence, each 'candidate' was given a score (relative frequency) for each predicition.
 
This was interpreted like so and applied to each row in the model:

```{r eval=FALSE}
if (inputIs5gram) {
    score = matched5gramCount / input4gramCount
} else if (inputIs4gram) {
    score = 0.4 * matched4gramCount / input3gramCount
} else if (inputIs3gram) {
    score = 0.4 * 0.4 * matched3gramCount / input2gramCount
} else if (inputIs2gram) {
    score = 0.4 * 0.4 * 0.4 * matched2gramcount / input1gramCount
}
```

Note alpha is a recommended value of 0.4.


### App Instructions
After one or more words have been entered into the input box, wait a few seconds and the server will predict the most likely next-word.
The results will be the top most likely posibilities and will be presented in table form from the most likely at the top to the least at the bottom.
There will also be a wordcloud to visualy represent the results.
You may continue the already inputted sequence by adding further words. The results will refresh automatically.

A word cloud was added to further illustrate the results.
