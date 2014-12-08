// Playground - noun: a place where people can play

import UIKit



class Node <T: Equatable> {
    var value: T
    var next: Node?

    init(_ value:T) {
        self.value = value
    }
}

class LinkedList<T: Equatable> {
    var head: Node<T>?
    
    func insertNodeAtEnd(value : T) {
        var newNode = Node(value)

        // case if list is empty
        if head == nil {
            head = newNode
            return
        }
        
        // otherwise, walk the list
        var currentNode = head
        while currentNode?.next != nil {
            currentNode = currentNode?.next
        }
        currentNode?.next = newNode
    }
    
    
    
    func removeNextNode(currentNode : Node<T>) {
        if currentNode.next?.next != nil {
            currentNode.next = currentNode.next?.next
        }
    }
    
    
    
    func printList() {
        var string = "list: "
        var curentNode = head
        while curentNode?.next != nil {
            string += ", \(curentNode!.value)"
            curentNode = curentNode!.next
        }
        string += ", \(curentNode!.value)"
        println(string)
    }
}


var list = LinkedList<Int>()

var node1 = Node(1)
var node2 = Node(2)
var node3 = Node(3)
var node4 = Node(4)
var node5 = Node(5)
var node6 = Node(6)
var node7 = Node(7)


list.insertNodeAtEnd(1)
list.insertNodeAtEnd(2)
list.insertNodeAtEnd(3)
list.insertNodeAtEnd(4)
list.insertNodeAtEnd(5)
list.insertNodeAtEnd(6)
list.insertNodeAtEnd(7)
list.removeNextNode(node3)
list.printList()
