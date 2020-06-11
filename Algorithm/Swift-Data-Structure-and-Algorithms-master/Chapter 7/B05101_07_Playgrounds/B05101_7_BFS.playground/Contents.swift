/*:
 # Chapter 7
 ## Graph Algorithms
 */

//: ## Demonstrate use of Breadth First Search.
//:
//: ### Find the file implementation in the Sources folder located within this project.

//: Create the nodes of the graph
let nodeA = BFSNode(value: "A", neighbours: [], visited: false)
let nodeB = BFSNode(value: "B", neighbours: [], visited: false)
let nodeC = BFSNode(value: "C", neighbours: [], visited: false)
let nodeD = BFSNode(value: "D", neighbours: [], visited: false)
let nodeE = BFSNode(value: "E", neighbours: [], visited: false)
let nodeF = BFSNode(value: "F", neighbours: [], visited: false)

//: Add connections between the nodes to form the graph
nodeA.addNeighbour(node: nodeB)
nodeC.addNeighbour(node: nodeB)
nodeD.addNeighbour(node: nodeB)
nodeE.addNeighbour(node: nodeB)
nodeF.addNeighbour(node: nodeD)

//: Perform the BFS
BFSNode.breadthFirstSearch(first: nodeA)

/*:
 
 The license for this document is available [here](License).
 */
