//
//  ViewController.swift
//  make10_2
//
//  Created by 仙石晃久 on 3/15/15.
//  Copyright (c) 2015 AkihsiaSengoku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //カーナンバーを表示するときに保持する変数
    var numArray : [Int] = []
    var letterNum = 0
    var locateTextNum = 0
    var locateNum = 0
    
    //計算の符号
    var ansSignArray : [String] = []
    //計算の答えのテキストを保存
    var ansText : String = ""
    
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
    
    //使用ボタン
    var yesButton : UIButton = UIButton()
    var noButton : UIButton = UIButton()
    var restartButton :UIButton = UIButton()
    var homeButton :UIButton = UIButton()
    
    //タイム管理用
    var initTimer : NSTimer!
    var playTimer : NSTimer!
    var timerCount : Int = 0
    var playTimeCount : Double = 0
    
    //正解数を保存
    var ansCount : Int = 0
    
    //フラグ
    var buttonFlag = 0
    
    
    let letter = ["あ","い","う","え","お","か","き","く","け","こ","さ","し","す","せ","そ","た","ち","つ","て","と","な","に","ぬ","ね","の","は","ひ","ふ","へ","ほ","ま","み","む","め","も","や","ゆ","よ","ら","り","る","れ","ろ","を"]
    
    let locateText : [String] = ["尾張小牧","札幌","函館","旭川","室蘭","釧路","帯広","北見","青森","八戸","岩手","盛岡","平泉","宮城","仙台","秋田","山形","庄内","福島","会津","郡山","いわき","水戸","土浦","つくば","宇都宮","那須","とちぎ","群馬","前橋","高崎","大宮","川口","所沢","川越","熊谷","春日部","越谷","千葉","成田","習志野","袖ヶ浦","野田","柏","品川","世田谷","練馬","杉並","足立","八王子","多摩","横浜","川崎","湘南","相模","山梨","富士山","新潟","長岡","長野","松本","諏訪","富山","石川","金沢","福井","岐阜","飛騨","静岡","浜松","沼津","伊豆","名古屋","豊橋","三河","岡崎","豊田","尾張小牧","一宮","春日井","三重","鈴鹿","滋賀","京都","大阪","なにわ","和泉","堺","奈良","和歌山","神戸","姫路","鳥取","島根","岡山","倉敷","広島","福山","山口","下関","徳島","香川","愛媛","高知","福岡","北九州","久留米","筑豊","佐賀","長崎","佐世保","熊本","大分","宮崎","鹿児島","奄美","沖縄"]
    
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setItems()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setItems () {
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
        
        countLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 160)
        countLabel.layer.position = CGPoint(x: self.view.frame.size.width/2, y: positionY - frameY/2 - frameY/10*7)
        countLabel.font = UIFont.systemFontOfSize(CGFloat(45) * sizeRate())
        countLabel.numberOfLines = 2
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
        locateNumLabel.font = UIFont.systemFontOfSize(CGFloat(55) * sizeRate())
        self.view.addSubview(locateTextLabel)
        self.view.addSubview(locateNumLabel)
        
        labelTextSet()
        
        
        let ButtonX = self.view.frame.size.width/4
        let ButtonY = self.view.frame.size.height/24
        
        //ボタン作成
        yesButton = makeButton(1, title: "YES", myX: ButtonX*1, myY: ButtonY*15, s: "yesButtonPush:")
        noButton = makeButton(1, title: "NO", myX: ButtonX*3, myY: ButtonY*15, s: "noButtonPush:")
        restartButton = makeButton(1, title: "Restart", myX: ButtonX*2, myY: ButtonY*18, s: "restartButtonPush:")
        homeButton = makeButton(1, title: "Home", myX: ButtonX*2, myY: ButtonY*21, s: "homeButtonPush:")
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        self.view.addSubview(restartButton)
        self.view.addSubview(homeButton)
        
        //最初のカウント用ラベル
        initBackLable.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        initBackLable.backgroundColor = UIColor.blackColor()
        self.view.addSubview(initBackLable)
        
        initCountLabel.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        initCountLabel.text = "3"
        initCountLabel.textColor = UIColor.whiteColor()
        initCountLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 150 * sizeRate())
        initCountLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(initCountLabel)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        firstStart()
    }
    
    func firstStart() {
        timerCount = 3
        ansCount = 0
        initBackLable.alpha = 1.0
        initCountLabel.alpha = 1.0
        initCountLabel.text = timerCount.description
        restartButton.alpha = 0
        homeButton.alpha = 0
        initTimer = NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: Selector("firstUpdate"), userInfo: nil, repeats: true)
    }
    
    func firstUpdate () {
        if timerCount == 1 {
            //最初のカウントは止める
            initTimer.invalidate()
            
            //プレイ時間を計るタイマーを開始
            playTimeCount = 0.0
            playTimer =  NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("playUpdate"), userInfo: nil, repeats: true)
            
            initBackLable.alpha = 0
            initCountLabel.alpha = 0
            buttonFlag = 1
            labelTextSet()
        }
        
        timerCount--
        initCountLabel.text = timerCount.description
    }
    
    func playUpdate () {
        playTimeCount = playTimeCount + 0.01
        
    }
    
    
    func yesButtonPush(sender: UIButton) {
        if buttonFlag == 0 {
            return
        }
        
        if autoCal() == true {
            collect()
        }else {
            notCollect()
        }
    }
    
    func noButtonPush(sender: UIButton) {
        if buttonFlag == 0 {
            return
        }
        
        if autoCal() == false {
            collect()
        }else {
            notCollect()
        }
    }
    
    
    //正解したときの処理
    func collect () {
        ansCount++
        countLabel.text = ansCount.description+"/10"
        
        //終了判定
        switch app.gameMode {
        case 0 :
            if ansCount == 10 {
                playTimer.invalidate()
                performSegueWithIdentifier("next2",sender: nil)
            }
        default :
            println("era-")
            break
        }
        labelTextSet()
    }
    
    //間違えた時の処理
    func notCollect () {
        //終了判定
        switch app.gameMode {
        case 0 :
            countLabel.text = "GAMEOVER"
            break
        case 1 :
            homeButton.titleLabel?.text="Score"
            countLabel.text = "Score\n"+String(ansCount)
        default :
            break
        }
        
        titleLabel.text = ansText
        buttonFlag = 0
        restartButton.alpha = 1
        homeButton.alpha = 1
        playTimer.invalidate()
    }
    
    
    //リスタートするときのメソッド
    func restartButtonPush(sender: UIButton) {
        firstStart()
    }
    
    //リスタートするときのメソッド
    func homeButtonPush(sender: UIButton) {
        switch app.gameMode {
        case 0 :
            performSegueWithIdentifier("next5",sender: nil)

        case 1 :
            performSegueWithIdentifier("next2",sender: nil)
        default :
            break
        }
    }

    //ラベルを作成するメソッド
    func makeNumLabel(num : Int, title: NSString, myX: CGFloat, myY: CGFloat) -> UILabel{
        
        let myLabel: UILabel = UILabel()
        myLabel.frame = CGRectMake(0,0,160 * xRate(),380 * yRate())
        myLabel.layer.position = CGPoint(x: myX, y: myY)
        myLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 95 * sizeRate())
        
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
        makeButton.frame = CGRectMake(0,0,145 * xRate(),70 * yRate())
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
        return makeButton
    }
    
    
    //ラベルの文字のセットと数字をリセットする
    func labelTextSet () {
        
        titleLabel.text = "10を作れるか？"
        
        switch app.gameMode{
        case 0 :
            countLabel.text = ansCount.description+"/10"
        case 1 :
            countLabel.text = ansCount.description
        default :
            countLabel.text = ansCount.description
        }
        
        //使用する４けたの数字をランダムで生成する　　カーナンバー
        var flag = 0
        var count = 0
        numArray = []
        for i in 0...3{
            let addNum = Int(arc4random() % 10)
            if (flag == 0 && addNum == 0){
                labelArray[i].text = "・"
            }else {
                numArray.insert(addNum, atIndex: count)
                labelArray[i].text = numArray[count].description
                flag = 1
                count++
            }
        }
        
        
        //識別番号　３けた
        locateNum = 100*Int(arc4random() % 10) + 10*Int(arc4random() % 10) + Int(arc4random() % 10)
        locateNumLabel.text = locateNum.description

        //ひらがな
        letterNum = Int(arc4random() % UInt32(letter.count))
        letterLabel.text = letter[letterNum]
        
        //地名
        locateTextNum = Int(arc4random() % UInt32(locateText.count))
        let text = locateText[locateTextNum]
        switch countElements(text) {
        case 2 :
            locateTextLabel.font = UIFont.systemFontOfSize(CGFloat(45) * sizeRate())
        case 3 :
            locateTextLabel.font = UIFont.systemFontOfSize(CGFloat(33) * sizeRate())
        case 4 :
            locateTextLabel.font = UIFont.systemFontOfSize(CGFloat(25) * sizeRate())
        default :
            locateTextLabel.font = UIFont.systemFontOfSize(CGFloat(45) * sizeRate())
            
        }
        locateTextLabel.text = locateText[locateTextNum]
        
        
        //背景と文字のの色
        var colorText = UIColor()
        var colorBack = UIColor()
        switch Int(arc4random() % 5) {
        case 0:
            colorText = UIColor.blackColor()
            colorBack = UIColor.whiteColor()
        case 1:
            colorText = UIColor(red:0.15,green:0.75,blue:0.35,alpha:1.0)
            colorBack = UIColor.whiteColor()
        case 2:
            colorText = UIColor.whiteColor()
            colorBack = UIColor(red:0.15,green:0.75,blue:0.35,alpha:1.0)
        case 3:
            colorText = UIColor.blackColor()
            colorBack = UIColor.yellowColor()
        case 4:
            colorText = UIColor.yellowColor()
            colorBack = UIColor.blackColor()
        default :
            colorText = UIColor.whiteColor()
            colorBack = UIColor.greenColor()
        }
        labelFrame.backgroundColor = colorBack
        letterLabel.textColor = colorText
        locateTextLabel.textColor = colorText
        locateNumLabel.textColor = colorText
        barLabel.textColor = colorText
        for i in 0...3{
            labelArray[i].textColor = colorText
        }
    }

    
    //ここから計算！
    func autoCal()->Bool {
        let arrayCount = numArray.count
        
        if arrayCount == 0 || arrayCount == 1 {
            return false
        }
        
        //初期化
        var sum1 : Double = 0.0
        var sum2 : Double = 0.0
        var sum3 : Double = 0.0
        ansSignArray = [String](count: arrayCount, repeatedValue: "")
        
        for a in 0...3{
            sum1 = self.cal(Double(numArray[0]), num2: Double(numArray[1]), cal: a)
            var text = "＝"+d(sum1)
            ansSignArray[0] = String(numArray[0])+self.signGet(a)+String(numArray[1])+text
            println(ansSignArray[0])
            if arrayCount == 2 {
                if sum1 == 10 {
                    ansText = ansSignArray[0]
                    println(ansText)
                    return true
                }
            }
            
            for b in 0...3{
                if arrayCount == 2 {
                    continue
                }
                
                sum2 = self.cal(sum1, num2: Double(numArray[2]), cal: b)
                ansSignArray[1] = "、"+d(sum1)+self.signGet(b)+String(numArray[2])+"＝"+d(sum2)
                
                if arrayCount == 3 {
                    if sum2 == 10 {
                        ansText = ansSignArray[0]+ansSignArray[1]
                        println(ansText)
                        return true
                    }
                }
                
                for c in 0...3{
                    if arrayCount < 4 {
                        continue
                    }
                    
                    sum3 = self.cal(sum2, num2: Double(numArray[3]), cal: c)
                    ansSignArray[2] = "、"+d(sum2)+self.signGet(c)+String(numArray[3])+"＝"+d(sum3)
                    
                    
                    if sum3 == 10 {
                        ansText = ansSignArray[0]+ansSignArray[1]+ansSignArray[2]
                        println(ansText)
                        return true
                    }
                }
            }
        }
        ansText =  "10は作れない"
        println(ansText)
        return false
    }
    
    
    func signGet(i:Int) -> String{
        switch i{
        case 0:
            return "➕"
        case 1:
            return "➖"
        case 2:
            return "✖︎"
        case 3:
            return "➗"
        default :
            return ""
        }
    }
    
    func cal(num1 : Double , num2 : Double , cal:Int) -> Double{
        switch cal {
        case 0 :
            return num1 + num2
        case 1 :
            return num1 - num2
        case 2 :
            return num1 * num2
        case 3 :
            return num1 / num2
        default :
            println("ミス！")
            return 0
        }
    }
    
    func d(d:Double) ->String {
        let dChange :Double = floor(d)
        if dChange == d  && d < 100000 && d > -100000{
            let i : Int = Int (dChange)
            return String(i)
        }else{
            return String("\(d)")
        }
        
    }
    
    /*
    
    //ここから計算！
    func autoCal()->Bool {
        
        if self.subAutoCal(numArray){ //１０になるとき
            
            var ansText0:String = ""
            
            //最初プラスの時プラスはつけない
            if (ansSignArray[0] == "➕"){
                ansText0 = numArray[0].description
            }else{
                ansText0 = ansSignArray[0]+numArray[0].description
            }
            
            let ansText1:String = ansSignArray[1]+numArray[1].description
            if numArray.count == 2 {
                ansText =  "答え:"+ansText0+ansText1
                println(ansText)
                return true
            }
            let ansText2:String = ansSignArray[2]+numArray[2].description
            if numArray.count == 3 {
                ansText =  "答え:"+ansText0+ansText1+ansText2
                println(ansText)
                return true
            }
            let ansText3:String = ansSignArray[3]+numArray[3].description
            ansText =  "答え:"+ansText0+ansText1+ansText2+ansText3
            println(ansText)
            return true
        }
        
        ansText =  "10は作れない"
        println(ansText)
        return false
    }
    
    //符号を入れ替えたこき！
    func subAutoCal(sender:Array<Int>) -> Bool {
        let arrayCount = sender.count
        
        if arrayCount == 0 || arrayCount == 1 {
            return false
        }
        
        //初期化
        ansSignArray = [String](count: arrayCount, repeatedValue: "")
        
        
        for a in 0...1{
            ansSignArray[0] = self.signGet(a)
            for b in 0...3{
                ansSignArray[1] = self.signGet(b)
                if arrayCount == 2 {
                    if self.cal(ansSignArray, numInt:sender) == 10{
                        return true
                    }
                }
                
                for c in 0...3{
                    if arrayCount < 3 {continue}
                    
                    ansSignArray[2] = self.signGet(c)
                    if arrayCount == 3 {
                        if self.cal(ansSignArray, numInt:sender) == 10{
                            return true
                        }
                    }
                    for d in 0...3{
                        if arrayCount < 4 {continue}
                        ansSignArray[3] = self.signGet(d)
                        
                        if self.cal(ansSignArray, numInt:sender) == 10{
                            return true
                        }
                        
                    }
                }
            }
        }
        return false
    }
    
    func signGet(i:Int) -> String{
        switch i{
        case 0:
            return "➕"
        case 1:
            return "➖"
        case 2:
            return "✖︎"
        case 3:
            return "➗"
        default :
            return ""
        }
    }
    
    func cal(calIn:Array<String>, numInt:Array<Int>) -> Double{
        var cal : [String] = []
        var num : [Double] = []
        println(numInt)
        println(calIn)
        
        for i in 0...calIn.count-1 {
            cal.insert(calIn[i], atIndex: i)
            num.insert(Double(numInt[i]), atIndex: i)
        }
        
        //計算スタート
        for i in 0...cal.count-1 {
            //最初のブロックだけ
            if i == 0{
                if (cal[i] == "➖"){
                    num[i] = -num[i]
                    cal[i] = "➕"
                }
                continue
            }
            
            let n1 : Double =  Double(num[i-1])
            let n2 : Double =  Double(num[i])
            if (cal[i] == "✖︎"){
                num[i] = n1 * n2
                num[i-1] = 0
                cal[i] = "➕"
            }else if(cal[i] == "➗"){
                num[i] = n1 / n2
                num[i-1] = 0
                cal[i] = "➕"
            }else if (cal[i] == "➖"){
                num[i] = -num[i]
                cal[i] = "➕"
            }
            
        }
        
        var sum :Double = 0.0
        for i in 0...cal.count-1 {
            sum = sum + num[i]
        }
        
        return sum
    }
    
*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "next2" {
            var view = segue.destinationViewController as ScoreViewController
            switch app.gameMode {
            case 0 :
                view.scoreTime = playTimeCount
            case 1:
                view.ansCountText = (ansCount , ansText)
            default :
                println("era-")
                break
            }
        }
        
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

