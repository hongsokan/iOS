import UIKit
import Foundation
import PlaygroundSupport



/*
// 테스트 케이스
// land = [[1,2,3,5],[5,6,7,8],[4,3,2,1]]
// [[1,2,3,5],
//  [5,6,7,8],
//  [4,3,2,1]]
// answer = 16

var land = [[1,2,3,5],[5,6,7,8],[4,3,2,1]]
var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: 4), count: 1001)
let r = land.count // 행 개수 row
var answer = 0

//    print(dp)
//    print(type(of: dp))
//    print(r)

// 행 쪼개기
for i in 0..<4 {
    dp[0][i] = land[0][i]
}

for i in 0...r{
    for j in 0...4 {
        for k in 0...4 {
            if (j != k) {
                print(i)
//                dp[i][j] = max(dp[i][j], land[i][j] + dp[i-1][k])
            }
        }
    }
}

for i in 0..<4 {
    answer = max(answer, dp[r-1][i])
}

print(answer)
*/



/*
 var indexOfMax = 0
 
 for row in land {
 for i in 0..<land[0].count {
 // print(row[i])
 indexOfMax = row.index(of: row.max()!)!
 }
 answer += row[indexOfMax]
 }
 
 return answer
 */


/*
 var test1 = [[0,1,1,1],[1,1,1,1],[1,1,1,1],[0,0,1,0]]
 // 9
 var test2 = [[0,0,1,1],[1,1,1,1]]
 // 4
 var board = test1
 */




/*
 var vertex = [[1, 4], [3, 4], [3, 10]]
 var ans = [0, 0]
 
 for i in 0..<vertex.count {
 ans[0] ^= vertex[i][0]
 ans[1] ^= vertex[i][1]
 }
 print(ans)
 */


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

