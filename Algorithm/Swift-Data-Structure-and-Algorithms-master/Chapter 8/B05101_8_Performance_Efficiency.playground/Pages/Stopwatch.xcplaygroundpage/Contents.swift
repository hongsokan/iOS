/*:
 # Chapter 8
 ## Performance and Algorithm Efficiency
 */

//: ## Demonstrate use of a stopwatch to measure running time of a piece of code.
//:
//: ### Find the file implementations in the Sources folder located within this project.

//: Initialization of the timer
var timer = Stopwatch()

//: Start the timer
timer.start()

for counter:Int in 1...1000 {
    let a = counter
}

//: Print elapsed time
print("Elapsed time \(timer.stop())")

/*:
 
 The license for this document is available [here](License).
 */
