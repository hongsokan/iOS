import UIKit
import Foundation
import PlaygroundSupport






/*
public class Node<Value> { // Node 클래스를 <Value> 라는 Generics 타입으로, public 으로 모든 모듈에서 접근 가능하도록 정의합니다.
    public var value: Value // 노드가 가지고 있는 값.
    public var next: Node?
    // 노드가 가리키는 노드 (다음 노드)
    // 마지막 노드는 다음 노드가 nil 이기 때문에 옵셔널로 선언합니다.
    
    public init (value: Value, next: Node? = nil) {
        // 두 번째 매개변수 next 를 nil 로 초기화 이유
        // 노드 인스턴스 생성할 때 두 번째 매개변수 next 를 굳이 명시하지 않아도 nil 로 초기화 하게 초기값 지정해 준 것.
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    //CustomStringConvertible 프로토콜을 채택하는 객체는 자기 타입에 대한  description을 제공해야 합니다.
    public var description: String { // 연산 프로퍼티 네요.
        guard let next = next else { // nil 이 아니라면, 즉 다음 노드가 있다면
            return "\(value)" // 다음 노드가 없다면 value 값만 출력시킴.
        }
        return "\(value) -> " + String(describing: next) + " "
        // String(describing:) 메소드가 다음 노드의 description 을 호출합니다.
        // 이는 결국 연쇄적으로 다음, 다음의 다음, 다음의 다음의 다음, 이렇게 연결리스트의 노드를 한 눈에 보여주는 역할을 합니다.
    }
}

public struct LinkedList<Value> {
// 전체 연결리스트를 관리하는 하는 LinkedList 구조체
    public var head: Node<Value>? // 헤드 노드 : 연결리스트의 첫 번째 노드 표현.
    public var tail: Node<Value>? // 테일 노드 : 연결리스트의 마지막 노드 표현.
    
    public init() {} // 모든 프로퍼티들 옵셔널이면 nil 로 초기화됨.
    
    public var isEmpty: Bool { // 비어 있어?
        return head == nil
        // head 와 nil 을 비교해서 nil 이라면 true 반환. head 가 nil 이면 빈 연결리스트 라는 걸 표현.
    }
    
    public mutating func push(_ value: Value) {
    // mutating 을 붙인 이유는 LinkedList 가 구조체 이기 때문입니다. 이 메소드는 LinkedList 구조체 하위에 들어가는 것입니다.
    // 구조체는 클래스와는 른 '값 타입' 이기 때문에 구조체 인스턴스 내부에서 값을 수정하고 싶으면 mutating 키워드를 붙여야 합니다.
            head = Node(value: value, next: head) // head 생성 , head 에 Node 인스턴스의 참조정보 저장 됨을 유의. Node 는 클래스 이기 때문에.
            if tail == nil {
                tail = head
                // head 의 참조정보를 tail 에 할당.
                // 참조 정보라고 해서 어렵게 들릴 수도 있지만 이게 정확한 것입니다. Node 는 클래스라서 그의 인스턴스에는 참조 정보가 저장될 뿐이라는 것 !
            }
    }
    
    public mutating func append(_ value: Value) {
            guard !isEmpty else{ // 연결리스트가 비어있는지 체크 후 비어있다면 push 메소드 실행. 첫 번째 노드 추가하는 것 동일
                push(value)
                return
            }
            // 자 여기서 부터는 두 번째 이상 노드를 추가할 때 실행되는 과정.
            tail!.next = Node(value: value)
            // tail 은 head 와 같은 Node(1,nil) 인스턴스를 참조하고 있음을 유의
            // tail.next 에 새로운 Node 인스턴스 할당 하면 같은 참조정보를 가진 head.next 도 바뀌게 되겠죠?
            tail = tail?.next
            // tail 이라는 변수에 원래는 head 와 같은 첫 번째 노드 인스턴스의 참조를 가지고 있었지만
            // 새로 들어온 노드 인스턴스의 참조정보 할당해준다.
            // 그럼 자연스럽게 추가하는 노드를 tail 변수가 참조하게 되고 tail 이 뒷부분을 차지하는 것 처럼 된다.
    }
}
// 연결리스트는 왜 구조체를 씁니까? 하면.. 보통은 구조체를 쓰고 특정 목적으로 클래스를 쓰는데요.
// Node 는 연결리스트에서 노드가 추가되고, 제거되는 과정에서 메모리가 추가되고 메모리가 해제되는데 그 과정은 모두
// 하나의 노드들이 참조가 추가되고 참조가 추가되는 과정이거든요.
// Node 가 구조체라면 next 에 새로운 노드가 생길 때마다 값이 복사되서 불 필요한 많은 노드들이 생기게 되겠죠!!
 
extension LinkedList: CustomStringConvertible { // 연결리스트 출력할 때 description 지정.
    
    public var description: String {
        guard let head = head else { // 헤드노드가 nil 이면 연결리스트에 아무것도 없는 상태에요.
            return "Empty List"
        }
        return String(describing: head) // 헤드노드에 모두 연결되므로 헤드노드 출력하면 연결리스트 나옵니다.
    }
}

var answer = 0
var sticker = [14, 6, 5, 11, 3, 9, 2, 10]
//var sticker2 = [1, 3, 2, 5, 4]

var list = LinkedList<Int>()

for n in sticker {
    print(n)
    list.append(n)
    print(list)
}
*/





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

