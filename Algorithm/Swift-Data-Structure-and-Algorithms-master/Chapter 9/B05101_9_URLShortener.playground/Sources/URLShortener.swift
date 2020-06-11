//
// URLShortener.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Erik J. Azar & Mario Eguiluz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public struct URLShortener {
    
    //Our short domain name. We will append the rest of the short URL at the end of this String
    let domainName:String
    
    //Array to store tuples of (path, long url) -METHOD1- and array to store just (index) -METHOD2-
    var urlArrayTuples:[(path:String,url:String)] = [] //METHOD1
    public var urlArray:[String] = [] //METHOD2
    
    //Secure Bloom Filter features
    public var unsafeUrlsArray:[String] = []
    public var bloomFilter = BloomFilter<String>(hashFunctions: [djb2, sdbm])
    
    //Public init
    public init(domainName:String) {
        self.domainName = domainName
    }
    
    //MARK: - Shorten and expand methods
    
    //METHOD 1
    //Function to receive a URL, use the index of the array (transformed to Base16) as ID forming a tuple (Base16ID, URL) and save it into an array. Returns the short URL as "domainName" + Base16ID
    public mutating func shorten(url:String) -> String {
        
        //Save the position of the new URL, which will be the last one of the array (we append new elements at the end)
        let index = urlArrayTuples.count
        
        //Swift native method to transform from Base 10 Int to Base 16 String
        let pathBase16String = String(index, radix: 16)
        
        //Create a new tuple (pathbase16ID, URL) and append it
        urlArrayTuples.append((pathBase16String , url))
        
        //Compound and return the shorten Url like domainName/path -> http://short.ty/ + 1zxf31z
        return domainName + pathBase16String
    }
    
    //Function that receives a short URL and search in the array for the tuple with that 'path' value to retrieve the 'url' value of the tuple
    public func expand(url:String) -> String {
        let pathBase16String = url.components(separatedBy: "/").last!
        
        for tuple in urlArrayTuples {
            if (tuple.path == pathBase16String) {
                //URL found
                return tuple.url
            }
        }
        
        //URL not found
        return domainName + "error404.html"
    }


    //METHOD 2
    //Function to receive a URL, append the URL at the end of the array, an use that position as the short URL path (transformed into base16 first). Returns the short URL as "domainName" + Base16ID.
    //So in this case, when we receive a short URL an want to get the initial URL, we just translate back the 'path' part of the URL to Base10 number so we have the specific index in the array where we have stored the inital URL, there is no need for searching
    public mutating func shortenFast(url:String) -> String {
        
        //Save the position of the new URL, which will be the last one of the array (we append new elements at the end)
        let index = urlArray.count
        
        //Save the URL: Append it at the end
        urlArray.append(url)
        
        //Swift native method to transform from Base 10 Int to Base 16 String
        let indexBase16String = String(index, radix: 16)

        //Own method: Change the base of the index where we have stored the Url (from Decimal to Hexadecimal) and pass it as String (it could contain letters not just numbers!)
        //let indexBase16String = URLShortener.base10toBase16(number: index)
        
        //Compound and return the shorten Url
        return domainName + indexBase16String
    }
    
    //Function that receives a short URL, calculate the proper index in base 10 and fetch the url for the array of urls directly by its position in the array
    public func expandFast(url:String) -> String {
        let hexString = url.components(separatedBy: "/").last!
        
        //Swift native method to transform from Base 16 String to Base 10 Int
        let decimalIndex = Int(hexString, radix: 16)!
        
        //Own method: To transform from Base 16 String to Base 10 Int
        //let decimalIndex = URLShortener.base16toBase10(hexString: hexString)
        
        if let url = urlArray[safe: decimalIndex] {
            return url
        }

        return domainName + "error404.html"
    }
    
    //SECURE feature
    
    //Blacklist one url
    public mutating func blackList(url:String) {
        self.bloomFilter.insert(element: url)
    }
    
    //Check if a url is secure. If the bloom filter says that is not present in the insecure array, is secure 100%. If the bloom filter says it is present in the insecure array, could be a false positive, we search manually to confirm.
    public func isSecure(url:String) -> Bool {
        let initialUrl = self.expandFast(url: url)
        let exists = self.bloomFilter.exists(element: initialUrl)
                
        if exists == true {
            //Check if the URL is not in the blacklisted array
            for unsafeUrl in unsafeUrlsArray {
                if initialUrl == unsafeUrl {
                    return false
                }
            }
            return true
        }else {
            return true
        }
    }
    
    //Function that receives a short URL, calculate the proper index in base 10 and fetch the url for the array of urls directly by its position in the array. Then, checks in the unsafe array if the url is secure or not
    public func expandSecure(url:String) -> String {
        let hexString = url.components(separatedBy: "/").last!
        
        //Swift native method to transform from Base 16 String to Base 10 Int
        let decimalIndex = Int(hexString, radix: 16)!
        
        //Own method: To transform from Base 16 String to Base 10 Int
        //let decimalIndex = URLShortener.base16toBase10(hexString: hexString)
        
        if let url = urlArray[safe: decimalIndex] {
            
            //Check if the URL is not in the blacklisted array
            for unsafeUrl in unsafeUrlsArray {
                if url == unsafeUrl {
                    return domainName + "unsafeAddress.html"
                }
            }
            
            return url
        }
        
        return domainName + "error404.html"
    }
    
    //MARK: - BONUS: Base Change methods done manually
    
    //Function that gets a decimal number and returns the hexadecimal string representation
    static func base10toBase16(number:Int) -> String {
        
        if number == 0 {
            return "0"
        }
        
        var number = number
        
        //Fixed base 16
        let base:Int = 16
        let base16digits:String = "0123456789abcdef"
        
        //In this array we will store the digits of the converted base as we calculate it in each iteration (in reverse order as we are appending them, but later we will reverse the order)
        var hexadecimalDigits:[Character] = []
        
        //Change the base of the number to base 16. General method
        while number > 0 {
            let remainder:Int = number % base
            hexadecimalDigits.append(base16digits.characterAt(index: remainder))
            number = number / base
        }
        
        //We need to reverse the digits of the array to get the correct order
        hexadecimalDigits = Array(hexadecimalDigits.reversed())
        
        return String(hexadecimalDigits)
    }
    
    //Function that gets a hexadecimal string and returns the decimal number
    static func base16toBase10(hexString:String) -> Int {
        
        if hexString == "0" {
            return 0
        }
        
        //Fix the base
        let base = 10
        
        //Put the string in lowercase to ensure that we match letters with our dictionary to decimal values
        var hexString = hexString
        
        //Dictionary to translate hex values to decimal values
        let translateDict:[Character:Int] = [
        "0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
        "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        "a": 10, "b": 11, "c": 12,
        "d": 13, "e": 14, "f": 15]
        
        //Found out the max order level of the hex number (how many digits)
        var power = hexString.characters.count - 1
        
        //Iterate and aggreate to the decimal sum -> for 'A2' in hex (where A = 9 and 2 = 2 for corresponding decimal values) we do: 9*10^1 + 2*10^0
        var decimalValue = 0
        for char in hexString.characters {
            let decimalDigit = translateDict[char] //get decimal value for the hex digit
            decimalValue = decimalValue + decimalDigit! * base^^power //add to the sum the corresponding result of 'digit*base^power'
            power = power - 1 //next digit has 1 less power
        }
        
        return Int(decimalValue)
    }
    
}

//MARK - For measuring code
public struct Stopwatch {
    public init() { }
    private var startTime: TimeInterval = 0.0;
    private var endTime: TimeInterval = 0.0;
    
    public mutating func start() {
        startTime = NSDate().timeIntervalSince1970;
    }
    
    public mutating func stop() -> TimeInterval {
        endTime = NSDate().timeIntervalSince1970;
        return endTime - startTime
    }
}

//MARK: - Helpers
// Extension of String to have a method that with a given string, returns the character at index 'index'
public extension String {
    public func characterAt(index:Int) -> Character {
        //We should check error cases here like index > endIndex or index < startIndex in order to use this method in other projects.
        //In our case, the index is assured within the bounds because we have a string of 16 characters and the index is always 0-15 -because of the operations that calculate the index in our methods-
        return self[self.index(self.startIndex, offsetBy: index, limitedBy: self.endIndex)!]
    }
}

/// Returns the element at the specified index iff it is within bounds, otherwise nil.
extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

// Helper infix method for exponentation
// http://stackoverflow.com/questions/24196689/how-to-get-the-power-of-some-integer-in-swift-language
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

