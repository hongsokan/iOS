//import UIKit

//var str = "Hello, playground"


import Foundation

var result: [Int] = []

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    
    for n in 0..<(commands.count) {
        let i = commands[n][0]-1
        let j = commands[n][1]-1
        let k = commands[n][2]-1
        
        result.append(((array[i...j].sorted())[k]))
    }
    
    return result
}



/*
 var result: [Int] = []
 
 var i = 2
 var j = 5
 var k = 3
 
 result.append(((array[i-1...j-1].sorted())[k-1]))
 
 i = 4
 j = 4
 k = 1
 
 result.append(((array[i-1...j-1].sorted())[k-1]))
 
 i = 1
 j = 7
 k = 3
 
 result.append(((array[i-1...j-1].sorted())[k-1]))
 
 return result
 */
