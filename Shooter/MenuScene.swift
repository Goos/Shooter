//
//  MenuScene.swift
//  Shooter
//
//  Created by Robin Goos on 05/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class MenuScene: MultiplayerScene {
    override func addPlayerToScene(player: Player) {
        super.addPlayerToScene(player)
        let node = CursorNode(index: player.controller.index)
        node.zPosition = 100
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        
        player.node = node
        
        addChild(node)
        
        var wasPressed = false
        player.controller.buttonA.valueChangedHandler = { (value, pressed) in
            guard pressed != wasPressed else {
                return
            }
            wasPressed = pressed
            
            if let node = player.node {
                let point = CGPoint(x: node.frame.minX, y: node.frame.maxY)
                self.playerClicked(player, point: point)
            }
        }
        
        player.controller.dpad.valueChangedHandler = { print($0, $1) }
    }
    
    override func removePlayerFromScene(player: Player) {
        super.removePlayerFromScene(player)
        player.node?.removeFromParent()
    }
    
    override func updatePlayerPosition(player: Player, relativeFrameLength: NSTimeInterval) {
        if let node = player.node {
            let stepSize = Float(relativeFrameLength * 10.0)
            let joystick = player.controller.layout == .Micro ? player.controller.dpad : player.controller.leftThumbstick
            let newX = node.position.x + CGFloat(stepSize * joystick.xAxis * 3)
            let newY = node.position.y + CGFloat(stepSize * joystick.yAxis * 3)
            let position = CGPoint(x: max(0.0, min(frame.maxX, newX)), y: max(0.0, min(frame.maxY, newY)))
            node.position = position
        }
    }
    
    func playerClicked(player: Player, point: CGPoint) {
        for node in nodesAtPoint(point) {
            if let button = node as? ButtonNode {
                if player.controller.buttonA.pressed {
                    button.press()
                } else {
                    button.depress(true)
                }
            }
        }
    }
}

class CursorNode: SKSpriteNode {
    convenience init(index: UInt16) {
        let name = "cursor_gauntlet_\(index)"
        self.init(imageNamed: name)
        size = CGSize(width: size.width * 2, height: size.height * 2)
        
        let body = SKPhysicsBody(texture: texture!, size: size)
        body.affectedByGravity = false
        body.allowsRotation = false
        physicsBody = body
    }
}