import UIKit

// Swift Fun Algorithms #6: Fibonacci Sequence

// implement a function that returns this sequence in an array
// 0, 1, 1, 2, 3, 5, 8, ...

func fibForNumSteps(numSteps: Int) -> [Int] {
    var sequence = [0, 1]
    
    if numSteps <= 1 {
        return sequence
    }
    
    for _ in 0...numSteps - 2 {
        let first = sequence[sequence.count - 2]
        let second = sequence.last!
        sequence.append(first + second)
    }
    
    return sequence
}


fibForNumSteps(numSteps: 1)
fibForNumSteps(numSteps: 2)
fibForNumSteps(numSteps: 6)



func fibRecursionForNumSteps(numSteps: Int, first: Int, second: Int) -> [Int] {
    if numSteps == 0 {
        return []
    }
    
    print(first, second)
    
    return [first + second] + fibRecursionForNumSteps(numSteps: numSteps - 1, first: second, second: first + second)
}

//fibRecursionForNumSteps(numSteps: 9, first: 0, second: 1)
[0, 1] + fibRecursionForNumSteps(numSteps: 9, first: 0, second: 1)
