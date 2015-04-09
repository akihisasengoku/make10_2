//
//  InitViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 2015/04/07.
//  Copyright (c) 2015年 AkihsiaSengoku. All rights reserved.
//

import UIKit

class InitViewController: UIViewController, UIScrollViewDelegate {

    
    // UIPageControl.
    var pageControl: UIPageControl!
    // UIScrillView.
    var scrollView: UIScrollView!
    // TableView.
    var myImageView: [UIImageView] = []
    // ページ番号.
    let pageSize = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (self.autoLogin()) {
            performSegueWithIdentifier("next10",sender: nil)
        }else {
            // ScrollViewの設定.
            let width = self.view.frame.maxX, height = self.view.frame.maxY
            scrollView = UIScrollView(frame: self.view.frame)
            scrollView.showsHorizontalScrollIndicator = false;
            scrollView.showsVerticalScrollIndicator = false
            scrollView.pagingEnabled = true
            scrollView.delegate = self
            scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * width, 0)
            self.view.addSubview(scrollView)
            
            // UIImageViewをViewに追加する.
            scrollView.addSubview(imageSet(UIImage(named: "pt1.png")!,num:0))
            scrollView.addSubview(imageSet(UIImage(named: "pt2.png")!,num:1))
            scrollView.addSubview(imageSet(UIImage(named: "pt3.png")!,num:2))
            scrollView.addSubview(imageSet(UIImage(named: "pt4.png")!,num:3))
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
            makeButton.setTitle("START", forState: UIControlState.Normal)
            makeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            // タイトルを設定する(ボタンがハイライトされた時).
            makeButton.setTitle("START", forState: UIControlState.Highlighted)
            makeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            //　テキストの大きさ
            makeButton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(30) * sizeRate())
            // ボタンの位置を指定する.
            makeButton.layer.position = CGPoint(x: self.view.frame.size.width*4+self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            // イベントを追加する.
            makeButton.addTarget(self, action: "start:", forControlEvents: .TouchUpInside)
            makeButton.layer.shadowOpacity = 0.2;
            scrollView.addSubview(makeButton)
            
            
            // PageControlを作成.
            pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.maxY - 40, self.view.frame.maxX, 50))
            pageControl.pageIndicatorTintColor = UIColor.grayColor()
            pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
            
            
            // PageControlするページ数を設定.
            pageControl.numberOfPages = pageSize
            
            // 現在ページを設定.
            pageControl.currentPage = 0
            pageControl.userInteractionEnabled = false
            
            self.view.addSubview(pageControl)
        }
    }
    
    func autoLogin () -> Bool {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let loginFlag = defaults.objectForKey("loginFlag") as? String {
            if loginFlag == "1"{
                println("すでに認証済み！")
                return true
            }else {
                println("まだ認証済み！")
            }
            
        }else{
            println("初めてログイン")
            defaults.setObject("0", forKey: "loginFlag")
            defaults.synchronize()
        }
        return false
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // ページの場所を切り替える.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageSet(imag:UIImage , num:Int) -> UIImageView{
        // Viewの高さと幅を取得.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        
        // UIImageViewを作成する.
        let myImageView: UIImageView = UIImageView(frame: CGRectMake(CGFloat(num) * width,-10,displayWidth,displayHeight))
        // 表示する画像を設定する.
        let myImage = imag
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        return myImageView
        
    }
    
    func start (sender : UIButton) {
        //データの書き込み
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("1", forKey: "loginFlag")
        defaults.synchronize()
        performSegueWithIdentifier("next10",sender: nil)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
