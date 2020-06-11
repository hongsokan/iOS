
/*:
 # Chapter 3
 ## Standing On The Shoulders Of Giants
 */


import Cocoa
import XCPlayground

//: ## Implementing a Stack Type
//:
//: ### A stack is a Last In First Out (LIFO) data structure. You can think of a LIFO structure resembling a stack of plates, the last plate added to the stack is the first one removed.


public struct ArrayStack<T> {
    
    fileprivate var elements = [T]()
    
    public init() {}
    
    public init<S : Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    }
    
    mutating public func pop() -> T? {
        return self.elements.popLast()
        
    }
    
    mutating public func push(element: T){
        self.elements.append(element)
    }
    
    public func peek() -> T? {
        return self.elements.last
    }
    
    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
    
}

//: Implement support to support array literal notation. This allows you to write code like the following:
//: `var myStack: ArrayStack<Int> = [4, 5, 6, 7]`

extension ArrayStack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}

//: Implement support for friendly names when printing out type values

extension ArrayStack: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return self.elements.description
    }
    
    public var debugDescription: String {
        return self.elements.debugDescription
    }
    
}

//: We are using an array to store elements in our Stack. The array type provides a `popLast()` we’re able to leverage when implementing out `pop()` method to remove the topmost element from the array.

var myStack = ArrayStack<Int>()

myStack.push(element: 5)
myStack.push(element: 44)
myStack.push(element: 23)

print(myStack)

var x = myStack.pop()
x = myStack.pop()
x = myStack.pop()
x = myStack.pop()
x = myStack.pop()

print(myStack)

myStack.push(element: 87)
myStack.push(element: 2)
myStack.push(element: 9)

print(myStack)

//: Demonstrates using the array literal notation. By calling the `myStack.dynamicType` method we can confirm that an `ArrayStack<Int>` type was created.

myStack = [4,5,6,7]

type(of: myStack)


//: Implement support for `for..in` syntax and to support the `init<S : SequenceType where S.Generator.Element == T>(_ s: S)` initializer.

extension ArrayStack: Sequence {
    
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: self.elements.lazy.reversed()))
    }
}


//: Create a new stack from an existing stack. This will demonstrate using the SequenceType extension and the `init<SequenceType>` initializer.

var myStackFromStack = ArrayStack<Int>(myStack)


//: We can see that `myStackFromStack` is a separate instance from the `myStack` instance as we add new elements to them.

myStackFromStack.push(element: 55)

myStack.push(element: 70)
myStack.push(element: 10)


//: Demonstrate using the SequenceType to provide support for the `for..in` syntax notation

for el in myStack {
    print(el)
}

/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */
