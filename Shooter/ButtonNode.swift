//
//  ButtonNode.swift
//  Shooter
//
//  Created by Robin Goos on 03/02/16.
//  Copyright © 2016 Robin Goos. All rights reserved.
//

import SpriteKit

enum ButtonState {
    case Enabled
    case Highlighted
    case Disabled
}

class ButtonNode: SKSpriteNode {
    var activeTexture: SKTexture?
    var highlightedTexture: SKTexture? = nil
    var disabledTexture: SKTexture? = nil
    var titleNode: SKLabelNode
    
    var target: AnyObject?
    var selector: Selector?
    
    private var pressAction: SKAction?
    private var depressAction: SKAction?
    
    init(activeTexture: SKTexture?, target: AnyObject?, selector: Selector?) {
        self.activeTexture = activeTexture
        self.target = target
        self.selector = selector
        
        titleNode = SKLabelNode(text: nil)
        
        pressAction = SKAction.scaleTo(0.9, duration: 0.1)
        depressAction = SKAction.scaleTo(1.0, duration: 0.1)
        
        let size = activeTexture?.size() ?? CGSizeZero
        super.init(texture: activeTexture, color: UIColor.clearColor(), size: size)
        
        addChild(titleNode)
        titleNode.verticalAlignmentMode = .Center
        titleNode.horizontalAlignmentMode = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        titleNode.text = title
    }
    
    func setFontName(fontName: String) {
        titleNode.fontName = fontName
    }
    
    func press() {
        guard enabled else {
            return
        }
        
        var actions: [SKAction] = []
        if let texture = highlightedTexture {
            actions.append(SKAction.setTexture(texture))
        }
        if let action = pressAction {
            actions.append(action)
        }
        runAction(SKAction.group(actions))
    }
    
    func depress(completed: Bool) {
        guard enabled else {
            return
        }
        
        var actions: [SKAction] = []
        if let texture = activeTexture {
            actions.append(SKAction.setTexture(texture))
        }
        if let action = depressAction {
            actions.append(action)
        }
        runAction(SKAction.group(actions))
        
        if completed && target != nil && selector != nil {
            target!.performSelector(selector!, withObject: self)
        }
    }
    
    var enabled: Bool = true {
        didSet {
            if !enabled && disabledTexture != nil {
                texture = disabledTexture
            } else if enabled && activeTexture != nil {
                texture = activeTexture
            }
        }
    }
}