import UIKit

var str = "Hello, playground"

// defer 사용 시
var value = "Hello"
func b() -> String {
    // return 이후 이루어질 행동을 예약
    defer {
        value.append("world")
    }
    return value
}
print("B : \(b())")


// value에 직접 추가하기 때문에 Helloworld 출력
value = "Hello"
func c() -> String {
    value.append("world")
    return value
}
print("C : \(c())")


// defer 사용하지 않을 시
value = "Hello"
func d() -> String {
    var f = value
    value.append("world")
    return f
}
print("D : \(d())")


func e() {
    do {
        defer{
            print("1")
        }
        defer{
            print("2")
        }
        defer{
            print("3")
        }
    }
}
print("E : 실행")
e()
print("E : 끝")


func f() {
    guard let fileURL = Bundle.main.url(forResource: "sample", withExtension: "txt") else {
        return
    }
    do {
        let content = try String(contentsOf: fileURL)
        print("Content : \(content)")
    }catch {
        print("Something went wrong")
    }
}
f()
