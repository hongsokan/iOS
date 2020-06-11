/*:
 # Chapter 7
 ## Graph Algorithms
 */

//: ## Demonstrate use of a graph.
//:
//: ### Find the file implementations in the Sources folder located within this project.

//: Create our Adjacency List Graph
var adjacencyList:AdjacencyListGraph<String> = AdjacencyListGraph<String>()

//: Add some vertices
let vertexA = adjacencyList.addVertex(data: "A")
let vertexB = adjacencyList.addVertex(data: "B")
let vertexC = adjacencyList.addVertex(data: "C")
let vertexD = adjacencyList.addVertex(data: "D")

//: Add some edges
let edgeAB = adjacencyList.addEdge(from: vertexA, to: vertexB)
let edgeBC = adjacencyList.addEdge(from: vertexB, to: vertexC)
let edgeCD = adjacencyList.addEdge(from: vertexC, to: vertexD)

//: Print all
print(adjacencyList)

/*:
 
 The license for this document is available [here](License).
 */
