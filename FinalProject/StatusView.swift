//
//  StatusView.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

class StatusView: UIView {

    var score: Int = 0
    var label: UILabel?
    var statusFrame: CGRect?
    
    override init(frame: CGRect) {
        statusFrame = frame
        super.init(frame: statusFrame!)
        
        //set up scoreboard
        let scoreboardImage = UIImage(named: "Scoreboard")
        //x: 0, y: -40
        let scoreboardImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: statusFrame!.width, height: statusFrame!.height))
        scoreboardImageView.contentMode = .ScaleAspectFit
        scoreboardImageView.image = scoreboardImage
        self.addSubview(scoreboardImageView)
        
        //set up score number
        //x: 100, y: -37
        label = UILabel(frame: CGRect(x: 0, y: 0, width: statusFrame!.width * 0.75, height: statusFrame!.height))
        label?.textAlignment = NSTextAlignment.Left
        label?.textColor = UIColor.blackColor()
        label?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        label?.text = "\(score)"
        self.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func updateScore(tappedTile: TileButton)  {
        score += tappedTile.numOfNeighboringMines
        label?.text = "\(score)"
    }
    
    func updateScoreWithTime(time: Int){
        score += time
        label?.text = "\(score)"
    }
    
    func gameStatus(win: Bool){
        var nameImage = ""
        if win{
            nameImage = "Win"
        } else{
            nameImage = "Lost"
        }
        
        let gameStatusImage = UIImage(named: nameImage)
        let gameStatusImageView = UIImageView(frame: CGRect(x: 0, y: 35, width: statusFrame!.width, height: statusFrame!.height))
        gameStatusImageView.contentMode = .ScaleAspectFit
        gameStatusImageView.image = gameStatusImage
        gameStatusImageView.alpha = 0
        self.addSubview(gameStatusImageView)
        UIView.animateWithDuration(2.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations:{gameStatusImageView.alpha = 1.0}, completion: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

}
