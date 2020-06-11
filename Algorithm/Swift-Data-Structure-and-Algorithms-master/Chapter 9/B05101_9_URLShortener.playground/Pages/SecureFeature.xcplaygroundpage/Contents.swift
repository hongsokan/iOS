//: [Previous](@previous)

//: ## Demonstrate how to measure and improve your own algorithm.
//:
//: ### Find the file implementations in the Sources folder located within this project.

import Foundation

//: Create URL Shortener
var myShortenMachine = URLShortener(domainName:"http://shor.ty/")
var crono = Stopwatch()

//: Blacklist urls
myShortenMachine.blackList(url: "http://www.test.com/blog/page/file/0")
myShortenMachine.blackList(url: "http://www.test.com/blog/page/file/100000")
myShortenMachine.blackList(url: "http://www.test.com/blog/page/file/1000000")

//: Setup our URL list and for the example, add ALL to the unsafe URLs list
for i in 0...1000000 {
    myShortenMachine.shortenFast(url: "http://www.test.com/blog/page/file/" + "\(i)")
}
myShortenMachine.unsafeUrlsArray = myShortenMachine.urlArray.map{$0}

//: # Now search for specific URLs and measure the time spent to do it.
var arrayMethod1:[TimeInterval] = []

//: Check for a blacklisted urls
crono.start()
print(myShortenMachine.expandSecure(url: "http://shor.ty/0"))
arrayMethod1.append(crono.stop())

//Check for a blacklisted url
crono.start()
print(myShortenMachine.expandSecure(url: "http://shor.ty/2000"))
arrayMethod1.append(crono.stop())

//Check for a blacklisted url
crono.start()
print(myShortenMachine.expandSecure(url: "http://shor.ty/7000"))
arrayMethod1.append(crono.stop())

//Check for a blacklisted url
crono.start()
print(myShortenMachine.expandSecure(url: "http://shor.ty/18500"))
arrayMethod1.append(crono.stop())

//Check for a blacklisted url
crono.start()
print(myShortenMachine.expandSecure(url: "http://shor.ty/F4240"))
arrayMethod1.append(crono.stop())

arrayMethod1.map{$0}

//: # Now perform the check with the bloom filter
var arrayMethodBloom:[TimeInterval] = []

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/0")
arrayMethodBloom.append(crono.stop())

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/2000")
arrayMethodBloom.append(crono.stop())

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/7000")
arrayMethodBloom.append(crono.stop())

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/18500")
arrayMethodBloom.append(crono.stop())

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/F4240")
arrayMethodBloom.append(crono.stop())

crono.start()
myShortenMachine.isSecure(url: "http://shor.ty/FFFFF")
arrayMethodBloom.append(crono.stop())

arrayMethodBloom.map{$0}

/*:
 
 The license for this document is available [here](License).
 */

