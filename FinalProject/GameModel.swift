//
//  GameModel.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

protocol GameModelDelegate: class {
}

class GameModel: NSObject {
    var delegate: GameModelDelegate
    var mines: Int
    var tiles: [[TileButton]]!
    var rows: Int!
    var columns: Int!
    var count: Int = 0
    var finished: Bool = false
    
    init(delegate: GameModelDelegate, dimension: Int, mines: Int, tiles: [[TileButton]]) {
        self.delegate = delegate
        self.rows = dimension
        self.columns = dimension
        self.mines = mines
        self.tiles = tiles
        super.init()
        
        setUpMines()
    }
    
    func setUpMines(){
        //set up mines
        var numMines = mines
        while numMines > 0 {
            var x: Int!
            var y: Int!
            x = Int(arc4random_uniform(UInt32(rows)))
            y = Int(arc4random_uniform(UInt32(columns)))
            tiles[x][y].mine = true
            numMines -= 1
        }
        
        //find the num of mines next to each time
        for i in 0...rows - 1 {
            for j in 0...columns - 1 {
                let num = self.getNumOfMines(tiles[i][j])
                tiles[i][j].numOfNeighboringMines = num
            }
        }
        
    }
    
    func getNumOfMines(tile: TileButton) -> Int {
        var neighbors = 0
        let tileCheck: [[Int]] = [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]]
        
        for i in 0...7 {
            let x = tile.x + tileCheck[i][0]
            let y = tile.y + tileCheck[i][1]
            
            if x < 0 || x >= rows || y < 0 || y >= columns{
                continue
            }
            
            if tiles[x][y].mine {
                neighbors += 1
            } else{
                tile.adjacentNonMines.append(tiles[x][y])
            }
        }
        
        return neighbors
    }
        
    func incrementCount(){
        count += 1
        if count == rows * columns - mines{
            finished = false
        }
    }

}
