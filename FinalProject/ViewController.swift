//
//  ViewController.swift
//  FinalProject
//
//  Created by Monica Ong on 11/27/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate{
    func updateHighScore(controller: ViewController,score: Int)
    func myVCDidFinish(controller: ViewController)
}

class ViewController: UIViewController, GameModelDelegate, GameboardDelegate {
    
    var gameboard:GameboardView?
    var model:GameModel?
    var timer: NSTimer?
    
    var dimension: Int = 8
    
    var mines: Int = 10
    var minesNumLabel: UILabel = UILabel()
    var flagged: Bool = false
    var flagButton: UIButton = UIButton()
    
    var faceButton: UIButton = UIButton()
    var timeLabel: UILabel = UILabel()
    var time: Int = 0
    
    var score: Int = 0
    
    var delegate: ViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //create gameboard
        gameboard = GameboardView(frame: view.bounds, dimension: dimension)
        gameboard?.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
        gameboard?.delegate = self
        self.view.addSubview(gameboard!)
        
        //create game model
        model = GameModel(delegate: self, dimension: dimension, mines: mines, tiles: (gameboard?.tiles!)!)
        
        //create Status Board
        let statusBoard = UIImageView(frame: CGRectMake(10, 20, view.bounds.width - 20, (gameboard?.frame.minY)! - 30))
        statusBoard.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        self.view.addSubview(statusBoard)
        
        //create smiley face
        faceButton.frame = CGRectMake(statusBoard.frame.minX + statusBoard.bounds.width/2 - 30, statusBoard.frame.minY + statusBoard.bounds.height/2 - 30, 60, 60)
        faceButton.setImage(UIImage(named:"Neutral"), forState: UIControlState.Normal)
        faceButton.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
        //face.addTarget(self, action: "reset:", forControlEvents: .TouchUpInside)
        self.view.addSubview(faceButton)
        
        //label mines
        let minesNameLabel = UILabel(frame: CGRectMake(statusBoard.frame.minX + statusBoard.bounds.width/4 - 50, statusBoard.frame.maxY - 50, 75, 50))
        minesNameLabel.textAlignment = NSTextAlignment.Center
        minesNameLabel.textColor = UIColor.blackColor()
        //minesNameLabel.backgroundColor = UIColor.redColor()
        minesNameLabel.font = UIFont(name: "DesignerBlock", size: 30)
        minesNameLabel.text = "MINES"
        self.view.addSubview(minesNameLabel)
        
        //display mines left to mark
        minesNumLabel = UILabel(frame: CGRectMake(minesNameLabel.frame.minX + minesNameLabel.bounds.width/2 - 40, minesNameLabel.frame.minY - 60, 80,70))
        minesNumLabel.textAlignment = NSTextAlignment.Center
        minesNumLabel.textColor = UIColor.blackColor()
//        minesNumLabel.backgroundColor = UIColor.redColor()
        minesNumLabel.font = UIFont(name: "DesignerBlock", size: 60)
        minesNumLabel.text = "\(mines)"
        self.view.addSubview(minesNumLabel)
        
        //label timer
        let timerLabel = UILabel(frame: CGRectMake(statusBoard.bounds.width - statusBoard.bounds.width/4 - 15, statusBoard.frame.maxY - 50, 75, 50))
        timerLabel.textAlignment = NSTextAlignment.Center
        timerLabel.textColor = UIColor.blackColor()
//        timerLabel.backgroundColor = UIColor.redColor()
        timerLabel.font = UIFont(name: "DesignerBlock", size: 30)
        timerLabel.text = "TIMER"
        self.view.addSubview(timerLabel)
        
        //create & display timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countTime:", userInfo: nil, repeats: true)
        timeLabel = UILabel(frame: CGRectMake(timerLabel.frame.minX + timerLabel.bounds.width/2 - 80, timerLabel.frame.minY - 60, 160,70))
        timeLabel.textAlignment = NSTextAlignment.Center
        timeLabel.textColor = UIColor.blackColor()
//        timeLabel.backgroundColor = UIColor.redColor()
        timeLabel.font = UIFont(name: "DesignerBlock", size: 60)
        timeLabel.text = "00:00"
        self.view.addSubview(timeLabel)
        
