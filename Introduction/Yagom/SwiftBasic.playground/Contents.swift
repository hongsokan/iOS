import UIKit

var str = "Hello, playground"

import Swift

//let age: Int = 10
//
//"안녕하세요! 저는 \(age)살입니다"
//"안녕하세요! 저는 \(age + 5)살입니다"
//
//print("안녕하세요! 저는 \(age + 5)살입니다")
//print("\n############\n")
//
//class Person {
//    var name: String = "yagom"
//    var age: Int = 10
//}
//
//let yagom: Person = Person()
//print(yagom)
//print("\n###########\n")
//dump(yagom)




//// Bool
//var someBool: Bool = true
//someBool = false
//
//// Int 양수,음수,정수
//var someInt: Int = -100
//
//// UInt 양의 정수
//var someUInt: UInt = 100
//
//// Float 부동소수형
//var someFloat: Float = 3.14
//
//// Double 64부동소수
//var someDouble: Double = 3.14
//someDouble = 3
//
//// Character 문자
//var someCharacter: Character = "a"
//someCharacter = "🍎"
//
//// String
//var someString: String = "aaaaa"
//someString = someString + "🍎"




//// Any
//var someAny: Any = 100
//someAny = "어떤 타입도 가능"
//someAny = 123.12
//
//// AnyObject
//class SomeClass {}
//var someAnyObject: AnyObject = SomeClass()
//
//// nil
//someAny = nil
//someAnyObject = nil



//// Array
//var integers: Array<Int> = Array<Int>()
//integers.append(1)
//integers.append(100)
//
//integers.contains(100)
//integers.contains(99)
//
//integers.remove(at: 0)
//integers.removeLast()
//integers.removeAll()
//// -> 배열이 비어있는 상태
//
//integers.count
//
//// Array<Double>, [Double] 은 동일한 표현
//// 빈 Array 생성 예제
//var doubles: Array<Double> = [Double]()
//var strings: [String] = [String]()
//var characters: [Character] = []
//let immutableArray = [1, 2, 3]
//
//// Dictionary
//var anyDictionary: Dictionary<String, Any> = [String: Any]()
//anyDictionary["someKey"] = "value"
//anyDictionary["anotherKey"] = 100
//anyDictionary
//
//anyDictionary["someKey"] = "dictionary"
//anyDictionary
//
//anyDictionary.removeValue(forKey: "anotherKey")
//
//anyDictionary["someKey"] = nil
//anyDictionary
//
//let emptyDictionary: [String: String] = [:]
//let initializedDictionary: [String: String] = ["name":"yagom", "gender":"male"]
//
//// Set
//var integerSet: Set<Int> = Set<Int>()
//integerSet.insert(1)
//integerSet.insert(100)
//integerSet.insert(99)
//integerSet.insert(99)
//integerSet.insert(99)
//
//integerSet
//integerSet.contains(1)
//integerSet.contains(2)
//
//integerSet.remove(100)
//integerSet.removeFirst()
//
//integerSet.count
//
//
//let setA: Set<Int> = [1,2,3,4,5]
//let setB: Set<Int> = [3,4,5,6,7]
//
//let union: Set<Int> = setA.union(setB)
//
//let sortedUnion: [Int] = union.sorted()
//
//let intersection: Set<Int> = setA.intersection(setB)
//
//let subtracting: Set<Int> = setA.subtracting(setB)




//// 함수
//
//// 기본 형태
//// func 함수이름 (매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 ...) -> 반환타입 {
////      함수 구현부
////      return 반환값
//// }
//
//func sum(a: Int, b: Int) -> Int {
//    return a + b
//}
//
//// 반환 값이 없는 함수, Void와 return 모두 생략 가능
//func printMyName(name: String) -> Void {
//    print(name)
//}
//
//func printYourName(name: String) {
//    print(name)
//}
//
//// 매개변수가 없는 함수
//func maximunIntegerValue() -> Int {
//    return Int.max
//}
//
//// 반환값과 매개변수 둘 다 없는 함수
//func hello() -> Void { print("hello") }
//
//func bye() { print("bye") }
//
//// 함수의 호출
//sum(a: 3, b: 5)
//printMyName(name: "yagom")
//printYourName(name: "haha")
//maximunIntegerValue()
//hello()
//bye()




//// 매개변수 기본값
//// 기본값 갖는 매개변수는 목록 중 뒤쪽에 위치
//func greeting(friend: String, me: String = "yagom") {
//    print("Hello \(friend)! I'm \(me)")
//}
//
//// 기본값 갖는 매개변수는 생략 가능
//greeting(friend: "haha")
//greeting(friend: "John", me: "Eric")
//
//// 전달인자 레이블
//func greeting(to friend: String, from me: String) {
//    print("Hello \(friend)! I'm \(me)")
//}
//
//// 이런 식으로 외부 전달인자로 함수 호출 가능
//greeting(to: "haha", from: "yagom")
//
//
//
//// 가변 매개변수
//// 전달 받을 값 개수 알기 어려울 때 사용
//// 함수 당 하나만 가질 수 있다
//
//func sayHelloToFriends(me: String, friends: String...) -> String {
//    return "Hello \(friends)! I'm \(me)!"
//}
//print(sayHelloToFriends(me: "yagom", friends: "haha", "eric", "wing"))
//print(sayHelloToFriends(me: "yagom"))   // 생략도 가능
//
//
//
//// 데이터 타입으로서의 함수
//// Swift는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어
//// Swift 함수는 일급객체이므로 변수, 상수 등에 저장 가능하고 매개변수 통해 전달도 가능
//
//// 함수의 타입표현, 반환타입 생략할 수 없다
//var someFunction: (String, String) -> Void = greeting(to:from:)
//someFunction("eric", "yagom")
//
//someFunction = greeting(friend:me:)
//someFunction("eric", "yagom")
//
//// 타입이 다른 함수는 할당할 수 없다
//// 아래의 sayHelloToFriends() 함수는 가변 매개변수 포함하기 때문에 할당 안됨
////someFunction = sayHelloToFriends(me: friends:)
//
//// 매개변수를 함수 타입으로 지정하여 아래와 같이 사용할 수도 있다
//func runAnother(function: (String, String) -> Void) {
//    function("jenny", "mike")
//}
//runAnother(function: greeting(friend: me:))
//runAnother(function: someFunction)




