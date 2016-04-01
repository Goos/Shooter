//
//  MatchScene.swift
//  Shooter
//
//  Created by Robin Goos on 02/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class MatchScene: MultiplayerScene {
    override func setupWorld(view: SKView) {
        let borderBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    }
    
    override func updatePlayerPosition(player: Player, relativeFrameLength: NSTimeInterval) {
        if let node = player.node, body = node.physicsBody {
            var velocity = body.velocity
            if player.controller.layout == .Micro {
                velocity.dx = CGFloat(player.controller.dpad.xAxis * 500)
            } else {
                velocity.dx = CGFloat(player.controller.leftThumbstick.xAxis * 750)
            }
            body.velocity = velocity
        }
    }
}