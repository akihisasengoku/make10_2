//
//  RuleViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 3/19/15.
//  Copyright (c) 2015 AkihsiaSengoku. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {

    //使用ラベル
    var labelFrame : UILabel = UILabel()
    var barLabel : UILabel = UILabel()
    var labelArray : [UILabel] = [UILabel()]
    var letterLabel : UILabel = UILabel()
    var locateTextLabel : UILabel = UILabel()
    var locateNumLabel : UILabel = UILabel()
    var countLabel : UILabel = UILabel()
    var titleLabel : UILabel = UILabel()
    
    var initBackLable : UILabel = UILabel()
    var initCountLabel : UILabel = UILabel()
    
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ruleX = self.view.frame.size.width/2
        let ruleY = self.view.frame.size.height/43
        
        var ruleLabel : UILabel = makeNumLabel(1, title: "ルール", myX: ruleX, myY: ruleY*4)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(50)*sizeRate())
        self.view.addSubview(ruleLabel)
        
        var ruleText : String = ""
        if app.gameMode == 0 {
            ruleText = "10問連続で正解するタイム\n間違えたらそこで終了"
        } else if (app.gameMode == 1) {
            ruleText = "間違えずに正解できる数\n間違えたらそこで終了"
        }
        
        ruleLabel = makeNumLabel(1, title: ruleText, myX: ruleX, myY: ruleY*9)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(20)*sizeRate())
        ruleLabel.numberOfLines = 2
        self.view.addSubview(ruleLabel)
        
        ruleText = "1.真ん中の数字（1234）のみを使って10を作る"
        ruleLabel = makeNumLabel(1, title: ruleText, myX: ruleX, myY: ruleY*28)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(20)*sizeRate())
        ruleLabel.numberOfLines = 2
        self.view.addSubview(ruleLabel)
        
        ruleText = "2.数字の並び替えはできません"
        ruleLabel = makeNumLabel(1, title: ruleText, myX: ruleX, myY: ruleY*31)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(20)*sizeRate())
        ruleLabel.numberOfLines = 2
        self.view.addSubview(ruleLabel)
        
        ruleText = "3.➕、➖、✖︎、➗のみを使う"
        ruleLabel = makeNumLabel(1, title: ruleText, myX: ruleX, myY: ruleY*34)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(20)*sizeRate())
        ruleLabel.numberOfLines = 2
        self.view.addSubview(ruleLabel)
        
        ruleText = "例：1✖︎2➖3✖︎4＝10"
        ruleLabel = makeNumLabel(1, title: ruleText, myX: ruleX, myY: ruleY*24)
        ruleLabel.font = UIFont.systemFontOfSize(CGFloat(20)*sizeRate())
        ruleLabel.numberOfLines = 2
        self.view.addSubview(ruleLabel)
        
        
        let makeButton = UIButton()
        // サイズを設定する.
        makeButton.frame = CGRectMake(0,0,145 * xRate(),70 * yRate())
        // 背景色を設定する.
        makeButton.backgroundColor = UIColor.redColor()
        //角を丸くする
        makeButton.layer.cornerRadius = 6
        //枠線を黒でつける
        makeButton.layer.borderWidth = 2
        makeButton.layer.borderColor = UIColor.blackColor().CGColor
        // タイトルを設定する(通常時).
        makeButton.setTitle("START", forState: UIControlState.Normal)
        makeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        makeButton.setTitle("START", forState: UIControlState.Highlighted)
        makeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        //　テキストの大きさ
        makeButton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(30) * sizeRate())
        // ボタンの位置を指定する.
        makeButton.layer.position = CGPoint(x: ruleX, y: ruleY*39)
        // イベントを追加する.
        makeButton.addTarget(self, action: "pushButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(makeButton)
        
        
        let frameX = self.view.frame.size.width-40
        let frameY = (self.view.frame.size.width-40)/2.1
        
        let positionY = self.view.frame.height/5*2
        
        labelFrame.frame = CGRectMake(0, 0, frameX, frameY)
        labelFrame.layer.position = CGPoint(x: self.view.frame.size.width/2, y: positionY)
        labelFrame.layer.borderColor = UIColor.blackColor().CGColor
        labelFrame.layer.borderWidth = 2
        labelFrame.layer.cornerRadius = 6
        labelFrame.layer.masksToBounds = true
        self.view.addSubview(labelFrame)
        
        titleLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 30)
        titleLabel.layer.position = CGPoint(x: self.view.frame.size.width/2, y: positionY - frameY/2 - frameY/5)
        titleLabel.font = UIFont.systemFontOfSize(CGFloat(20) * sizeRate())
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)
        
        countLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 80)
        countLabel.layer.position = CGPoint(x: self.view.frame.size.width/2, y: positionY - frameY/2 - frameY/2)
        countLabel.font = UIFont.systemFontOfSize(CGFloat(50) * sizeRate())
        countLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(countLabel)
        
        
        //下の数字と文字とハイフンのラベルの作成！
        let labelX = frameX/36
        let labelY = frameY/12
        let numY = self.view.frame.height/5*2 + labelY*2
        
        barLabel = makeNumLabel(0, title:"-", myX: 20 + labelX*21, myY: numY)
        self.view.addSubview(barLabel)
        
        letterLabel = makeNumLabel(0, title:"あ", myX: 20 + labelX*4, myY: numY)
        letterLabel.font = UIFont.systemFontOfSize(CGFloat(40 * sizeRate()))
        self.view.addSubview(letterLabel)
        
        labelArray.insert(makeNumLabel(0, title:"1", myX: 20 + labelX*10, myY: numY), atIndex: 0)
        labelArray.insert(makeNumLabel(0, title:"2", myX: 20 + labelX*16, myY: numY), atIndex: 1)
        labelArray.insert(makeNumLabel(0, title:"3", myX: 20 + labelX*26, myY: numY), atIndex: 2)
        labelArray.insert(makeNumLabel(0, title:"4", myX: 20 + labelX*32, myY: numY), atIndex: 3)
        
        self.view.addSubview(labelArray[0])
        self.view.addSubview(labelArray[1])
        self.view.addSubview(labelArray[2])
        self.view.addSubview(labelArray[3])
        
        
        //上の文字と数字の作成
        let locateY = positionY - labelY*3
        locateTextLabel = makeNumLabel(0, title: "岐阜", myX:20 + labelX*14, myY: locateY)
        locateNumLabel = makeNumLabel(0, title: "100", myX:20 + labelX*24, myY: locateY)
        locateTextLabel.font = UIFont.systemFontOfSize(CGFloat(45) * sizeRate())
        locateNumLabel.font = UIFont.systemFontOfSize(CGFloat(55) * sizeRate())
        self.view.addSubview(locateTextLabel)
        self.view.addSubview(locateNumLabel)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushButton(sender:UIButton) {
        performSegueWithIdentifier("next1",sender: nil)
    }


    
    //ラベルを作成するメソッド
    func makeNumLabel(num : Int, title: NSString, myX: CGFloat, myY: CGFloat) -> UILabel{
        
        let myLabel: UILabel = UILabel()
        myLabel.frame = CGRectMake(0,0,300 * xRate(),130 * yRate())
        myLabel.layer.position = CGPoint(x: myX, y: myY)
        myLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 95 * sizeRate())
        
        myLabel.text = title
        myLabel.layer.masksToBounds = true
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.tag = num
        
        return myLabel
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