//// 조건문
//let someInteger = 100
//
//// 중괄호는 생략 불가
//if someInteger < 100 {
//    print("100 미만")
//} else if someInteger > 100 {
//    print("100 초과")
//} else {
//    print("100")
//}
//
//// Swift의 조건은 항상 Bool 타입
//// if someInteger { } , someInteger는 Int타입이기 때문에 오류
//
//
//
//// Switch, 범위 연산자와 같이 활용
//switch someInteger {
//case 0:
//    print("zero")
//case 1..<100:
//    print("1~99")
//case 100:
//    print("100")
//case 101...Int.max:
//    print("over 100")
//default:
//    print("unknown")
//}
//
//
//// 정수 외의 대부분의 기본 타입 사용 가능
//// 명확히 case 명시되지 않는 한, default 구문 필수
//// case 다음에 break는 기본적으로 걸린다
//// 명시적으로 break 효과 위해서 fallthrough 사용하면 된다
//switch "yagom" {
//case "jake":
//    print("jake")
//case "mina":
//    print("mina")
//case "yagom":
//    print("yagom!!")
//default:
//    print("unknown")
//}




//// 반복문
//var integers = [1, 2, 3]
//let people = ["yagom": 10, "eric": 15, "mike": 12]
//
//// for-in, 컬렉션 타입과 많이 사용
//// for item(반복할 아이템) in items(반복할 컬렉션 타입)
//for integer in integers {
//    print(integer)
//}
//
//// Dictionary의 item은 key와 value로 구성된 튜플 타입
//for (name, age) in people {
//    print("\(name): \(age)")
//}
//
//// while, condition은 조건문처럼 Bool 타입이어야 함
//while integers.count > 1 {
//    integers.removeLast()
//}
//
//// repeat-while, do-while 같은 기능
//repeat {
//    integers.removeLast()
//} while integers.count > 0




//// 옵셔널
//// 값이 '있을 수도, 없을 수도' 있음
//// nil의 가능성을 명시적으로 표현
//
//// 파라미터 someOptionalParam은 Int일 수도 아닐 수도 있다
//func someFunction(someOptionalParam: Int?) {
//    // ...
//}
//
//// 파라미터 someParam은 nil이 될 수 없다
//func someFunction(someParam: Int) {
//    // ...
//}
//
//someFunction(someOptionalParam: nil)
////someFunction(someParam: nil)
//
//
//// Optional은 enum + general 이런 구조
//enum Optional<Wrapped> : ExpressibleByNilLiteral {
//    // 값이 있을 수도 있고, 없을 수도 있다
//    case none
//    case some(Wrapped)
//
//    init(nilLiteral: ()) {
//        self = .init(nilLiteral: <#T##()#>)
//    }
//}
//
////let optionalValue: Optional<Int> = nil
//let optionalValue: Int? = nil



//// Implicitly Unwrapped Optional (암시적 추출 옵셔널)
//var optionalValue: Int! = 100
//
//// 앞서 본 내용처럼 Optional 타입 자체는 열거형
//switch optionalValue {
//case .none:
//    print("This Optional variable is nil")
//case .some(let value):
//    print("Value is \(value)")
//}
//
//// 기존 변수처럼 사용 가능
//optionalValue = optionalValue + 1
//
//// nil 할당 가능
//optionalValue = nil
//
//// 잘못된 접근으로 인한 런타임 오류 발생
//optionalValue = optionalValue + 1



//var optionalValue: Int? = 100
//
//switch optionalValue {
//case .none:
//    print("This Optional variable is nil")
//case .some(let value):
//    print("Value is \(value)")
//}
//
//// nil 할당 가능
//optionalValue = nil
//
//// 기존 변수처럼 사용불가 - 옵셔널과 일반값은 다른 타입
//optionalValue = optionalValue + 1




//// 옵셔널 값 추출
//// Optional Binding : nil 체크 + 안전한 값 추출
//func printName(_ name: String) {
//    print(name)
//}
//
//var myName: String? = nil
//
//// 전달되는 값의 타입 다르기 때문에 컴파일 에러
//printName(myName)


//// if-let
//func printName(_ name: String) {
//    print(name)
//}
//
//var myName: String! = nil
//
//if let name: String = myName {
//    printName(name)
//} else {
//    print("myName == nil")
//}
//
//// name 상수는 if-let 구문 내에서만 사용가능
//// 상수 사용범위를 벗어나 컴파일 에러
//printName(name)



//// if-let
//// 한번에 여러 개의 optional 타입을 바인딩 할 수 있다
//var myName: String? = "yagom"
//var yourName: String? = nil
//
//// 이 구문은 name 과 friend 에 모두 값이 있어야만 실행
//if let name = myName, let friend = yourName {
//    print("\(name) and \(friend)")
//}
//// yourName이 nil이기 때문에 실행되지 않음
//
//yourName = "hana"
//
//// myName = "yagom", yourname = "hana" 이므로 실행
//if let name = myName, let friend = yourName {
//    print("\(name) and \(friend)")
//}



//// Force Unwrapping
//// 옵셔널 값 강제 추출
//
//func printName(_ name: String) {
//    print(name)
//}
//
//var myName: String? = "yagom"
//
//printName(myName!) // yagom
//
//myName = nil
//
//print(myName!)
//// 강제추출 시 값 없으므로 런타임 에러
//
//printName(yourName)
//// nil 값이 전달되기 때문에 런타임 에러




//// 구조체
//// 대부분 구조체 사용
//struct Sample {
//    // 인스턴스 프로퍼티
//    var mutableProperty: Int = 100
//    let immutableProperty: Int = 100
//
//    // 타입 프로퍼티
//    static var typeProperty: Int = 100
//
//    // 인스턴스 메서드
//    func instanceMethod() {
//        print("instance method")
//    }
//
//    // 타입 메서드
//    static func typeMethod() {
//        print("type method")
//    }
//}
//
//// 구조체 사용
//var mutable: Sample = Sample()
//
//let immutable: Sample = Sample()
//
//Sample.typeProperty = 300
//Sample.typeMethod()


//// 학생 구조체
//struct Student {
//    var name: String = "unknown"
//    var `class`: String = "Swift"
//    // 앞뒤로 강세표 써주면 class에서 사용 가능
//
//    static func selfIntroduce() {
//        print("학생타입입니다")
//    }
//
//    func selfIntroduce() {
//        print("저는 \(self.class)반 \(name)입니다")
//    }
//}
//
//Student.selfIntroduce()
//
//var yagom: Student = Student()
//yagom.name = "yagom"
//yagom.class = "Swift"
//yagom.selfIntroduce()
//
//let jina: Student = Student()
//// 불변 인스턴스는 프로퍼티 값 변경 불가, 컴파일 에러
//jina.selfIntroduce()
//// 메서드는 호출 가능



//// 클래스
//// struct는 값 타입, class는 참조 타입
//// Swift 클래스는 다중 상속 불가
//
//class Sample {
//    var mutableProperty: Int = 100 // 가변 프로퍼티
//    let immutableProperty: Int = 100 // 불변
//
//    static var typeProperty: Int = 100 // 타입
//
//    // 인스턴스 메서드
//    func instanceMethod() {
//        print("instance method")
//    }
//
//    // 타입 메서드, 재정의 불가
//    static func typeMethod() {
//        print("type method - static")
//    }
//
//    // 타입 메서드, 재정의 가능
//    class func classMethod() {
//        print("type method - class")
//    }
//}
//
//
//// 클래스 사용
//var mutableReference: Sample = Sample()
//
//mutableReference.mutableProperty = 200
//mutableReference.immutableProperty = 200
//
//let immutableReference: Sample = Sample()
//
//immutableReference.mutableProperty = 200
//immutableReference.immutableProperty = 200
//
//
//Sample.typeProperty = 300
//Sample.typeMethod()



