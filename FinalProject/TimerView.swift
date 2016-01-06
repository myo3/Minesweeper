//
//  TimerView.swift
//  FinalProject
//
//  Created by Monica Ong on 11/30/15.
//  Copyright © 2015 Monica Ong. All rights reserved.
//

import UIKit

class TimerView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var timer: NSTimer = NSTimer()
    var timeLabel: UILabel = UILabel()
    var time: Int = 0
    
    override init(frame: CGRect) {
        let timerFrame = frame
        super.init(frame: timerFrame)
        
        //set up timer backdrop
        let timerBackgroundImage = UIImage(named: "Timer Background")
        let timerBackgroundImageView = UIImageView(frame: CGRectMake(-402, timerFrame.height * 1.5 + 80, 100,80))
        //timerBackgroundImageView.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
        timerBackgroundImageView.contentMode = .ScaleAspectFit
        timerBackgroundImageView.image = timerBackgroundImage
        self.addSubview(timerBackgroundImageView)
        
        //set up actual timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countTime:", userInfo: nil, repeats: true)
        timeLabel = UILabel(frame: CGRectMake(-399, timerFrame.height * 1.5 + 85, 90,75))
        //timeLabel.backgroundColor = UIColor(red: 0.52, green: 0.52, blue: 0.53, alpha: 1.0)
        timeLabel.textAlignment = NSTextAlignment.Center
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.font = UIFont(name: "DesignerBlock", size: 35)
        timeLabel.text = "00:00"
        self.addSubview(timeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
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
        timer.invalidate()
    }

}
