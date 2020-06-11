//
// BloomFilter.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Erik J. Azar & Mario Eguiluz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

public struct BloomFilter<T> {
    var arrayBits:[Bool] = Array(repeating: false, count: 17)
    var hashFunctions:[(T) -> Int]
    
    public init(hashFunctions:[(T) -> Int]) {
        self.hashFunctions = hashFunctions
    }
    
    //Execute each hash function of our filter agains the element and returns an array of Ints as result
    private func calculeHashes(element:T) -> [Int]{
        return hashFunctions.map() {
            hashFunc in abs(hashFunc(element) % arrayBits.count)
        }
    }
    
    //Insert an element results in converting some bits of our arrayBits into '1's, depending on the results of each hash function
    public mutating func insert(element: T) {
        for hashValue in calculeHashes(element:element) {
            arrayBits[hashValue] = true
        }
    }
    
    //Check for existence of an element in the bloom filter
    public func exists(element:T) -> Bool {
        let hashResults = calculeHashes(element: element)
        
        //Check hashes agains the array of the filter
        let results = hashResults.map() { hashValue in arrayBits[hashValue] }
        
        //NO is 100% true. YES could be a false positive.
        let exists = results.reduce(true, { $0 && $1 })
        return exists
    }
}

//Hash functions see http://www.cse.yorku.ca/~oz/hash.html
func djb2(x: String) -> Int {
    var hash = 5381
    for char in x.characters {
        hash = ((hash << 5) &+ hash) &+ char.hashValue
    }
    return Int(hash)
}

func sdbm(x: String) -> Int {
    var hash = 0
    for char in x.characters {
        hash = char.hashValue &+ (hash << 6) &+ (hash << 16) &- hash
    }
    return Int(hash)
}
