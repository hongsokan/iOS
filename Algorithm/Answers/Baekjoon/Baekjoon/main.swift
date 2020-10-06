//
//  main.swift
//  Test
//
//  Created by 안홍석 on 2020/08/01.
//  Copyright © 2020 안홍석. All rights reserved.
//



// N과 M(1)
let line = (readLine() ?? "")
    .split(separator: " ")
    .map {Int($0) ?? 0}
let n = line[0], m = line[1]
var array = [Int]()
var visited = Array(repeating: false, count: 9)

func dfs(count: Int) {
    if (count == m) {
        for i in 0..<array.count {
            print(array[i])
        }
        return
    }
    
    for i in 1...n {
        if (visited[i] == true) { continue }
        visited[i] = true
        array.append(i)
        dfs(count: count + 1)
        visited[i] = false
        array.removeLast()
    }
}

dfs(count: 0)







/*
// 나이순 정렬
let n = Int(readLine() ?? "") ?? 0
var members = [(id: Int, age: Int, name: String)]()

for i in 0..<n {
    let line = (readLine() ?? "").split(separator: " ").map{String($0)}
    let age = Int(line[0]) ?? 0
    let name = line[1]
    members.append((i, age, name))
}

members.sort { (first, second) -> Bool in
    if first.age == second.age {
        return first.id < second.id
    }
    return first.age < second.age
}

for i in members {
    print(i.age, i.name)
}
*/



/*
// 단어 정렬
let n = Int(readLine() ?? "") ?? 0
var words = [String]()

for _ in 0..<n {
    let input = readLine() ?? ""
    words.append(input)
}

words = Array(Set(words))

let result = words.sorted(by: <).sorted { $0.count < $1.count }

for i in result {
    print(i)
}
*/



/*
// 좌표 정렬하기 2
let n = Int(readLine() ?? "") ?? 0
var coordinate = [(Int, Int)]()

for _ in 0..<n {
    let point = (readLine() ?? "")
        .split(separator: " ")
        .map{Int($0) ?? 0}
    coordinate.append((point[1], point[0]))
}

let result = coordinate.sorted { $0 < $1 }

for (x, y) in result {
    print("\(y) \(x)")
}
*/



/*
// 좌표 정렬하기
let n = Int(readLine() ?? "") ?? 0
var coordinate = [(Int, Int)]()

for _ in 0..<n {
    let point = (readLine() ?? "")
        .split(separator: " ")
        .map{Int($0) ?? 0}
    coordinate.append((point[0], point[1]))
}

// print(coordinate)
// print()

let result = coordinate.sorted { $0 < $1 }

for (x, y) in result {
    print("\(x) \(y)")
}
*/




/*
// 통계학
// 산술평균 : N개의 수들의 합을 N으로 나눈 값
// 중앙값 : N개의 수들을 증가하는 순서로 나열했을 경우 그 중앙에 위치하는 값
// 최빈값 : N개의 수들 중 가장 많이 나타나는 값
// 범위 : N개의 수들 중 최댓값과 최솟값의 차이
import Foundation

let n = Int(readLine()!)!
var array = [Int]()
var sum = 0
var count = [Int: Int]()
var mode = 0

for _ in 0..<n {
    let input = Int(readLine() ?? "") ?? 0
    sum += input
    count[input] = ( count[input] != nil ? count[input]! : 0 ) + 1
    mode = mode < count[input]! ? count[input]! : mode
    array.append(input)
}

array.sort()
let filtered = count.filter{ $0.value == mode }
let countSorted = filtered.sorted{ $0.key < $1.key }

print(Int(round(Double(sum) / Double(n))))
print(array[n / 2])
print(countSorted[countSorted.count > 1 ? 1 : 0].key)
print((array.last ?? 0) - (array.first ?? 0))
*/



// 수 정렬하기 3



/*
// 수 정렬하기 2
let n = Int(readLine() ?? "") ?? 0
var numbers = [Int]()

for _ in 0..<n {
    let num = Int(readLine() ?? "") ?? 0
    numbers.append(num)
}

for i in numbers.sorted() {
    print(i)
}
*/



/*
// 수 정렬하기
let n = Int(readLine() ?? "") ?? 0
var numbers = [Int]()

for _ in 0..<n {
    let num = Int(readLine() ?? "") ?? 0
    numbers.append(num)
}

for i in numbers.sorted() {
    print(i)
}
*/



/*
// 영화감독 숌
let n = Int(readLine() ?? "") ?? 0
var i = 666
var count = 0
var flag = Bool()

while count != n {
    var temp = i
    flag = false
    
    while temp != 0 {
        if temp % 1000 == 666 {
            flag = true
            break
        }
        temp /= 10
    }
    
    if flag { count += 1 }
    i += 1
}

print(i-1)
*/



/*
// 체스판 다시 칠하기
let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let n = line[0], m = line[1]
var board = [String]()

var whiteFirst: [String] = [
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW"
]

var blackFirst: [String] = [
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB",
    "BWBWBWBW",
    "WBWBWBWB"
]

//var whiteFirst: [[String]] = [
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ]
//]
//
//var blackFirst: [[String]] = [
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ],
//    [ "WBWBWBWB" ],
//    [ "BWBWBWBW" ]
//]

func whiteFirstChange(y: Int, x: Int) -> Int {
    var count = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if (board[i][j] != whiteFirst[i-y][j-x]) {
                count += 1
            }
        }
    }
    return count
}

func blackFirstChange(y: Int, x: Int) -> Int {
    var count = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if (board[i][j] != blackFirst[i-y][j-x]) {
                count += 1
            }
        }
    }
    return count
}

for i in 0..<n {
    board[i].append(readLine() ?? "")
}

print(board)
*/



/*
// 덩치
let n = Int(readLine() ?? "") ?? 0
var sizes = [(Int, Int)]()
var rank = 1

for _ in 0..<n {
    let size = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
    sizes.append((size[0], size[1]))
}

for i in 0..<n {
    for j in 0..<n {
        if (sizes[i].0 < sizes[j].0) && (sizes[i].1 < sizes[j].1) {
            rank += 1
        }
    }
    print(rank)
    rank = 1
}
*/



/*
// 분해합
// n과 각 자리수의 합
func divideSum(_ n: Int) {
    var index = 0
    var temp = n
    var sum = 0
    var flag = 0
    
    for i in n-54..<n {
        index = i
        sum = i
        temp = i
        
        while temp > 0 {
            sum += temp % 10
            temp /= 10
            print("sum is \(sum), temp is \(temp)")
        }
        
        if sum == n {
            flag = 1
            break
        }
    }
    
    flag == 1 ? print(index) : print(0)
}

let n = Int(readLine() ?? "") ?? 0
divideSum(n)
*/



/*
// 블랙잭
// 카드 개수 n, 최대값 m
let line1 = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let line2 = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let n = line1[0], m = line1[1]
var cards = [Int]()
var now = 0
for index in 0..<n {
    cards.append(line2[index])
}

for i in 0..<n-2 {
    for j in i+1..<n-1 {
        for k in j+1..<n {
            if (cards[i] + cards[j] + cards[k] <= m &&
                m - (cards[i] + cards[j] + cards[k]) < m - now) {
                now = cards[i] + cards[j] + cards[k]
            }
        }
    }
}

print(now)
*/



/*
// 하노이 탑 이동 순서
// 원판의 개수 n
import Foundation

let n = Int(readLine() ?? "") ?? 0

func hanoi(step: Int, from: Int, to: Int, by: Int) {
    if step == 1 {
        print("\(from) \(to)")
    }
    else {
        hanoi(step: step-1, from: from, to: by, by: to)
        print("\(from) \(to)")
        hanoi(step: step-1, from: by, to: to, by: from)
    }
}

let result = Int(pow(2, Double(n)) - 1)
print(result)
hanoi(step: n, from: 1, to: 3, by: 2)
*/



/*
// 별 찍기 10
// N은 3의 거듭제곱, N=3^k, 1<=k<8
// 3^7 = 2187
// 시간초과
let n = Int(readLine() ?? "") ?? 0
var map = Array(repeating: Array(repeating: " ", count: 2188), count: 2188)

func setStar(r: Int, c: Int, size: Int) {
    if(size == 1) {
        map[r][c] = "*"
        return
    }
    
    let m = size / 3
    
    for i in 0..<3 {
        for j in 0..<3 {
            if (i != 1) || (j != 1) {
                setStar(r: r+i*m, c: c+j*m, size: m)
            }
        }
    }
}

setStar(r: 0, c: 0, size: n)

for i in 0..<n {
    for j in 0..<n {
        print(map[i][j], terminator: "")
    }
    print()
}
*/
 
 

/*
// 피보나치 수 5
let n = Int(readLine() ?? "") ?? 0

func fibo(num: Int) -> Int {
    if num > 1 { return fibo(num: num - 1) + fibo(num: num - 2) }
    else { return num }
}

let result = fibo(num: n)
print(result)
*/



/*
// 팩토리얼
let n = UInt(readLine() ?? "") ?? 0

func recursiveValue(value: UInt) -> UInt {
    if value == 0 { return 1 }
    return value * recursiveValue(value: value - 1)
}

print(recursiveValue(value: n))
*/



/*
// 터렛
// 두 원의 교점의 개수를 구하는 문제
// 1. 원이 두 점에서 만남
// 2. 두 원이 외접(한 점에서 만남)
// 3. 두 원이 내접(한 점에서 만남)
// 4. 하나의 원이 다른 원 포함(만나지 않음)
// 5. 두 원이 멀리 떨어져 만나지 않음
// 6. 두 원이 일치(무수히 많은 점)
import Foundation

let cases = Int(readLine() ?? "") ?? 0

for _ in 0..<cases {
    let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
    var x1 = line[0], y1 = line[1], r1 = line[2]
    var x2 = line[3], y2 = line[4], r2 = line[5]
    
    if r1 > r2 { swap(&r1, &r2) }
    let add = (r1 + r2) * (r1 + r2)
    let sub = (r2 - r1) * (r2 - r1)
    let distance = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    
    if (distance < add && distance > sub) { print(2) }
    else if (distance == add || (distance == sub && distance != 0)) {
        print(1)
    }
    else if (distance < sub || distance > add) {
        print(0)
    }
    else if (distance == 0) {
        if (r1 == r2) { print(-1) }
        else { print(0) }
    }
}
*/



/*
// 택시 기하학
// 유클리드 원의 넓이: pi * r^2
// 택시기하학 원의 넓이: 2 * r^2
import Foundation
 
let pi = Double.pi
let r = Double(readLine() ?? "") ?? 0

let euclid = pi * r * r
let taxi = 2 * r * r

print(String(format: "%.6f", euclid))
print(String(format: "%.6f", taxi))
*/



/*
// 직각삼각형
var input = readLine() ?? ""

while (input != "0 0 0") {
    let line = input
        .split(separator: " ")
        .map{Int($0) ?? 0}.sorted()
    
    if line[0] * line[0] + line[1] * line[1] == line[2] * line[2] {
        print("right")
    }
    else {
        print("wrong")
    }
    
    input = readLine() ?? ""
}
*/



/*
// 네 번째 점
var result = [0, 0]
var vertex = [[Int]]()

for _ in 0..<3 {
    let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
    vertex.append(line)
}

for i in 0..<vertex.count {
    result[0] ^= vertex[i][0]
    result[1] ^= vertex[i][1]
}

print("\(result[0]) \(result[1])")
*/



/*
// 직사각형에서 탈출
let line = (readLine() ?? "")
    .split(separator: " ")
    .map{Int($0) ?? 0}
let x = line[0], y = line[1], w = line[2], h = line[3]
var result = 0

result = min(x, y, w-x, h-y)

if (result < 0) {
    result = result * -1
}

print(result)
*/



/*
// 골드바흐의 추측
let cases = Int(readLine() ?? "") ?? 0
var result = [0, 0]

func isPrime(_ input: Int) -> Bool {
    if input < 2 { return false }
    for index in 2..<input {
        if input % index == 0 {
            return false
        }
    }
    return true
}

for _ in 0..<cases {
    let n = Int(readLine() ?? "") ?? 0
    let half = n / 2
    
    for i in half..<n {
        if isPrime(i) && isPrime(n-i) {
            result[0] = n-i
            result[1] = i
            break
        }
    }
    
    print(result[0], result[1])
}
*/



/*
// 베르트랑 공준
// 임의의 자연수 n, n...2n 사이에 소수 적어도 하나 존재
let n = 123456
var array = Array(repeating: false, count: 2*n+1)

for i in 2...2*n {
    for j in stride(from: i * 2, through: 2*n, by: i) {
        array[j] = true
    }
}

var input = readLine() ?? ""

while (input != "0") {
    let number = Int(input) ?? 0
    var count = 0
    for i in stride(from: number + 1, through: number * 2, by: 1) {
        if array[i] == false {
            count += 1
        }
    }
    print(count)
    
    input = readLine() ?? ""
}
*/



/*
// 소수 구하기
let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let m = line[0]
let n = line[1]
var array = Array(repeating: false, count: n+1)
var count = 0
var result = [Int]()

for i in 2...n {
    if (array[i] == false) && (i >= m) {
        result.append(i)
    }
    
    for j in stride(from: i, through: n, by: i) {
        array[j] = true
    }
}

for n in result {
    print(n)
}


// 시간초과
let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let m = line[0]
let n = line[1]
var result = Array<Int>(m...n)

func isPrime(_ input: Int) -> Bool {
    if input < 2 { return false }
    for index in 2..<input {
        if input % index == 0 {
            return false
        }
    }
    return true
}

for i in (result.filter{isPrime($0)}) {
    print(i)
}
*/



/*
// 소수
// M이상, N이하 자연수 중 소수의 합, 최솟값 구하기
let m = Int(readLine() ?? "") ?? 0
let n = Int(readLine() ?? "") ?? 0
var sum = [Int]()
var minValue = 0

func isPrimeNumber(x: Int) -> Bool {
    if x < 2 { return false }
    
    for i in 2..<x {
        if (x % i == 0) { return false }
    }
    
    return true
}

for num in m...n {
    if isPrimeNumber(x: num) { sum.append(num) }
}

if sum.isEmpty { print(-1) }
else {
    print(sum.reduce(0, +))
    print(sum.min() ?? 0)
}
*/



/*
// 소수 찾기
let cases = Int(readLine() ?? "") ?? 0
let numbers = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
var count = 0

func isPrimeNumber(x: Int) -> Bool {
    if x < 2 { return false }
    
    for i in 2..<x {
        if (x % i == 0) { return false }
    }
    
    return true
}

for num in numbers {
    if isPrimeNumber(x: num) { count += 1 }
}

print(count)
*/



/*
// Fly me to the Alpha Centauri
// 현재위치 x, 목표위치 y, 0 <= x < y < 2^31
// k-1, k, k+1 만큼 이동 가능
// 처음엔 x 에서 1 광년 이동, y 지점 도착하기 직전 이동거리도 반드시 1 (y-1)
let cases = Int(readLine() ?? "") ?? 0

func move(from x: Int, to y: Int) -> Int {
    var count = 0
    var moveX = 0
    var moveY = 0
    var tempX = x
    var tempY = y
    
    while true {
        count += 1
        tempX += count
        moveX += 1
        
        if tempX >= tempY { break }
        
        tempY -= count
        moveY += 1
        
        if tempX >= tempY { break }
    }
    return moveX + moveY
}

for _ in 0..<cases {
    let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
    let x = line[0], y = line[1]
    
    let result = move(from: x, to: y)
    print(result)
}
*/



/*
// 부녀회장이 될테야
// k층 n호에 살려면, k-1층의 1호부터 n호까지 사람들의 수의 합만큼 사람들 데려와 살아야 한다
// 0층부터 있고, 각층은 1호부터, 0층 n호에는 n명이 산다
// 0층1호 1명, 0층2호 2명, 0층3호 3명, ...
// 1층1호 1명, 1층2호 3명, 1층3호 6명, ...
// 2층1호 1명, 2층2호 4명, 2층3호 10명, ...

let cases = Int(readLine() ?? "") ?? 0

func recursiveValue(k: Int, n: Int) -> Int {
    if k == 0 {
        return n
    }
    if n == 1 {
        return 1
    }
    
    // print("\(k-1) \(n)")
    // print("\(k) \(n-1)")
    
    // print("recur k-1,n :" + "\(recursiveValue(k: k-1, n: n))")
    // print("recur k,n-1 :" + "\(recursiveValue(k: k, n: n-1))")
    
    print("recur : " + "\(recursiveValue(k: k-1, n: n) + recursiveValue(k: k, n: n-1))")
    
    return recursiveValue(k: k-1, n: n) + recursiveValue(k: k, n: n-1)
}

for _ in 0..<cases {
    let k = Int(readLine() ?? "") ?? 0 // k층
    let n = Int(readLine() ?? "") ?? 0 // n호
    
    let result = recursiveValue(k: k, n: n)
    print(result)
}
*/



/*
// ACM 호텔
let cases = Int(readLine() ?? "") ?? 0

for _ in 0..<cases {
    let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
    let h = line[0], w = line[1], n = line[2]
    var floor = n % h, room = n / h + 1
    var roomNumber = 0
    
    if (n % h) == 0 {
        room = n / h
        floor = h
    }
    
    roomNumber = floor * 100 + room
    
    print(roomNumber)
}
*/



/*
// 달팽이는 올라가고 싶다
// 높이 V
// 낮동안 +A
// 밤동안 -B

let line = (readLine() ?? "").split(separator: " ").map{Int($0) ?? 0}
let a = line[0], b = line[1], v = line[2]

let day = (v-b-1)/(a-b)+1

print(day)

 
// 시간초과
//var up = 0
//var day = 0
//
//while up < v {
//    day += 1
//    up += a
//    if up >= v { break }
//    up -= b
//}
//print(day)
*/



/*
// 분수찾기
// 1/1
// 2/1, 1/2
// 3/1, 2/2, 1/3
// 4/1, 3/2, 2/3, 1/4
// 5/1, 4/2, 3/3, 2/4, 1/5
// ... , 지그재그 순

let X = Int(readLine() ?? "") ?? 0
var sum = 0
var count = 0

// 1번째 분수 -> 분자와 분모 합이 2
// 2,3 -> 합이 3
// 4,5,6 -> 합이 4
// 7,8,9,10 -> 합이 5

while true {
    count += 1
    sum += count
    if sum >= X {
        break
    }
}

// 지그재그 순, 짝수 분수와 홀수 분수의 각 시작점이 다르다
// 짝수는 위(분자)가 더 큰 것부터 시작
// 홀수는 아래(분모)가 더 큰 것부터 시작
var top = ((count+1) % 2 == 0) ? count : 1
var bottom = ((count+1) % 2 == 0) ? 1 : count

for _ in (sum-count+1)..<X {
    if (count+1) % 2 == 0 {
        top += -1
        bottom += 1
    } else {
        top += 1
        bottom += -1
    }
}

print("\(top)/\(bottom)")
*/



/*
// 벌집
// 1, 6, 12, 18, 24, ...
// i = 0, 1, 2, 3, 4,
let n = Int(readLine() ?? "") ?? 0
var count = 0
var temp = 1

while true {
    count += 1
    if temp >= n { break }
    temp += count * 6
}

print(count)
*/



