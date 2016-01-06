//
//  ViewController.swift
//  FinalProject
//
//  Created by Monica Ong on 11/27/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate{
    func myVCDidFinish(controller: ViewController,score: Int)
}

class ViewController: UIViewController, GameModelDelegate, GameboardDelegate {
    
    var gameboard:GameboardView?
    var status:StatusView?
    var model:GameModel?
    var timer: TimerView?
    
    var dimension: Int = 8
    var mines: Int = 10
    
//    var timer: NSTimer = NSTimer()
//    var timeLabel: UILabel = UILabel()
//    var time: Int = 0
    
    var delegate: ViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //create gameboard
        gameboard = GameboardView(frame: view.bounds, dimension: dimension)
        gameboard?.delegate = self
        self.view.addSubview(gameboard!)
        
        //create game model
        model = GameModel(delegate: self, dimension: dimension, mines: mines, tiles: (gameboard?.tiles!)!)
        
        //create New Game button
        let newGameButton = UIButton()
        newGameButton.frame = CGRectMake(view.bounds.width * 2/3 + 55, (gameboard?.bounds.height)! * 1.5, 75,75)
        newGameButton.setBackgroundImage(UIImage(named: "New Game"), forState: UIControlState.Normal)
        newGameButton.addTarget(self, action: "newGame:", forControlEvents: .TouchUpInside)
        self.view.addSubview(newGameButton)
        
        //create scoreboard
        status = StatusView(frame: CGRectMake(0, 20, view.bounds.width, view.bounds.height/5))
        status?.score = 0
        //status?.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
        self.view.addSubview(status!)
        
        //create timer
        timer = TimerView(frame: CGRectMake(view.bounds.width, (gameboard?.bounds.height)!, 80, 80))
        self.view.addSubview(timer!)
//            //set up timer backdrop
//        let timerBackgroundImage = UIImage(named: "Timer Background")
//        let timerBackgroundImageView = UIImageView(frame: CGRectMake(view.bounds.width/12 - 25, (gameboard?.bounds.height)! * 1.5, 80,80))
//        timerBackgroundImageView.contentMode = .ScaleAspectFit
//        timerBackgroundImageView.image = timerBackgroundImage
//        self.view.addSubview(timerBackgroundImageView)
//            //set up actual timer
//        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp:", userInfo: nil, repeats: true)
//        timeLabel = UILabel(frame: CGRectMake(view.bounds.width/12 - 23, (gameboard?.bounds.height)! * 1.5 + 5, 75,75))
//        //timeLabel.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
//        timeLabel.textAlignment = NSTextAlignment.Center
//        timeLabel.textColor = UIColor.blackColor()
//        timeLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
//        timeLabel.text = "0:00"
//        self.view.addSubview(timeLabel)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func newGame(sender: UIButton!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGame(tappedTile: TileButton) {
        if tappedTile.mine{
            gameboard?.gameOver(tappedTile)
            status?.gameStatus(false)
            timer?.invalidate()
            status?.updateScoreWithTime((timer?.time)!)
            delegate?.myVCDidFinish(self, score: (status?.score)!)
        } else{
            status?.updateScore(tappedTile)
            model?.incrementCount()
            if model!.finished {
                gameboard?.youWin(tappedTile)
                status?.gameStatus(true)
                timer?.invalidate()
                status?.updateScoreWithTime((timer?.time)!)
                delegate?.myVCDidFinish(self, score: (status?.score)!)
            }
        }
    }
    
//    func countUp(sender: NSTimer!){
//        time += 1
//        if time%60 < 10{
//            timeLabel.text = "\(time/60):0\(time%60)"
//        } else{
//            timeLabel.text = "\(time/60):\(time%60)"
//        }
//    }
}

