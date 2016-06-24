//
//  Grid.swift
//  GameOfLife
//
//  Created by Alan Gao on 6/24/16.
//  Copyright © 2016 Alan Gao. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    /* Grid Array Dimensions */
    let rows = 8
    let columns = 10
    
    /* Individual cell dimensions, calculated in setup */
    var cellWidth = 0
    var cellHeight = 0
    
    /* Information for the labels */
    var population = 0
    var generation = 0
    
    /* Contains contents of grid */
    var gridArray = [[Creature]]()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //There will only be one touch; multitouch disable by default
        for touch in touches {
            //Grab position of touch relative to Grid
            let location = touch.locationInNode(self)
            
            let row = Int(location.y)/cellHeight
            let col = Int(location.x)/cellWidth
            
            let creature = gridArray[row][col]
            creature.isAlive = !creature.isAlive
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userInteractionEnabled = true
        
        cellWidth = Int(size.width)/columns
        cellHeight = Int(size.height)/rows
        
        populateGrid()
    }
    
    /* Populate the entire grid with creatures */
    func populateGrid() {
        for i in 0..<rows {
            //Adding an empty row to the array
            gridArray.append([])

            for j in 0..<columns {
                addCreatureAtGrid(i, col: j)
            }
        }
    }
    
    /* Add a creature at a specified point */
    func addCreatureAtGrid(row: Int, col: Int) {
        let newCreature = Creature()
        
        let creaturePosition = CGPoint(x: (cellWidth * col), y: (cellHeight * row))
        newCreature.position = creaturePosition
        newCreature.isAlive = false
        gridArray[row].append(newCreature)  //appending creature to empty array
        
        addChild(newCreature)
    }
    
    /* Counts the number of neighbours for every cell */
    func countNeighboursAllCells() {
        for i in 0..<rows {
            for j in 0..<columns {
                gridArray[i][j].neighbourCount = countNeighbours(i, col: j)
            }
        }

    }
    
    /* Counts the number of neighbours for a single cell */
    func countNeighbours(row: Int, col: Int) -> Int {
        var neighbours = 0
        
        for i in (col-1)...(col+1) {
            if(i < 0 || i >= columns) { continue } //continue skips current iteration of loop but doesn't
                                                  //break out of the loop
            for j in (row-1)...(row+1) {
                if(j < 0 || j >= rows) { continue } //i and j must be in bounds
                if(i == col && j == row) { continue } //current creature can't be neighbor to itself

                if(gridArray[j][i].isAlive == true) {
                    neighbours += 1
                }
            }
        }
        return neighbours
    }
    
    /* Changes the status for each cell to dead or alive */
    func updateCreatures() {
        population = 0
        
        for i in 0 ..< rows {
            for j in 0 ..< columns {
                let currCreature = gridArray[i][j]
                let nNeighbours = currCreature.neighbourCount
                
                if(nNeighbours > 3 || nNeighbours < 2) {
                    currCreature.isAlive = false
                }
                else if(nNeighbours == 3) {
                    currCreature.isAlive = true
                }
                
                if(currCreature.isAlive == true) { population += 1 }
            }
        }
    }
    
    /* Updates the grid */
    func evolve() {
        countNeighboursAllCells()
        updateCreatures()
        generation += 1
    }
    
    func clearAll() {
        for i in 0 ..< rows {
            for j in 0 ..< columns {
                gridArray[i][j].isAlive = false
            }
        }
        
        generation = 0
        population = 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
