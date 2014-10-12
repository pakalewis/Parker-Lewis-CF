// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Stack {
    var stackArray = [String]()
    
    func push(pushThis: String) {
        stackArray.append(pushThis)
    }
    
    func pop() -> String? {
        if stackArray.isEmpty {
            return nil
        } else {
            var thisPopped = stackArray.last
            stackArray.removeLast()
            return thisPopped
        }
    }
    
    func popUntilThisIsPopped(popThis: String) {
        if stackArray.isEmpty {
            println("nothing to pop")
        } else {
            var isThisTheRightThingToPop = self.pop()
            while popThis != isThisTheRightThingToPop {
                isThisTheRightThingToPop = self.pop()
            }
        }
    }
}

var newStack = Stack()

newStack.push("1")
newStack.push("2")
newStack.push("3")
newStack.push("4")
newStack.push("5")
newStack.push("6")
newStack.push("7")
newStack.push("8")
newStack.push("9")

newStack.pop()
newStack.pop()
newStack.pop()

newStack.popUntilThisIsPopped("3")



class Queue {
    var queueArray = [String]()
    
    func enqueue(enqueueThis: String) {
        queueArray.append(enqueueThis)
    }
    
    func dequeue() -> String? {
        if queueArray.isEmpty {
            return nil
        } else {
            var thisDequeued = queueArray.first
            queueArray.removeAtIndex(0)
            return thisDequeued
        }
    }
    
    func dequeueUntilThisIsFirstInLine(dequeueThis: String) {
        if queueArray.isEmpty {
            println("nothing to dequeue")
        } else {
            var firstInLine = self.queueArray.first
            while firstInLine != dequeueThis {
                self.dequeue()
                firstInLine = self.queueArray.first
            }
        }
    }
}

var newQueue = Queue()

newQueue.enqueue("1")
newQueue.enqueue("2")
newQueue.enqueue("3")
newQueue.enqueue("4")
newQueue.enqueue("5")
newQueue.enqueue("6")
newQueue.enqueue("7")
newQueue.enqueue("8")
newQueue.enqueue("9")

newQueue.dequeue()
newQueue.dequeue()
println(newQueue.queueArray)

newQueue.dequeueUntilThisIsFirstInLine("7")