//// 학생 클래스
//class Student {
//    var name: String = "unknown"
//    var `class`: String = "Swift"
//
//    class func selfIntroduce() {
//        print("학생타입입니다.")
//    }
//
//    func selfIntroduce() {
//        print("저는 \(self.class)반 \(name)반입니다.")
//    }
//}
//
//Student.selfIntroduce()
//
//var yagom: Student = Student()
//yagom.name = "yagom"
//yagom.class = "스위프트"
//yagom.selfIntroduce()
//
//// 가변 프로퍼티를 let으로 인스턴스 선언해도 class에선 값 변경 가능
//let jina: Student = Student()
//jina.name = "jina"
//jina.selfIntroduce()



//// 열거형
//// 타입이므로 대문자 카멜케이스 사용
//// 각 case는 소문자 카멜, 자체가 고유의 값
//
//enum Weekday {
//    case mon
//    case tue
//    case wed
//    case thu, fri, sat, sun
//}
//
//var day: Weekday = Weekday.mon
//day = .tue
//
//print(day)
//
//switch day {
//case .mon, .tue, .wed, .thu:
//    print("평일입니다")
//case Weekday.fri:
//    print("불금!")
//case .sat, .sun:
//    print("주말~")
//}   // enum의 케이스를 다 포함하지 않는 경우 default 설정 필요
//
//
//// 원시값
//// C언어 enum처럼 정수값 가질 수도 있다
//// rawValue 사용, case 별 다른 값 가져와야 된다
//enum Fruit: Int { // 원시값 타입은 Int
//    case apple = 0
//    case grape = 1
//    case peach
//}
//
//print("Fruit.peach.rawValue == \(Fruit.peach.rawValue)")
//
//// 정수 타입 외에도 Hashable 프로토콜 따르는
//// 모든 타입 원시값 타입으로 지정 가능
//enum School: String {
//    case ele = "초등"
//    case mid = "중등"
//    case high = "고등"
//    case uni
//}
//
//print("School.mid.rawValue == \(School.mid.rawValue)")
//print("School.uni.rawValue == \(School.uni.rawValue)")
//// 문자열로 된 열거형 타입에서 값이 없는 uni같은 경우 case 이름 그대로
//
//
//// 원시값을 통한 초기화
//// rawValue를 통해 초기화 가능
//// rawValue가 case에 해당하지 않을 수 있으므로 옵셔널 타입
//let apple: Fruit? = Fruit(rawValue: 0)
//
//if let orange: Fruit = Fruit(rawValue: 5) {
//    print("rawValue 5에 해당하는 case는 \(orange)입니다")
//} else {
//    print("rawValue 5에 해당하는 case 없음")
//}
//
//
//// 메서드
//// 열거형에는 메서드도 추가 가능
//enum Month {
//    case dec, jan, feb
//    case mar, apr, may
//    case jun, jul, aug
//    case sep, oct, nov
//
//    func printMessage() {
//        switch self {
//        case .mar, .apr, .may:
//            print("봄")
//        case .jun, .jul, .aug:
//            print("여름")
//        case .sep, .oct, .nov:
//            print("가을")
//        case .dec, .jan, .feb:
//            print("겨울")
//        }
//    }
//}
//
//Month.mar.printMessage()




//// 값타입과 참조타입
//// 클래스, 구조체, 열거형 비교
//
//struct ValueType {
//    var property = 1
//}
//
//class ReferenceType {
//    var property = 1
//}
//
//let firstStructInstance = ValueType()
//var secondStructInstance = firstStructInstance
//secondStructInstance.property = 2
//// 두번째 인스턴스에는 복사되어 값이 들어감
//
//print("1st struct instance property : \(firstStructInstance)")
//
//print("2nd struct instance property : \(secondStructInstance)")
//
//let firstClassInstance = ReferenceType()
//var secondClassInstance = firstClassInstance
//secondClassInstance.property = 2
//// 두번째 인스턴스에는 참조되어 값이 같음
//
//print("1st class instance property : \(firstClassInstance)")
//
//print("2nd class instance property : \(secondClassInstance)")


//// 구조체와 내부 프로퍼티
//struct SomeStruct {
//    var someProperty: String = "Property"
//}
//
//// 인스턴스 생성
//var someStructInstance: SomeStruct = SomeStruct()
//
//// 해당 함수로 structInstance 매개변수로 (복사되어 전달)
//// 함수에서 structInstance의 내부 프로퍼티 변경
//func someFunction(structInstance: SomeStruct) {
//    var localVar: SomeStruct = structInstance
//    localVar.someProperty = "ABC"
//}
//
//someFunction(structInstance: someStructInstance)
//print(someStructInstance.someProperty)
//// 함수 실행 결과 내부 프로퍼티는 변경되지 않음


//// 클래스와 내부 프로퍼티
//class SomeClass {
//    var someProperty: String = "Property"
//}
//
//// 인스턴스 생성
//var someClassInstance: SomeClass = SomeClass()
//
//// 해당 함수로 structInstance 매개변수로 (참조되어 전달)
//// 함수에서 structInstance의 내부 프로퍼티 변경
//func someFunction(classInstance: SomeClass) {
//    var localVar: SomeClass = classInstance
//    localVar.someProperty = "ABC"
//}
//
//someFunction(classInstance: someClassInstance)
//print(someClassInstance.someProperty)
//// 함수 실행 결과 내부 프로퍼티는 변경됨




//// 클로저
//// 코드의 블럭, 일급 시민, 변수/상수 등으로 저장, 전달인자로 전달 가능
//// 함수 : 이름 있는 클로저
//
//// 함수 사용 시
//func sumFunc(a: Int, b: Int) -> Int {
//    return a + b
//}
//
//var sumResult: Int = sumFunc(a: 1, b: 2)
//
//print(sumResult)
//
//
//// 클로서 사용
//var sum: (Int, Int) -> Int = { (a: Int, b: Int) in
//    return a + b
//}
//
//sumResult = sum(1, 2)
//print(sumResult)
//
//// 함수는 클로저 일종, sum 변수에는 함수도 할당 가능
//sum = sumFunc(a:b:)
//
//sumResult = sum(1, 2)
//print(sumResult)
//
//
//
//// 함수의 전달인자로서의 클로저
//let add: (Int, Int) -> Int
//add = { (a: Int, b: Int) -> Int in
//    return a + b
//}
//
//let subtract: (Int, Int) -> Int
//subtract = { (a: Int, b: Int) -> Int in
//    return a - b
//}
//
//let divide: (Int, Int) -> Int
//divide = { (a: Int, b: Int) -> Int in
//    return a / b
//}
//
//func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
//    return method(a, b)
//}
//
//var calculated: Int
//
//calculated = calculate(a: 50, b: 10, method: add)
//print(calculated)
//
//calculated = calculate(a: 50, b: 10, method: subtract)
//print(calculated)
//
//calculated = calculate(a: 50, b: 10, method: divide)
//print(calculated)
//
//calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
//    return left * right
//})
//print(calculated)




