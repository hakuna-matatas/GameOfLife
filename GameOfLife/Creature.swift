//
//  Creature.swift
//  GameOfLife
//
//  Created by Alan Gao on 6/24/16.
//  Copyright © 2016 Alan Gao. All rights reserved.
//

import SpriteKit

class Creature: SKSpriteNode {
    
    var neighbourCount = 0
    var isAlive: Bool = false {
        didSet {
            //If cell is alive, don't hide the cell and vice versa
            hidden = !isAlive
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        zPosition = 1
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
