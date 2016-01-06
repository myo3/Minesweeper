//
//  StartViewController.swift
//  FinalProject
//
//  Created by Monica Ong on 11/29/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, ViewControllerDelegate {
    
    var smallHighScore: Int = 3599
    var smallHighScoreLabel: UILabel = UILabel()
    
    var mediumHighScore: Int = 3599
    var mediumHighScoreLabel: UILabel = UILabel()
    
    var largeHighScore: Int = 3599
    var largeHighScoreLabel: UILabel = UILabel()
    
    var gridDimensions: Int = 8
    var mines: Int = 10
    
    var customSC: UISegmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        let scoreLabelWidth = (viewWidth - 20) / 3
        
        //create UISegmented control
        let items = ["8 x 8", "10 x 10", "12 x 12"]
        customSC = UISegmentedControl(items: items)
        //customSC.selectedSegmentIndex = 0
        customSC.frame = CGRect(x: 10, y: viewHeight/4, width: viewWidth - 20, height: viewHeight/10)
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
//        let highScoreboardImage = UIImage(named: "High Scoreboard")
//        let highScoreboardImageView = UIImageView(frame: CGRect(x: 0, y: -20, width: viewWidth, height: viewHeight/5))
//        highScoreboardImageView.contentMode = .ScaleAspectFit
//        highScoreboardImageView.image = highScoreboardImage
//        self.view.addSubview(highScoreboardImageView)
        
        //set up score number
        smallHighScoreLabel = UILabel(frame: CGRect(x: 10, y: customSC.bounds.maxY + 5, width: scoreLabelWidth, height: viewHeight/5))
        smallHighScoreLabel.textAlignment = NSTextAlignment.Center
        smallHighScoreLabel.textColor = UIColor.blackColor()
        smallHighScoreLabel.font = UIFont(name: "DesignerBlock", size: 30)
        setScore("small")
        self.view.addSubview(smallHighScoreLabel)
        
        mediumHighScoreLabel = UILabel(frame: CGRect(x: 10 + scoreLabelWidth, y: customSC.bounds.maxY + 5, width: scoreLabelWidth, height: viewHeight/5))
        mediumHighScoreLabel.textAlignment = NSTextAlignment.Center
        mediumHighScoreLabel.textColor = UIColor.blackColor()
        mediumHighScoreLabel.font = UIFont(name: "DesignerBlock", size: 30)
        setScore("medium")
        self.view.addSubview(mediumHighScoreLabel)
        
        largeHighScoreLabel = UILabel(frame: CGRect(x: 10 + scoreLabelWidth * 2, y: customSC.bounds.maxY + 5, width: scoreLabelWidth, height: viewHeight/5))
        largeHighScoreLabel.textAlignment = NSTextAlignment.Center
        largeHighScoreLabel.textColor = UIColor.blackColor()
        largeHighScoreLabel.font = UIFont(name: "DesignerBlock", size: 30)
        setScore("large")
        self.view.addSubview(largeHighScoreLabel)

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
            mines = 15
        case 2: //12x12
            sender.setImage(UIImage(named: "12x12s"), forSegmentAtIndex: 2)
            sender.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            sender.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            gridDimensions = 12
            mines = 25
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
    
    func updateHighScore(controller: ViewController, score: Int){
        switch controller.dimension {
            case 8:
                if score < smallHighScore {
                    smallHighScore = score
                }
                self.setScore("small")
            case 10:
                if score < mediumHighScore {
                    mediumHighScore = score
                }
                self.setScore("medium")
            case 12:
                if score < largeHighScore {
                    largeHighScore = score
                }
                self.setScore("large")
            default:
                break
        }
        
    }
    
    func setScore(size: String) {
        var minutes = ""
        var seconds = ""
        
        switch size {
        case "small":
            //set up minutes
            if smallHighScore/60<10{
                minutes = "0\(smallHighScore/60)"
            }else{
                minutes = "\(smallHighScore/60)"
            }
            
            //set up seconds
            if smallHighScore%60 < 10{
                seconds = "0\(smallHighScore%60)"
            } else{
                seconds = "\(smallHighScore%60)"
            }
            
            smallHighScoreLabel.text = "\(minutes):\(seconds)"
            
        case "medium":
            //set up minutes
            if mediumHighScore/60<10{
                minutes = "0\(mediumHighScore/60)"
            }else{
                minutes = "\(mediumHighScore/60)"
            }
            
            //set up seconds
            if mediumHighScore%60 < 10{
                seconds = "0\(mediumHighScore%60)"
            } else{
                seconds = "\(mediumHighScore%60)"
            }
            
            mediumHighScoreLabel.text = "\(minutes):\(seconds)"
        
        case "large":
            //set up minutes
            if largeHighScore/60<10{
                minutes = "0\(largeHighScore/60)"
            }else{
                minutes = "\(largeHighScore/60)"
            }
        
            //set up seconds
            if largeHighScore%60 < 10{
                seconds = "0\(largeHighScore%60)"
            } else{
                seconds = "\(largeHighScore%60)"
            }
        
            largeHighScoreLabel.text = "\(minutes):\(seconds)"
        
        default:
            break
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
            mines = 15
        case 12:
            customSC.setImage(UIImage(named: "12x12s"), forSegmentAtIndex: 2)
            customSC.setImage(UIImage(named: "8x8"), forSegmentAtIndex: 0)
            customSC.setImage(UIImage(named: "10x10"), forSegmentAtIndex: 1)
            gridDimensions = 12
            mines = 25
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