//// 클로저 고급
//// 다양한 방법 : 후행클로저, 반환타입 생략, 단축 인자이름, 암시적 반환표현
//
//// 클로저 기본 형태, method 라는 이름으로 클로저를 전달 받음
//func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
//    return method(a, b)
//}
//
//var result: Int
//
//
//// 후행클로저 : 클로저가 마지막 전달인자인 경우,
//// 마지막 매개변수 이름 생략 후, 함수 소괄호 외부에 클로저 구현 가능
//result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
//        return left + right
//}
//print(result)
//
//
//// 반환타입 생략 : calculate 함수의 method 매개변수는
//// Int 타입 반환한다는 사실을 컴파일러도 알기 때문에
//// 굳이 클로저에서 반환타입 명시하지 않아도 된다, 대신 in 키워드는 생략 불가
//result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in
//        return left + right
//})
//print(result)
//
//// 후행클로저와 함께 사용도 가능
//result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
//        return left + right
//}
//
//
//// 단축 인자이름 : 클로저의 매개변수 이름 굳이 불필요하면, 단축 인자이름 활용 가능
//// 클로저의 매개변수 순서대로 $0, $1... 이렇게 사용
//result = calculate(a: 10, b: 10, method: {
//    return $0 + $1
//})
//print(result)
//
//// 역시 후행클로저와 함께 사용 가능
//result = calculate(a: 10, b: 10) {
//    return $0 + $1
//}
//print(result)
//
//
//// 암시적 반환표현 : 클로저가 반환하는 값 있으면, 마지막 줄 결과값은 암시적 반환값으로 취급
//result = calculate(a: 10, b: 10) {
//    $0 + $1
//}
//print(result)
//
//// 간결하게 한 줄로 표현 가능
//result = calculate(a: 10, b: 10) { $0 + $1 }
//print(result)
//
//
//// 축약하지 않은 클로저 vs 축약 후 문법
//result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in
//        return left + right
//})
//
//result = calculate(a: 10, b: 10) { $0 + $1 }
//
//print(result)




//// 프로퍼티
//// 저장, 연산, 인스턴스, 타입
//// 구조체, 클래스, 열거형 내부에 구현 가능
//// 열거형 내부에는 연산만 가능, var로만 선언 가능
//
//struct Student {
//    // 인스턴스 저장 프로퍼티
//    var name: String = ""
//    var `class`: String = "Swift"
//    var koreanAge: Int = 0
//
//    // 인스턴스 연산 프로퍼티
//    var westernAge: Int {
//        get {
//            return koreanAge - 1
//        }
//        set(inputValue) {
//            koreanAge = inputValue + 1
//        }
//    }
//
//    // 타입 저장 프로퍼티
//    static var typeDescription: String = "학생"
//
//    // 인스턴스 메서드
//    func selfIntroduce() {
//        print("저는 \(self.class)반 \(name)입니다")
//    }
//
//    // 읽기전용 인스턴스 연산 프로퍼티
//    var selfIntroduction: String {
//        get {
//            return "저는 \(self.class)반 \(name)입니다"
//        }   // get만 있으면 읽기 전용, set은 쓰기
//    }
//
//    // 타입 메서드
//    static func selfIntroduce() {
//        print("학생타입")
//    }
//
//    // 읽기전용 타입 연산 프로퍼티, 읽기전용에서는 get 생략 가능
//    static var selfIntroduction: String {
//        return "학생타입"
//    }
//}
//
//// 사용
//
//// 타입 연산 프로퍼티 사용
//print(Student.selfIntroduction)
//
//// 인스턴스 생성
//var yagom: Student = Student()
//yagom.koreanAge = 10
//
//// 인스턴스 저장 프로퍼티 사용
//yagom.name = "yagom"
//print(yagom.name)
//
//// 인스턴스 연산 프로퍼티 사용
//print(yagom.selfIntroduction)
//
//print("한국나이 \(yagom.koreanAge), 미국나이 \(yagom.westernAge)")
//
//
//// 응용
//struct Money {
//    var currencyRate: Double = 1100
//    var dollar: Double = 0
//    var won: Double {
//        get {
//            return dollar * currencyRate
//        }
//        set {
//            dollar = newValue / currencyRate
//        }
//    }
//}
//
//var moneyInMyPocket = Money()
//
//moneyInMyPocket.won = 11000
//print(moneyInMyPocket.won)
//moneyInMyPocket.dollar = 10
//print(moneyInMyPocket.won)
//
//
//
//// 저장, 연산 프로퍼티 기능은 함수, 메서드, 클로저, 타입 등
//// 외부에 위치한 지역, 전역 변수에도 모두 사용 가능
//var a: Int = 100
//var b: Int = 200
//var sum: Int {
//    return a + b
//}
//print(sum)




//// 프로퍼티 감시자 : 프로퍼티 값 변경될 때 원하는 동작 수행 가능
//
//struct Money {
//    // 프로퍼티 감시자 사용, 저장 프로퍼티
//    var currencyRate: Double = 1100 {
//        willSet(newRate) {  // 바뀔 예정이다 알려주는 역할
//            print("환율 \(currencyRate)에서 \(newRate)으로 변경예정")
//        }
//        didSet(oldRate) {   // 바뀌었다 알려주는 역할
//            print("환율 \(oldRate)에서 \(currencyRate)으로 변경")
//        }
//    }
//
//    // 프로퍼티 감시자 사용
//    var dollar: Double = 0 {
//        // willSet의 암시적 매개변수 이름 newValue
//        willSet {
//            print("\(dollar)달러에서 \(newValue)달러로 변경 예정")
//        }
//        // didSet의 암시적 매개변수 이름 oldValue
//        didSet {
//            print("\(oldValue)달러에서 \(dollar)달러로 변경")
//        }
//    }
//
//    // 연산 프로퍼티
//    var won: Double {
//        get {
//            return dollar * currencyRate
//        }
//        set {
//            dollar = newValue / currencyRate
//        }
//
//        // 프로퍼티 감시자와 연산 프로퍼티 기능은 동시 사용 불가
//        // willSet, didSet은 저장되는 값이 변경될 때 호출되기 때문
//    }
//}
//
//// 사용
//var moneyInMyPocket: Money = Money()
//
//// 환율 1100.0 -> 1150.0 변경 예정
//moneyInMyPocket.currencyRate = 1150
//// 환율 1100.0 -> 1150.0 변경됨
//
//// 0.0달러에서 10.0달러로 변경 예정
//moneyInMyPocket.dollar = 10
//// 0.0달러에서 10.0달러로 변경됨
//
//print(moneyInMyPocket.won)
//
//// 프로퍼티 감시자 기능
//// 함수, 메서드, 클로저, 타입 등 외부에 위치한 지역, 전역 변수에도 사용 가능
//var a: Int = 100 {
//    willSet {
//        print("\(a)에서 \(newValue)로 변경 예정")
//    }
//    didSet {
//        print("\(oldValue)에서 \(a)로 변경")
//    }
//}
//
//// 100에서 200으로 변경될 예정
//a = 200
//// 100에서 200으로 변경됨




//// 상속
//// 스위프트 상속은 클래스, 프로토콜 등에서 가능
//// 열거형, 구조체는 상속 불가. 다중상속도 지원하지 않음
//
//class Person {
//    var name: String = ""
//
//    func selfIntroduce() {
//        print("저는 \(name)입니다")
//    }
//
//    // final로 상속 시 재정의 방지
//    final func sayHello() {
//        print("hello")
//    }
//
//    // 타입 메서드. 재정의 불가 타입 메서드 - static
//    static func typeMethod() {
//        print("type method - static")
//    }
//
//    // 재정의 가능 타입 메서드 - class
//    class func classMethod() {
//        print("type method - class")
//    }
//
//    // class 라도 final 이랑 사용하면 재정의 불가
//    // 메서드 앞의 `static`과 `final class`은 같은 역할
//    final class func finalClassMethod() {
//        print("type method - final class")
//    }
//}
//
//// Person을 Student로 상속
//class Student: Person {
//    // name 프로퍼티는 Person에 이미 상속받았기 때문에 재정의 불가
//    // var name: String = ""
//    var major: String = ""
//
//    override func selfIntroduce() {
//        print("이름 \(name), 전공 \(major)")
//        // 부모 클래스 호출하고 싶으면 super.selfIntroduce()
//    }
//
//    override class func classMethod() {
//        print("overriden type method - class")
//    }
//
//    // static을 사용한 타입 메서드는 재정의 불가
//    // override static func typeMethod() {  }
//
//    // final을 사용한 메서드, 프로퍼티는 재정의 불가
//    // override func sayHello() {   }
//    // override class func finalClassMethod() {   }
//}
//
//// 사용
//let yagom: Person = Person()
//let hana: Student = Student()
//
//yagom.name = "yagom"
//hana.name = "hana"
//hana.major = "Swift"
//
//// Person
//yagom.selfIntroduce()
//// Student
//hana.selfIntroduce()
//
//Person.classMethod()
//Person.typeMethod()
//Person.finalClassMethod()
//
//Student.classMethod()   // 재정의 됨
//Student.typeMethod()    // 재정의 되지 않음
//Student.finalClassMethod()  // 재정의 되지 않음



