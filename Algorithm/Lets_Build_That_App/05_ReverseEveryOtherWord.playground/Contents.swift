import UIKit

// Swift Fun Algorithms #5: Reverse every other word

// implement a function that returns reversed sentence

var sampleSentence = "Lets start this challenge"

func reverseWordsInSentence(sentence: String) -> String {
    let allWords = sampleSentence.components(separatedBy: " ")
    var newSentence = ""
    
    /*
    for word in allWords {
//        print(word)
        
        // making space between each one of these words
        if newSentence != "" {
            newSentence += " "
        }
        
        let reverseWord = String(word.reversed())
        
        newSentence += reverseWord
    }
    */
    
    for index in 0...allWords.count - 1 {
        let word = allWords[index]
        
        if newSentence != "" {
            newSentence += " "
        }
        
        // reverse only odd numbers' words
        if index % 2 == 1 {
            let reverseWord = String(word.reversed())
            newSentence += reverseWord.stringByRemovingVowels()
        }
        else {
            newSentence += word
        }
    }
    
    return newSentence
}

extension String {
    func stringByRemovingVowels() -> String {
        var newWord = self
        for vowel in ["a", "e", "i", "o", "u"] {
            newWord = newWord.stringByRemovingVowels()
        }
        return newWord
    }
}

print(reverseWordsInSentence(sentence: sampleSentence))
