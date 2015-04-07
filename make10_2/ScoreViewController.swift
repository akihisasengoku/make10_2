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
    var scoreArray : [String] = []
    

    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setLabel()
        
        let homeButton = makeButton1(1, title: "", myX: self.view.frame.size.width/12, myY: self.view.frame.size.width/8, s: "home:")
        var buttonImage = UIImage(named: "HomeBotton.png") as UIImage?
        homeButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        self.view.addSubview(homeButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabel() {
        
        
        var X = self.view.frame.size.width / 2
        var Y = self.view.frame.size.height / 45
        
        self.view.addSubview(makeButton("RESTART",X:X, Y: Y*40, s: "touchRestartButton:" , size :20))
        //self.view.addSubview(makeButton("HOME",X:X, Y: Y*42, s: "touchHomeButton:" , size: 20))

        
        var modTitle = ""
        var timeText = ""
        switch app.gameMode {
        case 0:
            //modTitle = "TimeAttac"
            timeText = String(format: "%0.2f", Float(scoreTime))
            self.dataUpdate1()
        case 1:
            //modTitle = "Perfect"
            timeText = ansCountText.0.description
            self.dataUpdate2()
        default :
            println("era-")
        }
        
        //タイトル
        self.view.addSubview(makeMyLabel(0, title:modTitle, myX: X, myY: Y*3 ,size:35))
        //現在スコア
        var scoreLabel = makeMyLabel(0, title:timeText , myX: X, myY: Y * 7 , size : 55)
        scoreLabel.textColor = UIColor.redColor()
        self.view.addSubview(scoreLabel)
        
        
        var flag = 0
        for i in 0...8 {
            let scoreText = scoreArray[i]
            let text : String = (i+1).description+"位    "+scoreText
            var d = CGFloat(i*3+11)
            let label = makeMyLabel(flag, title:text, myX: X, myY: Y*d ,size : 20)
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
        var scoreArray1 : [Double] = defaults.objectForKey("g1Scores") as [Double]
        
        var flag = 0
        for i in 0...8 {
            if (scoreArray1[i] == 0.00 || scoreArray1[i] > scoreTime) && flag == 0 {
                scoreArray1.insert(scoreTime, atIndex: i)
                updateNum = i
                flag = 1
            }
            scoreArray.insert(String(format: "%0.2f", Float(scoreArray1[i])), atIndex: i)
        }
        
        //データの書き込み
        defaults.setObject(scoreArray1, forKey: "g1Scores")
        defaults.synchronize()
        
    }
    
    func dataUpdate2 () {
        let defaults = NSUserDefaults.standardUserDefaults()
        var scoreArray2 : [Int] = defaults.objectForKey("g2Scores") as [Int]
        
        var flag = 0
        for i in 0...8 {
            if (scoreArray2[i] == 0 || scoreArray2[i] < ansCountText.0) && flag == 0 {
                scoreArray2.insert(ansCountText.0, atIndex: i)
                updateNum = i
                flag = 1
            }
            scoreArray.insert(scoreArray2[i].description, atIndex: i)
        }
        
        //データの書き込み
        defaults.setObject(scoreArray2, forKey: "g2Scores")
        defaults.synchronize()
        
    }
    
    
    func makeMyLabel(num : Int, title: NSString, myX: CGFloat, myY: CGFloat , size: Int ) -> UILabel{
        
        let myLabel: UILabel = UILabel()
        myLabel.frame = CGRectMake(0,0,350 * xRate(),70 * yRate())
        myLabel.layer.position = CGPoint(x: myX, y: myY)
        myLabel.font = UIFont.systemFontOfSize(CGFloat(size) * sizeRate())
        myLabel.text = title
        myLabel.layer.masksToBounds = true
        myLabel.textAlignment = NSTextAlignment.Center
        if num == 1 {
            myLabel.textColor = UIColor.redColor()
        }
        
        return myLabel
    }
    
    func makeButton (title : String , X : CGFloat , Y : CGFloat , s: Selector , size: Int ) -> UIButton {
        let makeButton = UIButton()
        // サイズを設定する.
        makeButton.frame = CGRectMake(0,0,140 * xRate(),55 * yRate())
        //角を丸くする
        makeButton.layer.cornerRadius = 6
        //枠線を黒でつける
        makeButton.layer.borderWidth = 2
        makeButton.layer.borderColor = UIColor.blackColor().CGColor
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
        makeButton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(size) * sizeRate())
        // ボタンの位置を指定する.
        makeButton.layer.position = CGPoint(x: X, y:Y)
        // イベントを追加する.
        makeButton.addTarget(self, action: s, forControlEvents: .TouchUpInside)
        
        return makeButton
        
    }
    
    func home (sender : UIButton) {
        performSegueWithIdentifier("next4",sender: nil)
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
    
    
    
    //ボタンを作成するメソッド
    func makeButton1 (tagNum : Int, title: NSString, myX: CGFloat, myY: CGFloat , s :Selector) -> UIButton {
        let makeButton = UIButton()
        // サイズを設定する.
        makeButton.frame = CGRectMake(0,0,200 * xRate(),70 * yRate())
        // 背景色を設定する.
        makeButton.backgroundColor = UIColor.redColor()
        //角を丸くする
        makeButton.layer.cornerRadius = 6
        //枠線を黒でつける
        makeButton.layer.borderWidth = 2
        makeButton.layer.borderColor = UIColor.blackColor().CGColor
        // タイトルを設定する(通常時).
        makeButton.setTitle(title, forState: UIControlState.Normal)
        makeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        makeButton.setTitle(title, forState: UIControlState.Highlighted)
        makeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        //　テキストの大きさ
        makeButton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(30) * sizeRate())
        // ボタンの位置を指定する.
        makeButton.layer.position = CGPoint(x: myX, y: myY)
        // タグを設定する.
        makeButton.tag = tagNum
        // イベントを追加する.
        makeButton.addTarget(self, action: s, forControlEvents: .TouchUpInside)
        if tagNum == 1 {
            makeButton.frame = CGRectMake(0,0,50 * xRate(),50 * xRate())
            makeButton.layer.borderWidth = 0
            makeButton.layer.position = CGPoint(x: myX, y: myY)
            makeButton.backgroundColor = UIColor.whiteColor()
        }
        
        return makeButton
    }

}
