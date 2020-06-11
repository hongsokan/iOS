//
//  BinaryTreeNode.swift
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

public class BinaryTreeNode<T:Comparable> {
    
    //Value and children vars
    public var value:T
    public var leftChild:BinaryTreeNode?
    public var rightChild:BinaryTreeNode?
    public weak var parent:BinaryTreeNode?
    
    //Initialization
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent:nil)
    }
    
    public init(value:T, left:BinaryTreeNode?, right:BinaryTreeNode?, parent:BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
    
    public func insertNodeFromRoot(value:T) {
        //To mantain the binary search tree property, we must ensure that we run the insertNode process from the root node
        if let _ = self.parent {
            // If parent exists, it is not the root node of the tree
            print("You can only add new nodes from the root node of the tree");
            return
        }
        self.addNode(value: value)
    }

    private func addNode(value:T) {
        if value < self.value {
            // Value is less than root value: We should insert it in the left subtree.
            // Insert it into the left subtree if it exists, if not, create a new node and put it as the left child.
            if let leftChild = leftChild {
                leftChild.addNode(value: value)
            }else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                leftChild = newNode
            }
        }else {
            // Value is greater than root value: We should insert it in the right subtree
            // Insert it into the right subtree if it exists, if not, create a new node and put it as the right child.
            if let rightChild = rightChild {
                rightChild.addNode(value: value)
            }else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }
    
    //In-order tree walk with recursion
    public class func traverseInOrder(node:BinaryTreeNode?) {
        
        //The recursive calls end when we reach a Nil leaf
        guard let node = node else {
            return
        }
        
        //Recursively call the method again with the leftChild, then print the value, then with the rigthChild
        BinaryTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.traverseInOrder(node: node.rightChild)
    }
    
    //Pre-order tree walk with recursion
    public class func traversePreOrder(node:BinaryTreeNode?) {
        
        //The recursive calls end when we reach a Nil leaf
        guard let node = node else {
            return
        }
        
        //Recursively call the method printing the node value and visiting the leftChild and then the rigthChild
        print(node.value)
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
    }

    //Post-order tree walk with recursion
    public class func traversePostOrder(node:BinaryTreeNode?) {
        
        //The recursive calls end when we reach a Nil leaf
        guard let node = node else {
            return
        }
        
        //Recursively call the method visiting the leftChild and then the rigthChild, ending with the value of the node itself
        BinaryTreeNode.traversePostOrder(node: node.leftChild)
        BinaryTreeNode.traversePostOrder(node: node.rightChild)
        print(node.value)
    }

    //Search
    public func search(value:T) -> BinaryTreeNode? {
        
        // If we find the value
        if value == self.value {
            return self
        }
        
        // If the value is less than the current node value -> recursive search in the left subtree. If is bigger, search in the right one.
        if value < self.value {
            guard let left = leftChild else {
                return nil
            }
            return left.search(value: value)
        }else {
            guard let right = rightChild else {
                return nil
            }
            return right.search(value: value)
        }
    }

    //Deletion
    public func delete() {
        if let left = leftChild {
            if let _ = rightChild {
                // The node has 2 Children: left and right -> Exchange with successor process
                self.exchangeWithSuccessor()
            }else {
                // The node has 1 child (left) -> Connect self.parent to self.child. We need to know if the node to remove was the left of the right child of the parent first
                self.connectParentTo(child: left)
            }
        }else if let right = rightChild {
            // The node has 1 child (right) -> Connect self.parent to self.child. We need to know if the node to remove was the left of the right child of the parent first
            self.connectParentTo(child: right)
        }else {
            self.connectParentTo(child: nil)
        }
        
        // Delete node references
        self.parent = nil
        self.leftChild = nil
        self.rightChild = nil
    }
    
    // Help us to exchange a node to be deleted for its successor
    private func exchangeWithSuccessor() {
        guard let right = self.rightChild , let left = self.leftChild else {
            return
        }
        let successor = right.minimum()
        successor.delete()
        
        successor.leftChild = left
        left.parent = successor
        
        if right !== successor {
            successor.rightChild = right
            right.parent = successor
        } else {
            successor.rightChild = nil
        }
        
        self.connectParentTo(child: successor)
    }
    
    private func connectParentTo(child:BinaryTreeNode?) {
        guard let parent = self.parent else {
            child?.parent = self.parent
            return
        }
        if parent.leftChild === self {
            parent.leftChild = child
            child?.parent = parent
        }else if parent.rightChild === self {
            parent.rightChild = child
            child?.parent = parent
        }
    }
    
    //MARK: Other methods
    
    //Minimum value of the tree
    public func minimumValue() -> T {
        if let left = leftChild {
            return left.minimumValue()
        }else {
            return value
        }
    }
    
    //Maximum value of the tree
    public func maximumValue() -> T {
        if let right = rightChild {
            return right.maximumValue()
        }else {
            return value
        }
    }
    
    //Minimum node of the tree
    public func minimum() -> BinaryTreeNode {
        if let left = leftChild {
            return left.minimum()
        }else {
            return self
        }
    }
    
    //Maximum node of the tree
    public func maximum() -> BinaryTreeNode {
        if let right = rightChild {
            return right.maximum()
        }else {
            return self
        }
    }
    
    //Height
    public func height() -> Int {
        if leftChild == nil && rightChild == nil {
            return 0
        }
        
        return 1 + max(leftChild?.height() ?? 0, rightChild?.height() ?? 0)
    }
    
    //Depth
    public func depth() -> Int {
        guard var node = parent else {
            return 0
        }
        
        var depth = 1
        while let parent = node.parent {
            depth = depth + 1
            node = parent
        }
        
        return depth
    }

}
