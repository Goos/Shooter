//
//  MultiplayerScene.swift
//  Shooter
//
//  Created by Robin Goos on 02/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

class MultiplayerScene: GameScene {
    var players: Set<Player> = [] {
        didSet {
            let added = players.subtract(oldValue)
            let removed = oldValue.subtract(players)
            added.forEach { self.addPlayerToScene($0) }
            removed.forEach { self.removePlayerFromScene($0) }
        }
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        setupWorld(view)
        players.forEach { self.addPlayerToScene($0) }
    }
    
    func setupWorld(view: SKView) {
    }
    
    func removePlayerFromScene(player: Player) {
    }
    
    func addPlayerToScene(player: Player) {
        player.controller.statusChangedHandler = { [weak self] status in
            if status == .Disconnected {
                self?.removePlayerFromScene(player)
            } else {
                self?.addPlayerToScene(player)
            }
        }
    }
    
    func updatePlayerPosition(player: Player, relativeFrameLength: NSTimeInterval) {
    }
    
    override func updateWithFrameLength(relativeFrameLength: NSTimeInterval) {
        for player in players {
            updatePlayerPosition(player, relativeFrameLength: relativeFrameLength)
        }
    }
}