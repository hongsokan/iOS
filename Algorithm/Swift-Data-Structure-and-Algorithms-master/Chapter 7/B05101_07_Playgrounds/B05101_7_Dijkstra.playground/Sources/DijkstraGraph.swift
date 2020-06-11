//
// DijkstraGraph.swift
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

public class DijkstraGraph<T:Hashable & Equatable> {
    public var nodes:[DijkstraNode<T>]
    
    public init(nodes:[DijkstraNode<T>]) {
        self.nodes = nodes
    }
    
    public static func dijkstraPath(startNode:DijkstraNode<T>, graph:DijkstraGraph<T>, finishNode:DijkstraNode<T>) {
        //Createa set to store all the nodes as unvisited
        var unvisitedNodes = Set<DijkstraNode<T>>(graph.nodes)
        
        //Mark it as visited and put its temporary distance to 0
        startNode.distance = 0
        
        //Assign the current node
        var currentNode:DijkstraNode<T> = startNode
        
        //Loop until we visit the finish node
        while (finishNode.visited == false) {
            //For each unvisited neighbour, calculate the distance from the current node
            for edge in currentNode.edges.filter({ (edge) -> Bool in
                return edge.to.visited == false
            }) {
                //Calcuate the temporary distance from the current node to this neighbour
                let temporaryDistance = currentNode.distance + Int(edge.weight)
                
                //If it is less than the current distance of the neighbour, we update it
                if edge.to.distance > temporaryDistance {
                    edge.to.distance = temporaryDistance
                    edge.to.previous = currentNode
                }
            }
            
            //Mark the node as visited
            currentNode.visited = true
            
            //Remove the current node from the set
            unvisitedNodes.remove(currentNode)
            
            if let newCurrent = unvisitedNodes.sorted(by: { (nodeA, nodeB) -> Bool in
                nodeA.distance  < nodeB.distance
            }).first {
                currentNode = newCurrent
            }else {
                break
            }
        }
        DijkstraGraph.printShortestPath(node: finishNode)
    }
    
    public static func printShortestPath(node:DijkstraNode<T>) {
        if let previous = node.previous {
            DijkstraGraph.printShortestPath(node: previous)
        }else {
            print("Shortest path:")
        }
        print("->\(node.value)", terminator:"")
    }
}
