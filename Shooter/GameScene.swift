//
//  GameScene.swift
//  Shooter
//
//  Created by Robin Goos on 04/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var lastUpdateTime: NSTimeInterval = 0.0
    static var optimalFrameLength: NSTimeInterval = 1.0/60.0
    
    override func update(currentTime: NSTimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        let frameLength = delta / GameScene.optimalFrameLength
        updateWithFrameLength(frameLength)
    }
    
    func updateWithFrameLength(relativeFrameLength: NSTimeInterval) {}
}
