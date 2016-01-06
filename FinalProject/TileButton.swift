//
//  TileButton.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

class TileButton: UIButton {
    
    var mine: Bool = false
    var x: Int!
    var y: Int!
    
    var numOfNeighboringMines: Int = 0
    var revealed: Bool = false
    
    var adjacentNonMines: [TileButton] = [TileButton]()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.setImage(UIImage(named: "tile"), forState: UIControlState.Normal)
    }
    
    func revealSelf(){
        if mine{
            self.setImage(UIImage(named: "mine"), forState: UIControlState.Selected)
        } else{
            self.setImage(UIImage(named: "\(numOfNeighboringMines)"), forState: UIControlState.Normal)
        }
    }
}
