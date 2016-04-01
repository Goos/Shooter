//
//  Player.swift
//  Shooter
//
//  Created by Robin Goos on 02/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit
import ControllerKit

final class Player: Hashable {
    let controller: Controller
    var node: SKNode? = nil
    
    init(controller: Controller) {
        self.controller = controller
    }
    
    var hashValue: Int {
        return controller.hashValue
    }
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.hashValue == rhs.hashValue
}