//
//  GameboardView.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit
protocol GameboardDelegate: class {
    func updateGame(tappedTile: TileButton)
}

class GameboardView: UIView {
    
    var rows = 8
    var columns = 8
    var mines = 10
    var tiles: [[TileButton]]!
    
    var delegate: GameboardDelegate?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, dimension: Int) {
        
        //set up gameboard
        rows = dimension
        columns = dimension
        let gameboardWidth = frame.width - 20.0
        let tileDimension = gameboardWidth / CGFloat(columns)
        let gameboardHeight = tileDimension * CGFloat(rows)
        let gameboardFrame = CGRect(x: 10, y: (frame.height - gameboardHeight)/2, width: gameboardWidth, height: gameboardHeight)
       
        super.init(frame: gameboardFrame)
        
        // set background of gameboard
        self.backgroundColor = UIColor.whiteColor()
        
        //set up tiles
        tiles = [[TileButton]](count: rows, repeatedValue: [TileButton](count: columns, repeatedValue: TileButton()))
        
        for i in 0...rows - 1 {
            for j in 0...columns - 1 {
                let tile: TileButton = TileButton(frame: CGRect(x: tileDimension * CGFloat(j), y: tileDimension * CGFloat(i), width: tileDimension, height: tileDimension))
                tile.addTarget(self, action: "tileTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                tile.x = i
                tile.y = j
                
                tiles[i][j] = tile
                self.addSubview(tile)
            }
        }
        
    }
    
    func tileTapped(sender: TileButton!) {
        if !sender.revealed{
            sender.revealed = true
            sender.revealSelf()
            
            //reveal adjacent non-mine tiles
            for tile in sender.adjacentNonMines{
                if !tile.revealed{
                    tile.revealed = true
                    tile.revealSelf()
                }
            }
            self.delegate?.updateGame(sender)
        }
    }
    
    func gameOver(tappedTile: TileButton){
        for x in 0...rows - 1 {
            for y in 0...columns - 1 {
                if tiles[x][y].mine {
                    tiles[x][y].selected = true
                    tiles[x][y].revealSelf()
                    tiles[x][y].backgroundColor = UIColor.grayColor()
                    tappedTile.backgroundColor = UIColor.redColor()
                }
                tiles[x][y].userInteractionEnabled = false
            }
        }
    }
    
    func youWin(tappedTile: TileButton){
        for x in 0...rows - 1 {
            for y in 0...columns - 1 {
                tiles[x][y].userInteractionEnabled = false
            }
        }
    }

}
