//
//  TitleViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 2015/03/22.
//  Copyright (c) 2015年 AkihsiaSengoku. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var X = self.view.frame.size.width / 2
        var Y = self.view.frame.size.height / 20
        
        let titleLabel = makeNumLabel(0, title: "make10", myX: X, myY: Y * 6)
        self.view.addSubview(titleLabel)
        let g1Button = makeButton(0, title: "TimeAttack", myX: X, myY: Y * 10, s: "g1:")
        let g2Button = makeButton(0, title: "Perfect", myX: X, myY: Y * 13, s: "g2:")
        let scoreButton = makeButton(0, title: "Score", myX: X, myY: Y * 16, s: "score:")
        self.view.addSubview(g1Button)
        self.view.addSubview(g2Button)
        self.view.addSubview(scoreButton)
        
        // UIImageViewを作成する.
        let myImageView: UIImageView = UIImageView(frame: CGRectMake(0,0,self.view.frame.size.width/10*9,Y*5))
        // 表示する画像を設定する.
        let myImage = UIImage(named: "make10.png")
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        // 画像の表示する座標を指定する.
        myImageView.layer.position = CGPoint(x: X, y: Y * 5)
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
        let homeButton = makeButton(1, title: "", myX: self.view.frame.size.width/12, myY: self.view.frame.size.width/8, s: "home:")
        var buttonImage = UIImage(named: "HomeBotton.png") as UIImage?
        homeButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        self.view.addSubview(homeButton)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func g1 (sender : UIButton) {
        app.gameMode = 0
        performSegueWithIdentifier("next3",sender: nil)
    }
    
    func g2 (sender : UIButton) {
        app.gameMode = 1
        performSegueWithIdentifier("next3",sender: nil)
    }
    
    func score (sender : UIButton) {
        performSegueWithIdentifier("next6",sender: nil)
    }
    
    func home (sender : UIButton) {
        performSegueWithIdentifier("next6",sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //ラベルを作成するメソッド
    func makeNumLabel(num : Int, title: NSString, myX: CGFloat, myY: CGFloat) -> UILabel{
        
        let myLabel: UILabel = UILabel()
        myLabel.frame = CGRectMake(0,0,300 * xRate(),130 * yRate())
        myLabel.layer.position = CGPoint(x: myX, y: myY)
        myLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 40 * sizeRate())
        
        myLabel.text = title
        myLabel.layer.masksToBounds = true
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.tag = num
        
        return myLabel
    }
    
    //ボタンを作成するメソッド
    func makeButton (tagNum : Int, title: NSString, myX: CGFloat, myY: CGFloat , s :Selector) -> UIButton {
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
