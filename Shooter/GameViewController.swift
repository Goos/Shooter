//
//  GameViewController.swift
//  Shooter
//
//  Created by Robin Goos on 02/02/16.
//  Copyright (c) 2016 Robin Goos. All rights reserved.
//

import UIKit
import SpriteKit
import ControllerKit
import GameKit

class GameViewController: GCEventViewController, ControllerBrowserDelegate {
    var browser: ControllerBrowser?
    var currentScene: MultiplayerScene?
    var players: Set<Player> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = MainMenuScene()
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        scene.players = players
        
        skView.presentScene(scene)
        currentScene = scene
//        scene.gameStartedHandler = { scene in
//            let matchScene = SKScene(fileNamed: "TeamDeathmatchScene") as! TeamDeathmatchScene
//            matchScene.players = self.players
//            skView.presentScene(matchScene)
//        }
        
        browser = ControllerBrowser(name: "TestServer")
        browser?.delegate = self
        browser?.start()
    }
    
    func controllerBrowser(browser: ControllerKit.ControllerBrowser, controllerConnected controller: ControllerKit.Controller) {
        let player = Player(controller: controller)
        self.players.insert(player)
        self.currentScene?.players.insert(player)
    }
    
    func controllerBrowser(browser: ControllerKit.ControllerBrowser, controllerDisconnected controller: ControllerKit.Controller) {
        if let player = self.players.filter({ $0.controller === controller }).first {
            self.currentScene?.players.remove(player)
            self.players.remove(player)
        }
    }
    
    func controllerBrowser(browser: ControllerKit.ControllerBrowser, encounteredError error: NSError) {
        print(error)
    }
}
