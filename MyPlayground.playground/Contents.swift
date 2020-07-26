import UIKit
import Foundation


var vertex = [[1, 4], [3, 4], [3, 10]]
var ans = [0, 0]

for i in 0..<vertex.count {
    ans[0] ^= vertex[i][0]
    ans[1] ^= vertex[i][1]
}
print(ans)


/*
var string = "Hello"
string.count
type(of: string.count)
*/

/*
import Foundation

let num = Int(readLine()!)!
var array = Array(repeating: 0, count: 10001)

for _ in 0..<num {
    let n = Int(readLine()!)!
    array[n] += 1
}

array.sorted().map { print($0) }
*/


/*
10
5
2
3
1
4
2
3
5
1
7
*/

//print([10, 5, 2, 3, 1, 4, 2, 3, 5, 1, 7].sorted().split(separator: <#T##Int#>))

//[10, 5, 2, 3, 1, 4, 2, 3, 5, 1, 7].sorted().map { print($0) }


/*
let numbers = [10, 5, 2, 3, 1, 4, 2, 3, 5, 1, 7].sorted()
for n in numbers {
    print(n)
}
*/
 

/*
var number = "2143"

//let line = readLine()!
let sorted = number.sorted { $0 > $1 }.map { String($0) }.joined()

print(sorted)
*/



/*

let line = readLine()!
let sorted = line.sorted { $0 > $1 }.reduce("", { String($0) + String($1) })

print(sorted)
*/





//number.split(seperator:"")


//String(number).sorted { $0 > $1 }.map { String($0) }.joined()


/*
func sortInside(num: Int) -> Int {
    let sorted = String(num).sorted { $0 > $1 }.map { String($0) }.joined()
    return Int(sorted)!
}

sortInside(num: number)
*/




/*
//let line = readLine()!

func sortInside(num: String) -> Any {
//    let sorted = num.sorted { $0 > $1 }.reduce(result, { $0 + $1 })
    let sorted = num.sorted { $0 > $1 }.reduce("", { String($0) + String($1) })

    return sorted
}

sortInside(num: number)
*/
 


 

/*
import Foundation

let line = readLine()!
line.sorted { $0 > $1 }.reduce("", { String($0) + String($1) })
*/

