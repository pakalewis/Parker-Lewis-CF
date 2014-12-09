// Playground - noun: a place where people can play

import UIKit


class HashTable {
    var size : Int
    var hashArray = [HashBucket]()
    var count = 0
    
    init(size : Int) {
        self.size = size
        
        for i in 0..<size {
            var bucket = HashBucket()
            self.hashArray.append(bucket)
        }
    }
    
    func hash(key : String) -> Int {
        
        var total = 0
        for character in key.unicodeScalars {
            var asc = Int(character.value)
            total += asc
        }
        return total % self.size
    }
    
    func setObject(objectToStore : AnyObject, forKey key : String) {
        var index = self.hash(key)
        
        var bucket = HashBucket()
        bucket.key = key
        bucket.value = objectToStore
        bucket.next = self.hashArray[index]
        self.hashArray[index] = bucket
        self.count++
    }
    
    func removeObjectForKey(key : String) {
        var index = self.hash(key)
        var previousBucket : HashBucket?
        var bucket : HashBucket? = self.hashArray[index]
        
        while bucket != nil {
            
            if bucket!.key == key {
                var nextBucket = bucket?.next
                //self.hashArray[index] ?? bucket?.next!
                self.hashArray[index] = bucket!.next!
                bucket = self.hashArray[index].next
            } else {
                previousBucket!.next = bucket?.next
            }
            self.count--
            return
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
 
}

class HashBucket {
    
    var next : HashBucket?
    var value : AnyObject?
    var key : String?
}