/*
// 설탕 배달
let n = Int(readLine() ?? "") ?? 0
var weight5 = -1
var weight3 = 0

//if n % 5 == 0 {
//    weight5 = n / 5
//    print(weight5)
//}

//else {
for i in stride(from: (n / 5), through: 0, by: -1) {
    // print(i)
    if (n - 5 * i) % 3 == 0 {
        weight5 = i
        weight3 = (n - 5 * i) / 3
        break
    }
}
//}

let result = weight5 + weight3
print(result)
*/



/*
// 손익분기점
let numbers = (readLine() ?? "").split(separator: " ").map{ Int($0) ?? 0 }
var fixedA = numbers[0], variableB = numbers[1], priceC = numbers[2]

var result = 0

if priceC - variableB <= 0 {
    result = -1
} else {
    result = fixedA / (priceC - variableB) + 1
}

print(result)
*/



/*
// 그룹 단어 체커
let n = Int(readLine() ?? "") ?? 0
var count = 0

func checkIsGroup() -> Int {
    
    var checked = [Character]()
    let input = readLine() ?? ""
    var before = Character("-")
    
    // 입력 받을 단어 input, 단어의 각 문자 item
    for item in input {
        if checked.contains(item) { // 그룹 단어가 아닌 경우
            return 0
        }
        // 연속으로 같은 단어가 아닌 경우 (ex. "happy"에서 "pp"는 그룹 단어, "hapyp"면 그룹 단어 아님)
        if before != item {
            checked.append(before)
            before = item
        }
    }
    
    return 1
}

for _ in 0..<n {
    // n개의 단어 입력 받음
    // 단어를 checkIsGroup에서 입력 받고, true면 1, false면 0
    count += checkIsGroup()
}

print(count)
*/



/*
// 크로아티아 알파벳
import Foundation

var word = readLine() ?? ""
var croatias = ["c=", "c-", "dz=", "d-", "lj", "nj", "s=", "z="]
var count = 0

for i in 0..<croatias.count {
    word = word.replacingOccurrences(of: croatias[i], with: "~")
    // print(word)
}

print(word.count)
*/



/*
// 다이얼
// 1 = 2sec
// 2 = 3s
// ...
// 9 = 10s
// 0 = 11s

var count = 0

let inputString = readLine() ?? ""

for str in inputString {
    let alphabet = str
    switch alphabet {
    case "A","B","C": count += 3    // ; print("+3")
    case "D","E","F": count += 4    // ; print("+4")
    case "G","H","I": count += 5    // ; print("+5")
    case "J","K","L": count += 6    // ; print("+6")
    case "M","N","O": count += 7    // ; print("+7")
    case "P","Q","R","S": count += 8    // ; print("+8")
    case "T","U","V": count += 9    // ; print("+9")
    case "W","X","Y","Z": count += 10   // ; print("+10")
    default: print("error")
    }
}

print(count)
*/



/*
// 상수
let input = readLine() ?? ""
let numbers = input
    .split(separator: " ")
    .map{Int($0)!}
var result = [Int]()

for num in numbers {
    let reversedNum = (num % 10) * 100 + (num / 10 % 10) * 10 + num / 100
    result.append(reversedNum)
}

print(result.max()!)
*/



/*
// 단어의 개수
let sentence = readLine() ?? ""
let result = sentence.split(separator: " ").count
print(result)
*/



/*
// 단어 공부
let word = (readLine() ?? "").uppercased()
var alphabets = Array(repeating: 0, count: 26)

for char in word {
    // ASCII A~Z(65~90)
    let charIndex = Int(UnicodeScalar(String(char))?.value ?? 0) - 65
    // let char = char
    
    alphabets[charIndex] += 1
    
    // print("\(charIndex) : \(char)")
}

// print(alphabets)

let maxCount = alphabets.max()!
var result = [Int: Int]()

for i in 0..<alphabets.count {
    if alphabets[i] == maxCount {
        result.updateValue(alphabets[i], forKey: i)
    }
}

// print(result)

if result.count != 1 {
    print("?")
} else {
    print( UnicodeScalar(result.first!.key + 65) ?? "?" )
}
*/



/*
// 문자열 반복
let cases = Int(readLine() ?? "") ?? 0

for _ in 0..<cases {
    var temp = ""
    let repeatString = (readLine() ?? "")
        .split(separator: " ")
        .map{String($0)}
    
    let repeats = Int(repeatString[0])!
    let string = repeatString[1]
    
    for character in string {
        let char = String(character)
        for _ in 0..<repeats {
            temp += char
        }
    }
    print(temp)
}
*/



