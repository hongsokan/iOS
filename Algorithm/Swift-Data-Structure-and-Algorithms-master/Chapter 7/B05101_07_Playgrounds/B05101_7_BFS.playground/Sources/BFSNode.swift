//
// BFSNode.swift
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

public class BFSNode<T> {

    //Value, visit status and reference vars
    public var value:T
    public var neighbours:[BFSNode]
    public var visited:Bool
    
    //Initialization
    public init(value:T, neighbours:[BFSNode], visited:Bool) {
        self.value = value
        self.neighbours = neighbours
        self.visited = visited
    }
    
    //Helper method for the example
    public func addNeighbour(node: BFSNode) {
        self.neighbours.append(node)
        node.neighbours.append(self)
    }
    
    public static func breadthFirstSearch(first:BFSNode) {
        //Init the queue
        var queue:[BFSNode] = []
        
        //Starting with the root
        queue.append(first)
        
        //Start visiting nodes in the queue
        while queue.isEmpty == false {
            if let node = queue.first {
                //Print the value of the current node and mark it as visited
                print(node.value)
                node.visited = true
                //Add negihbours not visited to the queue
                for neighbour in node.neighbours {
                    if neighbour.visited == false {
                        queue.append(neighbour)
                    }
                }
                //Remove the already processed node and keep working with the rest of the queue
                queue.removeFirst()
            }
        }
    }
    
}
