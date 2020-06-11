//
// AdjacencyList.swift
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

public struct VertexEdgesList<T:Equatable & Hashable> {
    // Each VertexEdgesList contains the vertex itself and its connected vertices stored in an array of edges
    public let vertex:Vertex<T>
    public var edges:[Edge<T>] = []
    
    public init(vertex: Vertex<T>) {
        self.vertex = vertex
    }
    
    public mutating func addEdge(edge: Edge<T>) {
        // Check if the edge exists
        if self.edges.count > 0 {
            let equalEdges = self.edges.filter() { existingEdge in
                return existingEdge == edge
            }
            
            if equalEdges.count > 0 {
                return
            }
        }
        self.edges.append(edge)
    }
}

public struct AdjacencyListGraph<T:Equatable & Hashable> {
    
    public var adjacencyLists:[VertexEdgesList<T>] = []
    
    public var vertices:[Vertex<T>] {
        get {
            var vertices = [Vertex<T>]()
            for list in adjacencyLists {
                vertices.append(list.vertex)
            }
            return vertices
        }
    }
    
    public var edges:[Edge<T>] {
        get {
            var edges = Set<Edge<T>>()
            for list in adjacencyLists {
                
                for edge in list.edges {
                    edges.insert(edge)
                }
            }
            return Array(edges)
        }
    }
    
    public init(){}
    
    public mutating func addVertex(data:T) -> Vertex<T> {
        // Check if the vertex exists
        for list in adjacencyLists {
            if list.vertex.data == data {
                return list.vertex
            }
        }
        
        // Create it, update the graph and return it
        let vertex:Vertex<T> = Vertex(data: data, index: adjacencyLists.count)
        let adjacencyList = VertexEdgesList(vertex: vertex)
        adjacencyLists.append(adjacencyList)
        return vertex
    }
    
    public mutating func addEdge(from:Vertex<T>, to:Vertex<T>) -> Edge<T> {
        let edge = Edge(from: from, to: to)
        let list = adjacencyLists[from.index]
        // Check if the edge already exists
        if list.edges.count > 0 {
            for existingEdge in list.edges {
                if existingEdge == edge {
                    return existingEdge
                }
            }
            adjacencyLists[from.index].edges.append(edge)
        }else {
            adjacencyLists[from.index].edges = [edge]
        }
        return edge
    }


}