/*
// 알파벳 찾기

// print( Int (UnicodeScalar("a").value - 96) ) // 1
// print( Int (UnicodeScalar("z").value - 96) ) // 26

// baekjoon
// 1 0 -1 -1 2 -1 -1 -1 -1 4 3 -1 -1 7 5 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1

let line = readLine() ?? ""
var result = Array(repeating: -1, count: 26)

for (index, char) in line.enumerated() {
    let lineIndex = index
    let alphaIndex = Int(UnicodeScalar( String(char) )?.value ?? 0) - 97
    
    // print("\(lineIndex) : \(alphaIndex)")
    
    if result[alphaIndex] == -1 {
        result[alphaIndex] = lineIndex
    }
}

for n in result {
    print(n, terminator: " ")
}


//let line = readLine() ?? ""
//let checkers = "abcdefghijklmnopqrstuvwxyz"
//var result: [Int] = []
//for checker in checkers {
//    if let index = line.firstIndex(of: checker) { result.append(line.distance(from: line.startIndex, to: index))
//    } else {
//        result.append(-1)
//    }
//}
//print(result.reduce("") { "\($0)\($1) " } )
*/



/*
// 숫자의 합
let N = Int( readLine() ?? "" ) ?? 0
let numbers = readLine() ?? ""
var result = [Int]()

for num in numbers {
    result.append(Int(String(num))!)
}

print(result.reduce(0,+))
*/
 
 

/*
// 아스키 코드
let ascii = UnicodeScalar( readLine() ?? "" )!.value
print(ascii)
*/



/*
// 한수
var N = Int( readLine() ?? "") ?? 0
var count = 0

for number in 1...N {
    if number < 100 { count += 1; continue; }
    
    if (number / 100 - (number % 100) / 10 == (number % 100) / 10 - number % 10) {
        count += 1
    }
}

print(count)
*/



/*
// 셀프 넘버
// 수열 판별식
func sequenceNumber() -> [Int] {
    
    var results = [Int]() // 수열
    
    for i in 1...10000 {
        // 배열에서 판별할 숫자의 각 자리수 합
        var digits = [Int]() // 각 자리수
        
        var sum = i
        while sum != 0 {
            digits.append( sum % 10)
            sum = sum / 10
        }
        // 판별 숫자와 각 자리수의 합, 수열에 추가
        results.append( i + digits.reduce(0, +) )
    }
    return results
}

let sequenceSet: Set<Int> = Set<Int>( sequenceNumber() )
let subtractedNumbers: Set<Int> = Set<Int>(1...10000).subtracting(sequenceSet)
let selfNumbers = subtractedNumbers.sorted()

for i in selfNumbers {
    print(i)
}
*/



// 정수 N개의 합
// 이 문제는 C, C++, Python, Java, Go만 지원합니다.



/*
// 평균은 넘겠지
let C = Int(readLine() ?? "") ?? 0 // 테스트 케이스 C개
var result = [String]()

for _ in 0..<C {
    let line = (readLine() ?? "").split(separator: " ").map{Int($0)!}
    let students = line[0]
    
    if students >= 1 && students <= 1000 {
        let scores = Array(line[1...students])
        let average = Double( scores.reduce(0, +) ) / Double(students)
        let passedStudents = scores
            .map { Double($0) }
            .filter { $0 > average }
            .count
        let passedRatio = Double(passedStudents) / Double(students) * 100
        result.append( String(format: "%.3f", passedRatio) + "%" )
    }
}

for ratio in result {
    print(ratio)
}
*/



/*
// OX퀴즈
let N = Int(readLine() ?? "") ?? 0
var cases = [String]()
var score = Array(repeating: 0, count: N)

for _ in 0..<N {
    cases.append( readLine() ?? "" )
}

for i in 0..<cases.count {
    var count = 1
    for j in cases[i] {
        if j == "O" {
            score[i] += count
            count += 1
        } else {
            count = 1
        }
    }
    print(score[i])
}
*/



/*
// 평균
let N = Int(readLine() ?? "") ?? 0
var scores = (readLine() ?? "").split(separator: " ").map{Double($0) ?? 0}
let maxScore = scores.max() ?? 0

for i in 0..<N {
    scores[i] = (scores[i] / maxScore) * 100
}

let result = scores.reduce(0, +) / Double(N)
print(result)
*/



/*
// 나머지
var array = [Int](repeating: 0, count: 10)

for i in 0..<array.count {
    array[i] = Int(readLine() ?? "") ?? 0
    array[i] = array[i] % 42
}

var set: Set = Set(array)
print(set.count)
*/



/*
// 숫자의 개수
var array = [Int](repeating: 0, count: 10)
let a = Int(readLine() ?? "") ?? 0
let b = Int(readLine() ?? "") ?? 0
let c = Int(readLine() ?? "") ?? 0
var result = a * b * c // 3개 숫자의 곱

while result != 0 { // 결과에서 1의 자리수부터 차례대로 검사
    let index = result % 10
    result = result / 10
    array[index] += 1 // 배열에서 해당되는 숫자 인덱스 +1
}

array.forEach { print($0) }
*/