        let buttonWidth = ((gameboard?.bounds.width)! - 30)/4
        //create quit button
        let quitButton = UIButton()
        quitButton.frame = CGRectMake((gameboard?.frame.maxX)! - buttonWidth, (gameboard?.frame.maxY)! + 10, buttonWidth, 70)
        quitButton.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        quitButton.setTitle("QUIT", forState: .Normal)
        quitButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        quitButton.titleLabel?.font = UIFont(name: "DesignerBlock", size: 40)
        quitButton.addTarget(self, action: "quit:", forControlEvents: .TouchUpInside)
        self.view.addSubview(quitButton)
        
        //create new game button
        let newGameButton = UIButton()
        newGameButton.frame = CGRectMake(quitButton.frame.minX - 10 - buttonWidth, quitButton.frame.minY, buttonWidth, 70)
        newGameButton.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        newGameButton.titleLabel?.textAlignment = NSTextAlignment.Center
        newGameButton.titleLabel?.font = UIFont(name: "DesignerBlock", size: 40)
        newGameButton.setTitle("NEW", forState: .Normal)
        newGameButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //newGameButton.addTarget(self, action: "newGame", forControlEvents: .TouchUpInside)
        self.view.addSubview(newGameButton)
        
        //create flag button
        flagButton = UIButton()
        flagButton.frame = CGRectMake(newGameButton.frame.minX - 10 - buttonWidth, newGameButton.frame.minY, buttonWidth, 70)
        flagButton.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        flagButton.setImage(UIImage(named: "flag on"), forState: UIControlState.Normal)
        flagButton.addTarget(self, action: "flagButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(flagButton)
        
        //create pause button
        let pauseButton = UIButton()
        pauseButton.frame = CGRectMake(flagButton.frame.minX - 10 - buttonWidth, flagButton.frame.minY, buttonWidth, 70)
        pauseButton.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        pauseButton.setImage(UIImage(named: "flag on"), forState: UIControlState.Normal)
        //pauseButton.addTarget(self, action: "pauseTimer:", forControlEvents: .TouchUpInside)
        self.view.addSubview(pauseButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Game methods
    func quit(sender: UIButton!) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.myVCDidFinish(self)
    }
    
    func updateGame(tappedTile: TileButton) {
            if tappedTile.mine{
                gameboard?.gameOver(tappedTile)
                changeFace(false)
                invalidate()
                updateScoreWithTime(time)
                
            } else{
                updateScore(tappedTile)
                model?.incrementCount()
                if model!.finished {
                    gameboard?.youWin(tappedTile)
                    changeFace(true)
                    invalidate()
                    updateScoreWithTime(time)
                    delegate?.updateHighScore(self, score: score)
                }
            }
    }
    
    func updateMines(tappedTile: TileButton){
        if(tappedTile.flagged){
            mines -= 1
        } else{
            mines += 1
        }
        minesNumLabel.text = "\(mines)"
    }
    //Scoreboard methods
    func updateScore(tappedTile: TileButton)  {
        score += tappedTile.numOfNeighboringMines
    }
    
    func updateScoreWithTime(time: Int){
        score += time
    }
    
    func changeFace(win: Bool){
        var nameImage = ""
        if win{
            nameImage = "Win"
        } else{
            nameImage = "Lost"
        }
        
        faceButton.setImage(UIImage(named: nameImage), forState: UIControlState.Normal)
    }
    
    //timer methods
    func countTime(sender: NSTimer!){
        time += 1
        var minutes = ""
        var seconds = ""
        
        //set up minutes
        if time/60<10{
            minutes = "0\(time/60)"
        }else{
            minutes = "\(time/60)"
        }
        
        //set up seconds
        if time%60 < 10{
            seconds = "0\(time%60)"
        } else{
            seconds = "\(time%60)"
        }
        
        timeLabel.text = "\(minutes):\(seconds)"
    }
    
    func invalidate(){
        timer!.invalidate()
    }
    
    //flag button methods
    func flagButtonPressed(sender: UIButton){
        var name = ""
        if(flagged){
            name = "flag on"
        } else{
            name = "flag off"
        }
        flagged = !flagged
        flagButton.setImage(UIImage(named: name), forState: UIControlState.Normal)
        
    }

}

