//
//  ScoreViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 3/19/15.
//  Copyright (c) 2015 AkihsiaSengoku. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    //セグエでもらうもの
    var scoreTime : Double = 0
    var ansCountText : (Int , String) = (0,"")
    
    
    var updateNum = 10
    var scoreArray : [Double] = []
    

    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabel() {
        
        
        var X = self.view.frame.size.width / 2
        var Y = self.view.frame.size.height / 45
        
        self.view.addSubview(makeButton("RESTART",X:X, Y: Y*38, s: "touchRestartButton:"))
        self.view.addSubview(makeButton("HOME",X:X, Y: Y*42, s: "touchHomeButton:"))

        
        var modTitle = ""
        switch app.gameMode {
        case 0:
            modTitle = "TimeAttac"
            scoreTime = Double(Int(scoreTime * 100.0)) / 100.0
            let timeText = String("\(scoreTime)")
            self.dataUpdate1()
        case 1:
            modTitle = "Perfect"
            scoreTime = Double(Int(scoreTime * 1)) / 1
            let timeText = String("\(scoreTime)")
            self.dataUpdate2()
        default :
            println("era-")
        }
        
        //タイトル
        self.view.addSubview(makeMyLabel(0, title:modTitle, myX: X, myY: Y*3))
        
        //現在スコア
        let label = makeMyLabel(0, title:String("\(scoreTime)") , myX: X, myY: Y * 7)
        label.font = UIFont.systemFontOfSize(CGFloat(40))
        self.view.addSubview(label)
        
        
        var flag = 0
        for i in 0...8 {
            let scoreText = String("\(scoreArray[i])")
            let text : String = (i+1).description+"位    "+scoreText
            var d = CGFloat(i*3+11)
            let label = makeMyLabel(flag, title:text, myX: X, myY: Y*d)
            if i == updateNum {
                label.textColor = UIColor.redColor()
            }
            self.view.addSubview(label)
        }
        
    }
    
    func touchRestartButton(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func touchHomeButton(sender: UIButton){
        performSegueWithIdentifier("next4",sender: nil)
    }
    
    
    func dataUpdate1 () {
        let defaults = NSUserDefaults.standardUserDefaults()
        scoreArray = defaults.objectForKey("g1Scores") as [Double]
        
        var flag = 0
        for i in 0...8 {
            if (scoreArray[i] == 0.00 || scoreArray[i] > scoreTime) && flag == 0 {
                scoreArray.insert(scoreTime, atIndex: i)
                updateNum = i
                flag = 1
            }
        }
        
        //データの書き込み
        defaults.setObject(scoreArray, forKey: "g1Scores")
        defaults.synchronize()
        
    }
    
    func dataUpdate2 () {
        let defaults = NSUserDefaults.standardUserDefaults()
        scoreArray = defaults.objectForKey("g2Scores") as [Double]
        
        var flag = 0
        for i in 0...8 {
            if (scoreArray[i] == 0.00 || scoreArray[i] < scoreTime) && flag == 0 {
                scoreArray.insert(Double(ansCountText.0), atIndex: i)
                updateNum = i
                flag = 1
            }
        }
        
        //データの書き込み
        defaults.setObject(scoreArray, forKey: "g2Scores")
        defaults.synchronize()
        
    }
    
    
    func makeMyLabel(num : Int, title: NSString, myX: CGFloat, myY: CGFloat) -> UILabel{
        
        let myLabel: UILabel = UILabel()
        myLabel.frame = CGRectMake(0,0,200,70)
        myLabel.layer.position = CGPoint(x: myX, y: myY)
        myLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        myLabel.text = title
        myLabel.layer.masksToBounds = true
        myLabel.textAlignment = NSTextAlignment.Center
        if num == 1 {
            myLabel.textColor = UIColor.redColor()
        }
        
        return myLabel
    }
    
    func makeButton (title : String , X : CGFloat , Y : CGFloat , s: Selector) -> UIButton {
        let makeButton = UIButton()
        // サイズを設定する.
        makeButton.frame = CGRectMake(0,0,140,40)
        // 背景色を設定する.
        makeButton.backgroundColor = UIColor.redColor()
        // 枠を丸くする.
        makeButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        makeButton.setTitle(title, forState: UIControlState.Normal)
        makeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        makeButton.setTitle(title, forState: UIControlState.Highlighted)
        makeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        //　テキストの大きさ
        makeButton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(20))
        // ボタンの位置を指定する.
        makeButton.layer.position = CGPoint(x: X, y:Y)
        // イベントを追加する.
        makeButton.addTarget(self, action: s, forControlEvents: .TouchUpInside)
        
        return makeButton
        
    }
    
    func xRate () -> CGFloat {
        var rate = Double(self.view.frame.width) / 375.0
        return CGFloat(rate)
    }
    
    func yRate () -> CGFloat {
        var rate = Double(self.view.frame.height) / 667.0
        return CGFloat(rate)
    }
    
    func sizeRate () -> CGFloat {
        return (xRate()+yRate())/2
    }

}