/*
// 최댓값
var numbers = [Int]()
for _ in 0..<9 {
    numbers.append( Int(readLine() ?? "") ?? 0 )
}
var max = 0
var i = 0
for (index, number) in numbers.enumerated() {
    if number > max {
        max = number
        i = index + 1
    }
}

print(max)
print(i)
*/



/*
// 최소,최대
// 백준 시간초과 -> c언어로 해결
let N = Int(readLine() ?? "") ?? 0
let numbers = (readLine() ?? "").split(separator: " ").map{Int($0)!}
var max = 0
var min = 0
for x in numbers {
    if x > max {
        max = x
    } else {
        min = x
    }
}
print("\(min) \(max)")
*/



/*
// 별 찍기 - 21
let N = Int(readLine() ?? "") ?? 0

if N == 1 { print("*") }
else {
    
    var line1 = "*"
    var line2 = " "
    
    for i in stride(from: 0, to: N-1, by: 1) {
        
        if i % 2 == 0 {
            line1 += " "
            line2 += "*"
        }
        else {
            line1 += "*"
            line2 += " "
        }
        
    }
    
    for _ in 1...N {
        print(line1)
        print(line2)
    }
}
*/



/*
// 별 찍기 - 9
let N = Int(readLine() ?? "") ?? 0

var star = "*"
var space = " "

if N == 1 { print("*") }
//else if N < 1 { print("Out of Range") }
//else if N >= 100 { print("Out of Range") }
else {
    for _ in 0..<2*N-2 {
        star += "*"
    }
    print(star)
    
    for _ in 0..<N-1 {
        star = space + star
        star.removeLast()
        star.removeLast()
        print(star)
    }
    
    for _ in 0..<N-1 {
        star.removeFirst()
        star += "*"
        star += "*"
        print(star)
    }
}
*/



/*
for _ in 0..<2*N-1 {
    star.removeLast()
    star.removeLast()
    star = space + star
    print(star)
}

star += "*"

for _ in 0..<N-1 {
    star.removeFirst()
    star += "*"
    star += "*"
    print(star)
}
*/


/*
// 별 찍기 - 13
// 첫째 줄부터 2×N-1번째 줄까지 차례대로 별을 출력
let N = Int(readLine() ?? "") ?? 0
var star = ""

for _ in 0..<N {
    star = star + "*"
    print(star)
}

for _ in stride(from: star.count, to: 1, by: -1) {
    star.removeLast()
    print(star)
}
*/



/*
// 세 수
let line = readLine() ?? ""
let result = line.split { $0 == " " }.compactMap { Int($0) }.sorted()[1]
print(result)
*/



/*
// 상근날드
var hamburgers = [Int]()
var drinks = [Int]()
var cheapestSet = 0

for _ in 0..<3 {
    hamburgers.append( Int(readLine() ?? "") ?? 0 )
}

for _ in 0..<2 {
    drinks.append( Int(readLine() ?? "") ?? 0 )
}

cheapestSet = hamburgers.sorted()[0] + drinks.sorted()[0] - 50
print(cheapestSet)
*/



/*
// 평균 점수
var numArray = [Int]()
var average = 0

for _ in 0..<5 {
    var input = Int(readLine() ?? "") ?? 0
    if input < 40 {
        input = 40
    }
    numArray.append(input)
}

average = numArray.reduce(0, +) / numArray.count
print(average)
*/



/*
// 더하기 사이클
let N = Int(readLine() ?? "") ?? 0 // N은 0~99, 정수

var temp = N
var count = 0

repeat {
    count += 1
    if temp < 10 { // 입력 받은 숫자가 10보다 작다면
        temp = temp * 11 // 앞에 0을 붙이고 새로운 수
        continue // (ex. 0+8=8, 새로운 수 88, * 11 과 같음)
    }
    
    // 새로운 숫자는 (N의 1의 자리수 * 10) + (N 두 자리수의 합 % 10)
    temp = (temp % 10) * 10 + (temp / 10 + temp % 10) % 10
    
} while temp != N

print(count)
*/



/*
// A+B - 5

var sum = 0

repeat {
    sum = (readLine() ?? "")
        .split { $0 == " " }
        .compactMap { Int($0) }
        .reduce(0, +)
    if sum != 0 {
        print(sum)
    }
}
while sum != 0
*/



/*
// X보다 작은 수
let line1 = readLine() ?? "" // N 과 X (X보다 작은 수만 출력)
let line2 = readLine() ?? "" // 수열 A (숫자 N개)
let lineArr = line1.split { $0 == " " }.compactMap { Int($0) }
let result = line2.split { $0 == " " }
    .compactMap { Int($0) }
    .filter { $0 < lineArr[1] }
    .reduce("") {"\($0)\($1) "}

print(result)
*/

/*
// X보다 작은 수, 시간초과
for i in 0..<Int(line1.components(separatedBy: " ")[0])! {
    
    if Int(line2.components(separatedBy: " ")[i])! <
        Int(line1.components(separatedBy: " ")[1])!
    {
        print("\(line2.components(separatedBy: " ")[i])", terminator: " ")
    }
}
*/



