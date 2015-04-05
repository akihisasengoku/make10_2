//
//  AllScoreViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 2015/03/23.
//  Copyright (c) 2015年 AkihsiaSengoku. All rights reserved.
//

import UIKit

class AllScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var X = self.view.frame.size.width / 4
        var Y = self.view.frame.size.height / 45
        
        
        self.view.addSubview(makeMyLabel(0, title: "TimeAttack", myX: X*1, myY: Y*6, size: 30))
        self.view.addSubview(makeMyLabel(0, title: "Perfect", myX: X*3, myY: Y*6, size: 30))
        
        //データを読み込んで表示
        let defaults = NSUserDefaults.standardUserDefaults()
        var scoreArray1 : [Double] = defaults.objectForKey("g1Scores") as [Double]
        var scoreArray2 : [Int] = defaults.objectForKey("g2Scores") as [Int]
        
        for i in 0...8 {
            var d = CGFloat(i*3+11)
            var text = ""
            text = i.description+"位    "+String(format: "%0.2f", Float(scoreArray1[i]))
            self.view.addSubview(makeMyLabel(0, title: text, myX: X*1, myY: Y*d, size: 20))
            text = i.description+"位    "+scoreArray2[i].description
            self.view.addSubview(makeMyLabel(0, title: text, myX: X*3, myY: Y*d, size: 20))
        }
        
        
        self.view.addSubview(makeButton("HOME", X: X*2, Y: Y*39, s: "Home:", size: 20))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func Home(seder : UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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
        makeButton.frame = CGRectMake(0,0,140 * xRate(),45 * yRate())
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
