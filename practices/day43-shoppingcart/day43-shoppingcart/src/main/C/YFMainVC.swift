
//
//  YFMainVC.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFMainVC: UIViewController {
    lazy var tv:WineTV = WineTV(frame: CGRect(x: 70, y: 0, width: self.view.w()-70, height: self.view.h()-iTopBarH-50), style: UITableViewStyle.Plain)
    lazy var dock:BarDock = BarDock(frame: CGRectMake(0, 0, 70, self.view.h()-iTopBarH-50), style: UITableViewStyle.Plain)
   lazy var totalPrice:UILabel=UILabel(frame: CGRectMake(self.cartimage.r()+20,25-8,200,16), txt: "¥ 0", color: UIColor.whiteColor(), font: iFont(16),  line: 1)
    lazy var botLabel:BotLabel=BotLabel(frame: CGRectMake(self.view.w()-55-10, 25-12, 55, 24), txt: "请选购", color: UIColor.whiteColor(), font: iFont(13), align: NSTextAlignment.Center, line: 1, bgColor: UIColor.lightGrayColor())
    lazy var totalSingular:UILabel=UILabel(frame: CGRectMake(35,5,15,15), txt: "0", color: UIColor.whiteColor(), font: iFont(13), align: NSTextAlignment.Center, line: 1,bgColor:UIColor.redColor())
    lazy var cartimage:UIImageView=UIImageView(frame: CGRectMake(10,5,40,40))
    
    var idxAry:[CGPoint]=[CGPoint]()
    var quantity:Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        navigationItem.titleView=UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: iNavH), txt: "wine", color: iColor(255, g: 127, b: 0), font: ibFont(22), align: NSTextAlignment.Center, line: 1)
        view.addSubview(tv)
        
        
        
        tv.clo={
            [weak self](dict:Wine)->() in
            ShoppingCart.ins.save(dict, cb: { (quan, total) -> () in

                self?.totalSingular.hidden = quan==0
                self?.totalSingular.text=String(format: "%ld", quan)
                self?.totalPrice.text=String(format: "¥ %.2f", total)
                if quan == 0 {
                    self?.botLabel.backgroundColor=UIColor.lightGrayColor()
                    self?.botLabel.userInteractionEnabled=false
                    self?.botLabel.text="请购买"
                }else{
                    self?.botLabel.backgroundColor=UIColor.clearColor()
                    self?.botLabel.userInteractionEnabled=true
                    self?.botLabel.text="去结算"
                }
            })
            
            
        }

        view.addSubview(dock)
        dock.onChange={
            [weak self](datas:[Wine]?,lastIdx:NSIndexPath,curIdx:NSIndexPath)->() in
            self?.idxAry[lastIdx.row]=(self?.tv.contentOffset)!
            self?.tv.datas=datas
            self?.tv.contentOffset = (self?.idxAry[curIdx.row])!

        }
        
        let datas:[AnyObject] = LoadView.datas()
        for _ in 0..<datas.count{
            idxAry.append(CGPointMake(0, 0))
        }
        
         dock.dictdatas=datas
        
        let v=UIView(frame: CGRectMake(0,view.h()-50-64,view.w(),50))
        v.backgroundColor=iColor(29, g: 29, b: 29)
        view.addSubview(v)
        
        v.addSubview(botLabel)
        botLabel.layer.masksToBounds=true
        botLabel.layer.cornerRadius=6
        botLabel.layer.borderWidth=1
        botLabel.userInteractionEnabled=false
        botLabel.addTarget(self, sel: "settleAccount", event: .tap)
        
        cartimage.image=iimg("Home_Cart.jpg")
        v.addSubview(cartimage)
        
        v.addSubview(totalPrice)

        v.addSubview(totalSingular)
        totalSingular.hidden=true
        totalSingular.layer.masksToBounds=true
        totalSingular.layer.cornerRadius=7.5
      
        
    }
    
    func settleAccount(){
       self.navigationController?.showViewController(VC01(), sender: nil)
    }
    
    deinit{
        print("------------")
    }
    
}

extension YFMainVC{
    
}




