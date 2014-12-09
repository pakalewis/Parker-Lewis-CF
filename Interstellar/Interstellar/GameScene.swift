//
//  GameScene.swift
//  Interstellar
//
//  Created by Bradley Johnson on 11/6/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var spaceShip = SKSpriteNode(imageNamed:"Spaceship")
    
    var currentTime = 0.0
    var previousTime = 0.0
    var deltaTime = 0.0
    var enemySpawnTime = 2.0
    var timeSinceLastEnemySpawn = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let starPath = NSBundle.mainBundle().pathForResource("SpaceParticle", ofType: "sks")
        let starField = NSKeyedUnarchiver.unarchiveObjectWithFile(starPath!) as SKEmitterNode
        
        starField.position = CGPoint(x: self.scene!.frame.size.width * 0.5, y: self.scene!.frame.size.height)
        self.addChild(starField)
        self.spaceShip.position = CGPoint(x: self.scene!.frame.size.width * 0.5, y: 100)
        spaceShip.size = CGSize(width: spaceShip.size.width * 0.3, height: spaceShip.size.height * 0.3)
        self.addChild(self.spaceShip)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
//            if location.x < self.scene!.size.width * 0.5 {
//                self.spaceShip.position = CGPoint(x: self.spaceShip.position.x - 10, y: self.spaceShip.position.y)
//            }
            
//
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
    
    func spawnEnemy() {
        var widthInt = UInt32(self.scene!.frame.width)
        var randomX = arc4random_uniform(widthInt)
        var mcconaugheyFeels = SKSpriteNode(imageNamed: "mcconaugheyfeels.jpg")
        mcconaugheyFeels.position = CGPoint(x: CGFloat(randomX), y: 800)
        mcconaugheyFeels.size = CGSize(width: mcconaugheyFeels.size.width * 0.3, height: mcconaugheyFeels.size.width * 0.4)
        self.addChild(mcconaugheyFeels)

        var moveAction = SKAction.moveTo(CGPoint(x: CGFloat(randomX), y: -200), duration: 2.0)
        mcconaugheyFeels.runAction(moveAction)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.currentTime = currentTime
        self.deltaTime = self.currentTime - self.previousTime
        self.previousTime = self.currentTime
        
       // println(self.deltaTime)
        self.timeSinceLastEnemySpawn = self.timeSinceLastEnemySpawn + self.deltaTime
        if self.timeSinceLastEnemySpawn > self.enemySpawnTime {
           // println("time for an enemy")
            self.timeSinceLastEnemySpawn = 0.0
            self.spawnEnemy()
        }
    }
}
