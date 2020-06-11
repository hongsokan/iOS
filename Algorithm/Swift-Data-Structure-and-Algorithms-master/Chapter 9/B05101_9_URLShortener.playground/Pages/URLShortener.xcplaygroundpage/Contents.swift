/*:
 # Chapter 9
 ## Choosing the Perfect Algorithm
 */

//: ## Demonstrate how to measure and improve your own algorithm.
//:
//: ### Find the file implementations in the Sources folder located within this project.

import Foundation

//: Create URL Shortener
var myShortenMachine = URLShortener(domainName:"http://shor.ty/")
var crono = Stopwatch()

//: Fill it (both arrays, one for each method) with lots of long URLs to shorten
for i in 0...100000 {
    myShortenMachine.shorten(url: "http://www.test.com/blog/page/file/" + "\(i)")
    myShortenMachine.shortenFast(url: "http://www.test.com/blog/page/file/" + "\(i)")
}

//: Now search for specific URLs and measure the time spent to do it. We will store measures in 2 arrays to compare them at the end
var arrayMethod1:[TimeInterval] = []
var arrayMethod2:[TimeInterval] = []

//: # Method 1: With searching tuples in the array of (path,URL)

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/0"))
arrayMethod1.append((crono.stop()))

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/100"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/500"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/1000"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/2000"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/3000"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/4000"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/7000"))
arrayMethod1.append(crono.stop())

crono.start()
print(myShortenMachine.expand(url: "http://shor.ty/18500"))
arrayMethod1.append(crono.stop())

//: Display a graph for Method 1
arrayMethod1.map{$0}

//: # Method 2: With direct access with array index

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/0"))
arrayMethod2.append((crono.stop()))

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/100"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/500"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/1000"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/2000"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/3000"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/4000"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/7000"))
arrayMethod2.append(crono.stop())

crono.start()
print(myShortenMachine.expandFast(url: "http://shor.ty/18500"))
arrayMethod2.append(crono.stop())

//: Display a graph for Method 2
arrayMethod2.map{$0}

/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */

