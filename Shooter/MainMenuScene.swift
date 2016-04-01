//
//  MainMenuScene.swift
//  Shooter
//
//  Created by Robin Goos on 05/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class MainMenuScene: MenuScene {
    override func setupWorld(view: SKView) {
        super.setupWorld(view)
        
        let startButton = ButtonNode(activeTexture: nil, target: self, selector: "didSelectStartButton:")
        startButton.setTitle("Start game")
        addChild(startButton)
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    func didSelectStartButton(button: ButtonNode) {
        
    }
}