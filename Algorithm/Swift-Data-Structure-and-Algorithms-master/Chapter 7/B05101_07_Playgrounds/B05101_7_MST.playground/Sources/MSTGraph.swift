//
// MSTGraph.swift
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

public class MSTGraph<T:Hashable & Equatable> {
    public var nodes:[MSTNode<T>]
    
    public init(nodes:[MSTNode<T>]) {
        self.nodes = nodes
    }
    
    public static func minimumSpanningTree(startNode:MSTNode<T>, graph:MSTGraph<T>) {
        
        //We use an array to keep track of the visited nodes to process their edges an select the minimun one (which was not visited already)
        var visitedNodes:[MSTNode<T>] = []
        
        //Start by printing the initial node and add it to the visitedNodes array, to process its edges
        print(startNode.value)
        visitedNodes.append(startNode)
        startNode.visited = true
        
        //We loop until we have visited all the nodes of the graph
        while visitedNodes.count < graph.nodes.count {
            
            //First, we are going to extract all the edges where their "to" node is not visited yet (to avoid loops)
            var unvistedEdges:[MSTEdge<T>] = []
            _ = visitedNodes.map({ (node) -> () in
                let edges = node.edges.filter({ (edge) -> Bool in
                    edge.to.visited == false
                })
                unvistedEdges.append(contentsOf: edges)
            })
            
            //Now, from this array of edges, we are going to select the one with less weight. We print it and add its "to" node to the visitedNode array, to keep processing nodes in the next iteration of the while loop
            if let minimumUnvisitedEdge = unvistedEdges.sorted(by: { (edgeA, edgeB) -> Bool in
                edgeA.weight < edgeB.weight}).first {
                print("\(minimumUnvisitedEdge.from.value) <--------> \(minimumUnvisitedEdge.to.value)")
                minimumUnvisitedEdge.to.visited = true
                visitedNodes.append(minimumUnvisitedEdge.to)
            }
        }
    }

}
