//
//  TeamDeathmatchScene.swift
//  Shooter
//
//  Created by Robin Goos on 02/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class TeamDeathmatchScene : MatchScene {
    override func addPlayerToScene(player: Player) {
        let playerNode = SKLabelNode(text: "😾")
        let playerBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 33.0, height: 33.0), center: CGPoint(x: 33.0/2, y: 33.0/2))
        
        playerNode.physicsBody = playerBody
        playerNode.zPosition = 100
        playerNode.fontSize = 28.0
        playerNode.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        player.node = playerNode
        
        player.controller.buttonA.valueChangedHandler = { (val, pressed) in
            if pressed {
                let jumpImpulse = CGVector(dx: 0.0, dy: 50.0)
                player.node?.physicsBody?.applyImpulse(jumpImpulse)
            }
        }
        
        addChild(playerNode)
    }
    
    override func removePlayerFromScene(player: Player) {
        player.node?.removeFromParent()
    }
}