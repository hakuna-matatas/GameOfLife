//
//  GameScene.swift
//  GameOfLife
//
//  Created by Alan Gao on 6/24/16.
//  Copyright (c) 2016 Alan Gao. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var gridNode: Grid!
    
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        gridNode = self.childNodeWithName("gridNode") as! Grid
        
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        pauseButton = self.childNodeWithName("pauseButton") as! MSButtonNode
        stepButton = self.childNodeWithName("stepButton") as! MSButtonNode
        
        populationLabel = self.childNodeWithName("populationLabel") as! SKLabelNode
        generationLabel = self.childNodeWithName("generationLabel") as! SKLabelNode
        
        playButton.selectedHandler = {
            self.paused = false
        }

        stepButton.selectedHandler = {
            //self.stepSimulation()
            
            //Code to change stepButton -> clearButton
            self.gridNode.clearAll()
            self.populationLabel.text = String(self.gridNode.population)
            self.generationLabel.text = String(self.gridNode.generation)
        }
        
        pauseButton.selectedHandler = {
            self.paused = true
        }
        
        /* Inifinite simulation as SKActions */
        let delay = SKAction.waitForDuration(0.5)
        /* callMethod is a SKAction that, whenever called, will call method stepSimulation() on the GameScene */
        let callMethod = SKAction.performSelector(#selector(GameScene.stepSimulation), onTarget: self)
        let stepSequence = SKAction.sequence([delay, callMethod])
        let simulation = SKAction.repeatActionForever(stepSequence)
        self.runAction(simulation)
        
        /* Default simulation to pause state */
        self.paused = true
    }
    
    func stepSimulation() {
        gridNode.evolve()
        
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
}
