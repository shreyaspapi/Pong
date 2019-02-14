//
//  GameScene.swift
//  Pong
//
//  Created by Shreyas on 14/02/19.
//  Copyright © 2019 Shreyas. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var mainScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    var score = [Int]() {
        didSet{
            mainScore.text = "\(score[0])"
            enemyScore.text = "\(score[1])"
        }
    }
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -50))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        border.affectedByGravity = false
        
        self.physicsBody = border
        
    }
    
    func startGame(){
        score = [0, 0]
    }
    
    func addScore(_ playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 50))
        } else if playerWhoWon == enemy {
            score [1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -50))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= main.position.y - 50 {
            addScore(enemy)
        } else if ball.position.y >= enemy.position.y + 70 {
            addScore(main)
        }
    }
}
