//: [Previous](@previous)

import Foundation

//: ## Implementing a CircularBuffer type
//:
//: ### The CircularBuffer structure is a fixed-size data structure that connects the head and tail indexes together to form a continuous circle.
//:
//: When the buffer becomes full the oldest elements will be overwriten by new ones. This feature can be changed from it's default behavior by using the overloaded `init(count:repeatedValue:overwriteOperation)` initializer and passing `CircularBufferOperation.Ignore` flag for `overwriteOperation`.

public struct CircularBuffer<T> {
    
    fileprivate var data: [T]
    
    fileprivate var head: Int = 0, tail: Int = 0
    
    private var internalCount: Int = 0
    
    private var overwriteOperation: CircularBufferOperation = CircularBufferOperation.Overwrite
    
    /// Constructs an empty CircularBuffer.
    public init() {
        data = [T]()
        data.reserveCapacity(Constants.defaultBufferCapacity)
    }
    
    /// Construct a CircularBuffer of `count` elements
    ///
    /// - remark: If `count` is not a power of 2 it will be incremented to the next closest power of 2 of its value.
    public init(_ count:Int, overwriteOperation: CircularBufferOperation = .Overwrite){
        var capacity = count
        if (capacity < 1) {
            capacity = Constants.defaultBufferCapacity
        }
        
        // Ensure that `count` is a power of 2
        if ((capacity & (~capacity + 1)) != capacity) {
            var b = 1
            while (b < capacity) {
                b = b << 1
            }
            capacity = b
        }
        
        data = [T]()
        data.reserveCapacity(capacity)
        self.overwriteOperation = overwriteOperation
    }
    
    /// Constructs a CircularBuffer from a sequence.
    public init<S: Sequence>(_ elements: S, size: Int) where S.Iterator.Element == T {
        self.init(size)
        elements.forEach({ push(element: $0) })
    }
    
    /// Removes and returns the first `element` in the buffer.
    ///
    /// - returns:
    ///     - If the buffer not empty, the first element of type `T`.
    ///     - If the buffer is empty, 'nil' is returned.
    public mutating func pop() -> T? {
        if (isEmpty()){
            return nil
        }
        
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount -= 1
        return el
    }
    
    /// Returns the first `element` in the buffer without removing it.
    ///
    /// - returns: The first element of type `T`.
    ///
    public func peek() -> T? {
        if (isEmpty()){
            return nil
        }
        
        return data[head]
    }
    
    /// Appends `element` to the end of the buffer.
    ///
    /// The default `overwriteOperation` is `CircularBufferOperation.Overwrite`, which overwrites the oldest elements first if the buffer capacity is full.
    ///
    /// If `overwriteOperation` is `CircularBufferOperation.Ignore`, when the capacity is full newer elements will not be added to the buffer until exisint elements are removed.
    ///
    /// - complexity: O(1)
    /// - parameter element: An element of type `T`
    public mutating func push(element: T) {
        if (isFull()){
            switch(overwriteOperation){
            case .Ignore:
                // Do not add new elements until the count is less than the capacity
                return
            case .Overwrite:
                pop()
            }
        }
        
        if (data.endIndex < data.capacity) {
            data.append(element)
        }
        else {
            data[tail] = element
        }
        
        tail = incrementPointer(pointer: tail)
        internalCount += 1
    }
    
    /// Resets the buffer to an empty state
    public mutating func clear() {
        head = 0
        tail = 0
        internalCount = 0
        data.removeAll(keepingCapacity: true)
    }
    
    /// Returns the number of elements in the buffer.
    ///
    /// `count` is the number of elements in the buffer.
    public var count: Int {
        return internalCount
    }
    
    /// Returns the capacity of the buffer.
    public var capacity: Int {
        get {
            return data.capacity
        }
        
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    /// Check if the buffer is full.
    ///
    /// - returns: `True` if the buffer is full, otherwise it returns `False`.
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    /// Check if the buffer is empty.
    ///
    /// - returns: `True` if the buffer is empty, otherwise it returns `False`.
    public func isEmpty() -> Bool {
        return (count < 1)
    }
    
    /// Increment a pointer value by one.
    ///
    /// - remark: This method handles wrapping the incremented value if it would be beyond the last element in the array.
    fileprivate func incrementPointer(pointer: Int) -> Int {
        return (pointer + 1) & (data.capacity - 1)
    }
    
    /// Decrement a pointer value by 1.
    ///
    /// - remark: This method handles wrapping the decremented value if it would be before the first element in the array.
    fileprivate func decrementPointer(pointer: Int) -> Int {
        return (pointer - 1) & (data.capacity - 1)
    }
    
    /// Converts a logical index used for subscripting to the current internal array index for an element.
    ///
    fileprivate func convertLogicalToRealIndex(logicalIndex: Int) -> Int {
        return (head + logicalIndex) & (data.capacity - 1)
    }
    
    /// Verifies `index` is within range
    fileprivate func checkIndex(index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
}

//: Constant used for setting the default buffer capacity if a capacity is not specified.

private struct Constants {
    fileprivate static let defaultBufferCapacity:Int = 16
}

//: The CircularBufferOperation enum is used to control the buffer full behavior when adding new elements.

public enum CircularBufferOperation {
    case Ignore, Overwrite
}

//: Add support to print out friendly type names

extension CircularBuffer: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return data.description
    }

    public  var debugDescription: String {
        return data.debugDescription
    }
}


//: Demonstrate based options for using the CircularBuffer structure.

var circularBuffer = CircularBuffer<Int>()
circularBuffer.push(element: 4)
circularBuffer.push(element: 7)
circularBuffer.push(element: 9)
circularBuffer.push(element: 11)

//: Implement support for for..in syntax and to support the init<S: SequenceType where S.Generator.Element == T>(_ elements: S, size: Int) initializer.

extension CircularBuffer: Sequence {

    /// Returns a *generator* over the elements of this *sequence*.
    ///
    /// - Complexity: O(1).
    public func makeIterator() -> AnyIterator<T> {
        var newData = [T]()

        if count > 0 {
            newData = [T](repeating: data[head], count: count)
            if head > tail {
                // number of elements to copy for first half
                let front = data.capacity - head
                newData[0..<front] = data[head..<data.capacity]

                if front < count {
                    newData[front + 1..<newData.capacity] = data[0..<count - front]
                }
            }
            else {
                newData[0..<tail - head] = data[head..<tail]
            }
        }

        return AnyIterator(IndexingIterator(_elements: newData.lazy))
    }
}


//: Demonstrate using the Sequence initializer.

var circBufferFromCircBuffer = CircularBuffer<Int>(circularBuffer, size: circularBuffer.count)

//: Implement support to support array literal notation. This allows you to write code like the following: var myCircularBuffer: CircularBuffer<Int> = [4, 5, 6, 7]

extension CircularBuffer: ExpressibleByArrayLiteral {

    /// Constructs a circular buffer using an array literal.
    public init(arrayLiteral elements: T...) {
        self.init(elements, size: elements.count)
    }
}


//: Demonstrate using array literal notation

var circularBufferUsingArrayLiteralNotation: CircularBuffer<Int> = [4,5,6,7,8]



/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */
