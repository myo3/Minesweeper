//
//  StartViewController.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, ViewControllerDelegate {
    
    var highScore: Int = 0
    var highScoreLabel: UILabel = UILabel()
    
    var gridDimensions: Int = 8
    var mines: Int = 10
    
    var customSC: UISegmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        
        //create UISegmented control
        let items = ["8 x 8", "10 x 10", "12 x 12"]
        customSC = UISegmentedControl(items: items)
        //customSC.selectedSegmentIndex = 0
        customSC.frame = CGRectMake(10, viewHeight * 1/4, viewWidth - 20, viewHeight*0.1)
        customSC.tintColor = UIColor.clearColor()
        customSC.addTarget(self, action: "selectGrid:", forControlEvents: .ValueChanged)
        customSC.setImage(UIImage(named: "8x8s"), forSegmentAtIndex: 0)
        customSC.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
        customSC.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
        self.view.addSubview(customSC)
        
        //create start game buton
        let startGameButton = UIButton()
        startGameButton.frame = CGRectMake(view.bounds.width/2 - 72, customSC.frame.maxY + 20, 145, 80)
        startGameButton.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1.0)
        startGameButton.setTitle("START", forState: .Normal)
        startGameButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        startGameButton.titleLabel?.font = UIFont(name: "DesignerBlock", size: 40)
        startGameButton.addTarget(self, action: "startGame", forControlEvents: .TouchUpInside)
        self.view.addSubview(startGameButton)
        
        //set up scoreboard
        let highScoreboardImage = UIImage(named: "High Scoreboard")
        let highScoreboardImageView = UIImageView(frame: CGRect(x: 0, y: -20, width: viewWidth, height: viewHeight/5))
        highScoreboardImageView.contentMode = .ScaleAspectFit
        highScoreboardImageView.image = highScoreboardImage
        self.view.addSubview(highScoreboardImageView)
        
        //set up score number
        highScoreLabel = UILabel(frame: CGRect(x: 175, y: -17, width: highScoreboardImageView.frame.width * 0.75, height: highScoreboardImageView.frame.height))
        highScoreLabel.textAlignment = NSTextAlignment.Left
        highScoreLabel.textColor = UIColor.blackColor()
        highScoreLabel.font = UIFont(name: "DesignerBlock", size: 30)
        highScoreLabel.text = "\(highScore)"
        self.view.addSubview(highScoreLabel)

    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectGrid(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0: //8x8
            sender.setImage(UIImage(named: "8x8s"), forSegmentAtIndex: 0)
            sender.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            sender.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
            gridDimensions = 8
            mines = 10
        case 1: //10x10
            sender.setImage(UIImage(named: "10x10s"), forSegmentAtIndex: 1)
            sender.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            sender.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
            gridDimensions = 10
            mines = 25
        case 2: //12x12
            sender.setImage(UIImage(named: "12x12s"), forSegmentAtIndex: 2)
            sender.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            sender.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            gridDimensions = 12
            mines = 50
        default:
            sender.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            sender.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            sender.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
        }
        
    }
    
    func startGame(){
        //create new instance of gameVC
        let gameViewController = ViewController()
        gameViewController.dimension = gridDimensions
        gameViewController.mines = mines
            //set up delegate for gameVC
        gameViewController.delegate = self
        
        self.presentViewController(gameViewController, animated: true, completion: nil)
    }
    
    func updateHighScore(controller: ViewController,score: Int){
        if score > highScore{
            highScore = score
            highScoreLabel.text = "\(highScore)"
        }
    }
    
    func myVCDidFinish(controller: ViewController){
        //update  level selection bar
        switch controller.dimension{
        case 8:
            customSC.setImage(UIImage(named: "8x8s"), forSegmentAtIndex: 0)
            customSC.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            customSC.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
            gridDimensions = 8
            mines = 10
        case 10:
            customSC.setImage(UIImage(named: "10x10s"), forSegmentAtIndex: 1)
            customSC.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            customSC.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
            gridDimensions = 10
            mines = 25
        case 12:
            customSC.setImage(UIImage(named: "12x12s"), forSegmentAtIndex: 2)
            customSC.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            customSC.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            gridDimensions = 12
            mines = 35
        default:
            customSC.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            customSC.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            customSC.setImage(UIImage(named: "12x12"), forSegmentAtIndex: 2)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