//
//// 인스턴스의 생성과 소멸
//// 이니셜라이저 init , 디이니셜라이저 deinit
//
//// 프로퍼티 기본값
//// 스위프트 모든 인스턴스 초기화 동시 유효한 값 할당되어야 함
//// 프로퍼티에 미리 기본값 할당하면, 인스턴스 생성 동시에 초기값 지니게 됨
//
//class PersonA {
//    // 모든 저장 프로퍼티에 기본값 할당
//    var name: String = "unknown"
//    var age: Int = 0
//    var nickName: String = "nick"
//}
//
//let jason: PersonA = PersonA()
//jason.name = "jason"
//jason.age = 30
//jason.nickName = "j"
//
//
//// 이니셜라이저
//// 프로퍼티 기본값 지정하기 어려운 경우 이니셜라이저 사용
//class PersonB {
//    // 모든 저장 프로퍼티에 기본값 할당
//    var name: String
//    var age: Int
//    var nickName: String
//    // 일종의 함수
//    init (name: String, age: Int, nickName: String) {
//        self.name = name
//        self.age = age
//        self.nickName = nickName
//    }
//}
//
//let hana: PersonB = PersonB(name: "hana", age: 20, nickName: "하나")
//
//
//// 프로퍼티 초기값 꼭 필요 없을 때, 옵셔널 사용!
//class PersonC {
//    var name: String
//    var age: Int
//    var nickName: String?
//
////    init (name: String, age: Int, nickName: String) {
////        self.name = name
////        self.age = age
////        self.nickName = nickName
////    }
//
//    // 이런 식으로 클래스 내부에서 이니셜라이저가 다른 init 호출 가능
//    convenience init (name: String, age: Int, nickName: String) {
//        self.init(name: name, age: age)
//        self.nickName = nickName
//    }
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}
//
//let jenny: PersonC = PersonC(name: "jenny", age: 10)
//let mike: PersonC = PersonC(name: "mike", age: 10, nickName: "m")
//
//
//// 암시적 추출 옵셔널은 인스턴스 사용에 꼭 필요하지만, 초기값 할당하지 않을 때 사용
//class Puppy {
//    var name: String
//    var owner: PersonC!
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func goOut() {
//        print("\(name)가 주인 \(owner.name) 따라 산책 중")
//    }
//}
//
//let happy: Puppy = Puppy(name: "happy")
//// 주인 없이 산책할 수 없음, 런타임 에러
//// happy.goOut()
//happy.owner = jenny
//happy.goOut()
//
//
//// 실패 가능한 이니셜라이저
//// 이니셜라이저 매개변수로 전달되는 초기값 잘못된 경우
//// 인스턴스 생성에 실패할 수 있음. 실패하면 nil 반환
//// 그래서 실패 가능한 이니셜라이저의 반환타입은 옵셔널 타입
//
//class PersonD {
//    var name: String
//    var age: Int
//    var nickName: String?
//
//    init? (name: String, age: Int) {
//        if (0...120).contains(age) == false {
//            return nil
//        }
//
//        if name.count == 0 {
//            return nil
//        }
//        self.name = name
//        self.age = age
//    }
//}
//
//let john: PersonD? = PersonD(name: "john", age: 23)
//let joker: PersonD? = PersonD(name: "joker", age: 123)
//let batman: PersonD? = PersonD(name: "", age: 10)
//
//print(joker)    // age > 120, 인스턴스 생성 실패, nil 반환
//print(batman)   // name 비어있음, 인스턴스 생성 실패, nil 반환
//
//
//// 디이니셜라이저 :deinit은 클래스의 인스턴스가 메모리에서 해제되는 시점에 호출
//// 인스턴스 해제되는 시점에 해야할 일 구현 가능
//
//class PersonE {
//    var name: String
//    var pet: Puppy?
//    var child: PersonC
//
//    init (name: String, child: PersonC) {
//        self.name = name
//        self.child = child
//    }
//
//    deinit {
//        if let petName = pet?.name {
//            print("\(name)가 \(child.name)에게 \(petName) 인도")
//            self.pet?.owner = child
//        }
//    }
//}
//
//var donald: PersonE? = PersonE(name: "donald", child: jenny)
//donald?.pet = happy
//donald = nil
//// donald 인스턴스 메모리 해제, donald가 jenny에게 happy 인도




// 옵셔널 체이닝과 nil 병합 연산자

// 옵셔널 체이닝은 옵셔널 요소 내부 프로퍼티
// 또 다시 옵셔널이 연속적으로 연결되는 경우 유용하게 사용 가능

// 클래스나 구조체 안에 또 다른 인스턴스가 있는 등
// 프로퍼티를 타고 타고 가야되는 경우가 생김

class Person {
    var name: String
    var job: String?
    var home: Apartment?

    init(name: String) {
        self.name = name
    }
}

class Apartment {
    var buildingNumber: String
    var roomNumber: String
    var `guard`: Person?
    var owner: Person?

    init(dong: String, ho: String) {
        buildingNumber = dong
        roomNumber = ho
    }
}

let yagom: Person? = Person(name: "yagom")
let apart: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")

// 옵셔널 체이닝 실행 후 결과값 nil일 수도 있으므로 결과 타입도 옵셔널
// 옵셔널 바인딩을 통해 값 확인해야 함

// 만약 우리집 경비원 직업이 궁금하면..?
// 옵셔널 체이닝을 사용하지 않는다면..
func guardJob(owner: Person?) {
    if let owner = owner {
        if let home = owner.home {
            if let `guard` = home.guard {
                if let guardJob = `guard`.job {
                    print("우리집 경비원 직업 \(guardJob)")
                } else {
                    print("우리집 경비원 직업 없음")
                }
            }
        }
    }
}
guardJob(owner: yagom)

// 옵셔널 체이닝 사용 시
func guardJobWithOptionalChaining(owner: Person?) {
    if let guardJob = owner?.home?.guard?.job {
        print("우리집 경비원 직업 \(guardJob)")
    } else {
        print("우리집 경비원 직업 없음")
    }
}
guardJobWithOptionalChaining(owner: yagom)


yagom?.home?.guard?.job // nil, yagom에 집이 할당되어 있지 않음
yagom?.home = apart

yagom?.home // optional(apartment)
yagom?.home?.guard  // nil
yagom?.home?.guard = superman

yagom?.home?.guard?.name // superman
yagom?.home?.guard?.job // nil
yagom?.home?.guard?.job = "경비원"


// nil 병합 연산자
var guardJob: String

// ?? 앞의 값이 nil 이라면 뒤의 값 할당
guardJob = yagom?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 경비원

yagom?.home?.guard?.job = nil

// nil 을 넣어주고 뒤의 값 할당하면 바뀜
guardJob = yagom?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 슈퍼맨




// 타입캐스팅
// 인스턴스 타입 확인 용도,
// 또는 클래스 인스턴스를 부모 혹은 자식 클래스의 타입으로 사용 가능한지 확인 용도
// is, as

// 기존에 알고 있던 것처럼 타입캐스팅하면, 인스턴스 새로 생성한 것으로 된다
let someInt: Int = 100
let someDouble: Double = Double(someInt)

// 타입캐스팅 위한 클래스
class Person {
    var name: String = ""
    func breath() {
        print("숨을 쉽니다")
    }
}

class Student: Person {
    var school: String = ""
    func goToSchool() {
        print("등교합니다")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    func goToMT() {
        print("MT 갑니다")
    }
}

var yagom: Person = Person()
var hana: Student = Student()
var jason: UniversityStudent = UniversityStudent()


// 타입 확인
// is

var result: Bool

result = yagom is Person
result = yagom is Student
result = yagom is UniversityStudent

result = hana is Person
result = hana is Student
result = hana is UniversityStudent

result = jason is Person
result = jason is Student
result = jason is UniversityStudent

if yagom is UniversityStudent {
    print("yagom is 대학생")
} else if yagom is Student {
    print("yagom is 학생")
} else if yagom is Person {
    print("yagom is 사람")
}

// 순서에 따라 먼저 오는 case에 걸리게 됨
switch jason {
case is Person:
    print("jason is 사람")
case is Student:
    print("jason is 학생")
case is UniversityStudent:
    print("jason is 대학생")
default:
    print("jason은 사람도, 학생도, 대학생도 아님")
}

switch jason {
case is UniversityStudent:
    print("jason is 대학생")
case is Student:
    print("jason is 학생")
case is Person:
    print("jason is 사람")
default:
    print("jason은 사람도, 학생도, 대학생도 아님")
}


// 업 캐스팅
// as 사용하여 부모클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 타입정보 전환
// Any, AnyObject로도 타입정보 변환할 수 있음, 암시적으로 처리되어 생략 가능

var mike: Person = UniversityStudent() as Person
var jenny: Student = Student()
var jina: Any = Person()    // as Any


// 다운 캐스팅
// as? - 조건부, as! - 강제
// 자식 클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 인스턴스 타입정보 전환

// as?
var optionalCasted: Student?

optionalCasted = mike as? UniversityStudent
optionalCasted = jenny as? UniversityStudent // nil
optionalCasted = jina as? UniversityStudent // nil
optionalCasted = jina as? Student // nil

// as!
var forcedCasted: Student

optionalCasted = mike as! UniversityStudent
//optionalCasted = jenny as! UniversityStudent // 런타임 에러
//optionalCasted = jina as! UniversityStudent // 런타임 에러
//optionalCasted = jina as! Student // 런타임 에러


// 활용
func doSomethingWithSwitch(someone: Person) {
    switch someone {
    case is UniversityStudent: // 확인만 할 뿐
        (someone as! UniversityStudent).goToMT() // 직접 캐스팅 필요
    case is Student:
        (someone as! Student).goToSchool()
    case is Person:
        (someone as! Person).breath()
    }
}

doSomethingWithSwitch(someone: mike as Person) // MT 감
doSomethingWithSwitch(someone: mike) // MT 감
doSomethingWithSwitch(someone: jenny) // 등교
doSomethingWithSwitch(someone: yagom) // 숨쉬기

// 이런 식으로 casting 과 동시에 unwrapping 할 수 있다
func doSomething(someone: Person) {
    if let universityStudent = someone as? UniversityStudent {
        universityStudent.goToMT()
    } else if let student = someone as? Student {
        student.goToSchool()
    } else if let person = someone as? Person {
        person.breath()
    }
}

doSomething(someone: mike as Person) // MT
doSomething(someone: mike) // MT
doSomething(someone: jenny) // 등교
doSomething(someone: yagom) // breath




// assert 와 guard
// 어플 동작 도중 생성하는 다양한 결과값
// 동적으로 확인하고, 안전하게 처리할 수 있게 확인하고, 빠르게 처리 가능

// Assertion
// assert(_:_:file:line:) 함수 사용
// 디버깅 모드에서만 작동, 배포하는 어플에선 제외, 주로 디버깅 중 조건 검증용
var someInt: Int = 0

// 조건으로 정한 someInt가 맞으면 그대로 진행, 아니면 뒤 메시지 출력
assert(someInt == 0 , "someInt != 0")

someInt = 1
// assert(someInt == 0) // 동작 중지, 검증 실패
// assert(someInt == 0 , "someInt != 0") // 동작 중지, 검증 실패
// assertion failed: someInt != 0: file guard_assert.swift, line -

// 매개변수 검증
func funcWithAssert(age: Int?) {
    assert(age != nil, "age == nil")
    assert((age! >= 0) && (age! <= 130), "나이값 입력 잘못됨")
    print("당신의 나이는 \(age!)")
}

funcWithAssert(age: 50)
//funcWithAssert(age: -1) // 동작 중지, 검증 실패
//funcWithAssert(age: nil) // 동작 중지, 검증 실패


// Early Exit
// guard 사용하여 잘못된 값 전달 시 특정 실행구문 빠르게 종료
// 디버깅 모드 뿐만 아니라 어떤 조건에도 동작
// guard의 else 블럭 내부에는 특정 코드블럭 종료하는 지시어(return, break 등)
// 꼭 있어야 함. 타입캐스팅, 옵셔널과도 자주 사용, 그 외 단순 조건 판단 후 빠르게 종료

func funcWithGuard(age: Int?) {
    // let-else, guard let 으로 unwrapping 되면 밑에 print 계속 진행
    guard let unwrappedAge = age,
        unwrappedAge < 130,
        unwrappedAge >= 0 else {
            print("나이 입력 오류")
            return
    }
    print("당신의 나이는 \(unwrappedAge)")
}

// 반복문에서도 사용 가능
var count = 1

while true {
    guard count < 3 else {
        break
    }
    print(count)
    count += 1
}

// 딕셔너리와도 많이 사용
func someFunc(info: [String: Any]) {
    // String 으로 타입캐스팅 이후 사용, 안되면 return
    guard let name = info["name"] as? String else {
        return
    }
    // Int 로 타입캐스팅 이후, 조건검증 이후 사용, 안되면 return
    guard let age = info["age"] as? Int, age >= 0 else {
        return
    }
    print("\(name): \(age)")
}

someFunc(info: ["name": "jenny", "age": "10"]) // age가 String
someFunc(info: ["name": "mike"]) // 아예 age가 없음
someFunc(info: ["name": "yagom", "age": "10"]) // 조건이 맞아야 실행




// 프로토콜
// 특정 역할 수행 위한 메서드, 프로퍼티, 이니셜라이저 등의 요구사항 정의
// 구조체, 클래스, 열거형 등 타입에게 프로토콜 준수하게 요구할 수 있음

protocol Talkable {
    // 프로퍼티 요구, 항상 var 사용
    // get 은 읽기만 가능해도 상관 없다는 뜻
    // get 과 set 모두 명시하면 읽기, 쓰기 모두 가능한 프로퍼티여야 함
    var topic: String {get set}
    var language: String {get}

    // 메서드 요구, 직접 구현 말고 이런 메서드가 필요하다 정도
    func talk()

    // 이니셜라이저 요구
    init(topic: String, language: String)
}

// 프로토콜 채택 및 준수
struct Person: Talkable {
    // 둘 다 저장 프로퍼티
    var topic: String   // var은 읽기 쓰기 모두 가능
    let language: String    // 읽기 전용

//    // 읽기전용 프로퍼티 요구는 연산 프로퍼티로 대체 가능
//    var language: String {  return "한국어"  }
//
//    // 물론 읽기, 쓰기 프로퍼티도 연산 프로퍼티로 대체 가능
//    var subject: String = ""
//    var topic: String {
//        set {
//            self.subject = newValue
//        }
//        get {
//            return self.subject
//        }
//    }

    func talk() {
        print("\(topic)에 대해 \(language)로 말한다")
    }

    init(topic: String, language: String) {
        self.topic = topic
        self.language = language
    }
}


// 프로토콜 상속
// 클래스와 다르게 다중상속 가능

protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpaekable: Readable {
    func speak()
}

protocol ReadWriteSpaekable {
    func speak()
}

struct SomeType: ReadWriteSpaekable {
    func read() {
        print("Read")
    }
    func write() {
        print("Write")
    }
    func speak() {
        print("Speak")
    }
}


// 클래스 상속과 프로토콜
// 클래스에서 상속과 프로토콜 채택 동시에 하려면
// 상속 받으려는 클래스 먼저 명시, 그 뒤 채택할 프로토콜 목록 작성
class SuperClass: Readable {
    func read() { print("Read") }
}

class SubClass: SuperClass, Writeable, ReadSpaekable {
    func write() { print("Write") }
    func speak() { print("Speak") }
}


// 프로토콜 준수 확인
// is, as
let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable  // T
someAny is ReadSpaekable    // F

someAny = sub
someAny is Readable  // T
someAny is ReadSpaekable    // T

someAny = sup

if let someReadable: Readable = someAny as? Readable {
    someReadable.read()
}   // 캐스팅 성공 시 read()

if let someReadSpeakable: ReadSpaekable = someAny as? ReadSpaekable {
    someReadSpeakable.speak()
}   // 캐스팅 실패 시 동작하지 않음

someAny = sub

if let someReadable: Readable = someAny as? Readable {
    someReadable.read()
}   // read() 동작





// 익스텐션
// 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능 추가
// 기능 추가하려는 타입의 구현 소스 코드 몰라도, 타입만 알면 기능 확장 가능

// 익스텐션으로 추가 가능한 기능
// 연산 타입 프로퍼티, 연산 인스턴스 프로퍼티
// 타입 메서드, 인스턴스 메서드
// 이니셜라이저
// 서브스크립트
// 중첩 타입
// 특정 프로토콜을 준수할 수 있도록 기능 추가

// 기존에 존재하는 기능은 재정의 불가


// 구현
// 연산 프로퍼티 추가
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 == 1
    }
}

