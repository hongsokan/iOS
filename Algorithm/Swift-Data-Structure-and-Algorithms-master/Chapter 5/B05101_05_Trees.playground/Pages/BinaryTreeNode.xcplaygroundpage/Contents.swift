/*:
 # Chapter 5
 ## Seeing the Forest through the Tree
 */

//: ## Demonstrate use of the BinaryTree type.
//:
//: ### Find the BinaryTreeNode implementation in the Sources/BinaryTreeNode.swift file located within this project.


//: Create a Binary Tree
let rootNode = BinaryTreeNode(value: 10)
rootNode.insertNodeFromRoot(value: 20)
rootNode.insertNodeFromRoot(value: 5)
rootNode.insertNodeFromRoot(value: 21)
rootNode.insertNodeFromRoot(value: 8)
rootNode.insertNodeFromRoot(value: 4)

//: In order Traversal
print("In-Order")
BinaryTreeNode.traverseInOrder(node:rootNode)

//: Pre Order Traversal
print("Pre-Order")
BinaryTreeNode.traversePreOrder(node:rootNode)

//: Post Order Traversal
print("Post-Order")
BinaryTreeNode.traversePostOrder(node:rootNode)

//: Search calls
print("Search result nil: " + "\(rootNode.search(value: 1)?.value)")
print("Search result found: " + "\(rootNode.search(value: 4)?.value)")

//: Deletion
print("Deletion")
rootNode.leftChild?.delete()
rootNode.rightChild?.delete()
BinaryTreeNode.traverseInOrder(node:rootNode)

/*:
 
 The license for this document is available [here](License).
 */