/*
// 별 찍기 - 2
let line = Int(readLine()!)!
let star = "*"
let space = " "

for i in 1...line {
    
    for _ in stride(from: line-i, to: 0, by: -1) {
        print("\(space)", terminator: "")
    }
    
    for _ in 1...i {
        print("\(star)", terminator: "")
    }
    
    print()
}
*/



/*
// 별 찍기 - 1
let line = Int(readLine()!)!
var star = "*"

for _ in 1...line {
    print("\(star)")
    star = star + "*"
}
*/



/*
// A+B - 8
let line = Int(readLine()!)!

for i in 1...line {
    let line = readLine()!
    print( "Case #\(i): " +
        "\(line.components(separatedBy: " ")[0]) + " +
        "\(line.components(separatedBy: " ")[1]) = " +
        "\(line.components(separatedBy: " ").map{Int($0)!}.reduce(0,+))" )
}
*/



/*
// A+B - 7
let line = Int(readLine()!)!

for i in 1...line {
    let line = readLine()!
    print( "Case #\(i): \(line.components(separatedBy: " ").map{Int($0)!}.reduce(0,+))" )
}
*/



/*
// 기찍 N
let line = Int(readLine()!)!

for i in stride(from: line, to: 0, by: -1) {
    print("\(i)")
}
*/
 


/*
// N 찍기
let line = Int(readLine()!)!

for i in 1...line {
    print("\(i)")
}
*/



/*
// 빠른 A+B, Swift
let line = Int(readLine()!)!

for _ in 1...line {
    let line = readLine()!
    print( line.components(separatedBy: " ").map{Int($0)!}.reduce(0,+) )
//    print("\( Int(line.components(separatedBy: " ")[0])! + Int(line.components(separatedBy: " ")[1])! )")
}
// -> 시간 초과
// fread로 여러 바이트를 한번에 읽고, 정수를 읽어야 할 때마다 미리 읽어둔 문자열로부터 정수를 파싱하면 됩니다. 꽤 복잡한 방법이지만, 이것보다 간단한 방법은 아직 찾지 못했습니다.
*/



/*
// 합
let line = readLine()!
let n = (Int(line)!)
var sum = 0

for i in 1...n {
    sum += i
}

print("\(sum)")
*/
 
 

/*
// A+B
let line = readLine()!
let n = (Int(line)!)

for _ in 1...n {
    let line = readLine()!
    let lineArr = line.components(separatedBy: " ")
    let x = Int(lineArr[0])!
    let y = Int(lineArr[1])!
    print("\(x + y)")
}
*/



/*
// 구구단
let line = readLine()!
let n = (Int(line)!)

for i in 1..<10 {
    print("\(n) * \(i) = \(n * i)")
}
*/



/*
// 알람 시계
let line = readLine()!
let lineArr = line.components(separatedBy: " ")
var h = Int(lineArr[0])!
var m = Int(lineArr[1])!

m -= 45

if (m < 0) {
    
    h -= 1
    
    if (h < 0) { print("\(h+24) \(m+60)") }
        
    else { print("\(h) \(m+60)") }
}

else { print("\(h) \(m)") }
*/



/*
// 사분면 고르기

let line1 = readLine()!
let line2 = readLine()!
let x = (Int(line1)!)
let y = (Int(line2)!)


if (x == 0 || y == 0) { print("0 is not available") }
else if (x > 0 && y > 0) { print("1") }
else if (x < 0 && y > 0) { print("2") }
else if (x < 0 && y < 0) { print("3") }
else if (x > 0 && y < 0) { print("4") }
else { print("0") }
*/



/*
// 윤년 계산

let line = readLine()!
let year = (Int(line)!)

if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
    print(1)
}
else {
    print(0)
}
*/



/*
// 성적
let line = readLine()!
let score = (Int(line)!)

if score >= 90 && score <= 100 { print("A") }
else if score >= 80 && score <= 89 { print("B") }
else if score >= 70 && score <= 79 { print("C") }
else if score >= 60 && score <= 69 { print("D") }
else { print("F") }
*/
 


/*
// 크기 비교
let line = readLine()!
let lineArr = line.components(separatedBy: " ")
let a = Int(lineArr[0])!
let b = Int(lineArr[1])!

if a > b {
    print(">")
} else if a < b {
    print("<")
} else if a == b {
    print("==")
} else {
    print("Error")
}
*/



/*
var num1 = 472
var num2 = 385

print(num2 / 100) // 3
print(num2 % 100 / 10) // 8
print(num2 % 10) // 5
*/



/*
// 사칙연산
let line1 = readLine()!
let line2 = readLine()!
let a = Int(line1)!
let b = Int(line2)!

let result3: Int = (a * (b%10))
let result4: Int = (a * (b % 100 / 10))
let result5: Int = (a * (b/100))

print(result3)
print(result4)
print(result5)
print(result3 + result4 * 10 + result5 * 100)
*/