print(1.isEven) // F
print(2.isEven) // T
print(1.isOdd)  // T
print(2.isOdd)  // F

var number: Int = 3
print(number.isEven)    // T
print(number.isOdd)     // F

number = 2
print(number.isEven)    // F
print(number.isOdd)     // T


// 메서드 추가
extension Int {
    func multiply(by n: Int) -> Int {
        return self * n
    }
}
print(3.multiply(by: 2))    // 6
print(4.multiply(by: 5))    // 20

number = 3
print(number.multiply(by: 2))    // 6
print(number.multiply(by: 3))    // 9


// 이니셜라이저 추가
extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }
    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }
}   // Int, Double 타입 String 으로 변환

let stringFromInt: String = String(intTypeNumber: 100)  // 100
let stringFromDouble: String = String(doubleTypeNumber: 100.0)




// 오류표현
// Error 프로토콜과 (주로) 열거형을 통해 오류 표현

enum VendingMachineError: Error {
    case invalidInput
    case insufficientFunds(moneyNeeded: Int)
    case outOfStock
}

// 함수에서 발생한 오류 던지기

// 자판기 동작 도중 발생한 오류 던지기
// 오류 발생 여지 있는 메서드는 throws 사용하여 오류 내포 함수임을 표시
class VendingMachine {
    let itemPrice: Int = 100
    var itemCount: Int = 5
    var deposited: Int = 0

    // 돈 받기 메서드
    func receiveMoney(_ money: Int) throws {

        // 입력한 돈이 0 이하면 오류를 던진다
        guard money > 0 else {
            throw VendingMachineError.invalidInput
        }

        // 오류 없으면 정상처리
        self.deposited += money
        print("\(money)원 받음")
    }

    // 물건 팔기 메서드
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String {

        // 원하는 아이템 수량 잘못 입력되면 오류
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }

        // 구매 수량보다 미리 넣어둔 돈이 적으면 오류
        guard numberOfItemsToVend * itemPrice <= deposited else {
            let moneyNeeded: Int
            moneyNeeded = numberOfItemsToVend * itemPrice - deposited

            throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded)
        }

        // 구매 수량보다 요구 수량 많으면 오류
        guard itemCount >= numberOfItemsToVend else {
            throw VendingMachineError.outOfStock
        }

        // 오류 없으면 정상처리
        let totalPrice = numberOfItemsToVend * itemPrice

        self.deposited -= totalPrice
        self.itemCount -= numberOfItemsToVend

        return "\(numberOfItemsToVend)개 제공"
    }
}

// 자판기 인스턴스
let machine: VendingMachine = VendingMachine()

// 판매 결과 전달 받을 변수
var result: String?

// 오류처리
// 오류발생 여지 있는 throws함수(메서드)는 try로 호출, try, try?, try!
// do-catch 과 함께 사용

do {
    try machine.receiveMoney(0)
} catch VendingMachineError.invalidInput {
    print("입력 오류")
} catch VendingMachineError.insufficientFunds(let moneyNeeded) {
    print("\(moneyNeeded)원 부족")
} catch VendingMachineError.outOfStock {
    print("수량 부족")
}   // 입력 오류

// 이렇게도 표현 가능
do {
    try machine.receiveMoney(300)
} catch {
    switch error {
    case VendingMachineError.invalidInput:
        print("입력 오류")
    case VendingMachineError.insufficientFunds(let moneyNeeded):
        print("\(moneyNeeded)원 부족")
    case VendingMachineError.outOfStock:
        print("수량 부족")
    default:
        print("알수없는 오류 \(error)")
    }
}   // 300원 받음

do {
    result = try machine.vend(numberOfItems: 4)
} catch {
    print(error)
}   // insufficientFunds(100)

do {
    result = try machine.vend(numberOfItems: 4)
}


// try? 별도 오류처리 결과 통보받지 않고 오류 시 결과값 nil로 받음
// 정상 동작 후 옵셔널 타입으로 정상 반환값 돌려 받음
result = try? machine.vend(numberOfItems: 2)
result // Optional("2개 제공")

result = try? machine.vend(numberOfItems: 2)
result // nil

// try! 오류 발생하지 않을 것이라는 강력한 확신 있을 시
// 사용하면 정상동작 후 바로 결과값 돌려받음, 오류 시 런타임 오류 발생하여 어플 동작 중지
result = try! machine.vend(numberOfItems: 1)
result // 1개 제공





// 고차함수
// 전달인자로 함수 전달받거나, 함수실행 결과를 함수로 반환
// map, filter, reduce

// map : 컨테이너 내부 기존 데이터를 변형하여 새로운 컨테이너 생성
let numbers: [Int] = [0, 1, 2, 3, 4]
var doubledNumbers: [Int]
var strings: [String]

// for 구문 사용
doubledNumbers = [Int]()
strings = [String]()

for number in numbers {
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)   // [0, 2, 4, 6, 8]
print(strings)  // ["0", "1,", "2", "3", "4"]

// map 메서드 사용, 클로저도 사용
// numbers 각 요소 2배하여 새로운 배열 반환
doubledNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})

// numbers 각 요소 문자열로 변환하여 새로운 배열 반환
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubledNumbers)   // [0, 2, 4, 6, 8]
print(strings)  // ["0", "1,", "2", "3", "4"]


// 매개변수, 반환타입, 반환키워드 생략, 후행 클로저
doubledNumbers = numbers.map {$0 * 2}
print(doubledNumbers)   // [0, 2, 4, 6, 8]



// filter
// 컨테이너 내부 값 걸러서 새로운 컨테이너로 추출

// for 구문 사용
var filtered: [Int] = [Int]()

for number in numbers {
    if number % 2 == 0 {
        filtered.append(number)
    }
}

print(filtered) // [0, 2, 4]

// filter 메서드 사용
// numbers의 요소 중 짝수를 걸러내어 새로운 배열로 반환
let evenNumbers: [Int] = numbers.filter {
    (number: Int) -> Bool in

    // Bool이 True 일 때만 결과로 들어간다
    return number % 2 == 0
}

print(evenNumbers) // [0, 2, 4]


// 매개변수, 반환타입, 반환키워드 생략, 후행클로저
let oddNumbers: [Int] = numbers.filter {
    $0 % 2 != 0
}

print(oddNumbers) // [1, 3]



// reduce
// 컨테이너 내부의 컨텐츠를 하나로 통합

let someNumbers: [Int] = [2, 8, 15]

// for 구문, 변수 사용에 주목
var result: Int = 0
// someNumbers의 모든 요소 더한다
for number in someNumbers {
    result += number
}
print(result)


// reduce 메서드 사용
// 초깃값 0 이고 someNumbers 내부 모든 값 더한다
let sum: Int = someNumbers.reduce(0, { (first: Int, second: Int) -> Int in
    return first + second
})
print(sum)

// 초깃값 0 이고 someNumbers 내부 모든 값 뺀다
var subtract: Int = someNumbers.reduce(0, { (first: Int, second: Int) -> Int in
    return first - second
})
print(subtract)

// 초깃값 3, someNumbers 내부 모든 값 더한다
let sumFromThree = someNumbers.reduce(3) { $0 + $1 }
print(sumFromThree) // 28
print(someNumbers.reduce(1) { $0 + $1 })    // 240


