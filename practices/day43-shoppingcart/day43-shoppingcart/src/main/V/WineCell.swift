

//
//  WineCell.swift
//  day43-shoppingcart
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class WineCell: UITableViewCell {
    
     let imgw:CGFloat=65
     let btnw:CGFloat=30
    
    var quantityChange:((dict:Wine)->())?
    
    
    var dict:Wine?{
        didSet{
            guard let dic=dict else{
                return
            }
            
            img.image=iimg(dic.image!)
            var str=dic.Discount
            imgInfo.hidden=str==nil
            imgInfo.text=str
            
            name.text=dic.name
            
            money.text="¥\(dic.money!)"
            
           str = dic.OriginalPrice
            price.hidden=str==nil
            if let str = str {
                price.text="原价:\(str)"
            }
            
            updateUI()
            
        }
    }
    var img=UIImageView()
    var imgInfo:UILabel
    var name:UILabel
    var money:UILabel
   lazy var quantity:UILabel=UILabel(frame: CGRect(x: iScrW-85-self.btnw*2, y: 50, width: self.btnw, height: self.btnw), font: iFont(16), align: NSTextAlignment.Center, line: 1)
   lazy var add:UIButton=UIButton(frame:CGRect(x: iScrW-85-30, y: 50, width: self.btnw, height: self.btnw), title: "+", font: iFont(13), titleColor: UIColor.redColor(), corner: self.btnw*0.5, bordercolor: UIColor.redColor(), borderW: 1, tar: self, action: Selector("btnClick:"), tag: 0)
    
    lazy var minus:UIButton=UIButton(frame:CGRect(x: iScrW-85-self.btnw*3, y: 50, width: self.btnw, height: self.btnw), title: "-", font: iFont(13), titleColor: UIColor.redColor(), corner: self.btnw*0.5, bordercolor: UIColor.redColor(), borderW: 1, tar: self, action: Selector("btnClick:"), tag: 0)
    
    var price:UILabel
    var priceShow=UIView()
    
    
    
    
    func updateUI(){

        quantity.text="\(dict!.Quantity!)"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        
        imgInfo=UILabel(frame: CGRect(x: 0, y: imgw-10, width: imgw, height: 10),  color: UIColor.whiteColor(), font: iFont(10), align: NSTextAlignment.Center, line: 1, bgColor: iColor(255, g: 127, b: 0))
        name=UILabel( font: iFont(14), align: NSTextAlignment.Justified, line: 2)
        
        money=UILabel( color:iColor(155, g: 127, b: 0), font: iFont(14), line:1)
        price=UILabel( color: UIColor.lightGrayColor(), font: iFont(11),  line: 1)

        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle=UITableViewCellSelectionStyle.None
        
        
        
        contentView.addSubview(img)
        img.addSubview(imgInfo)
        contentView.addSubview(name)
        contentView.addSubview(money)
        contentView.addSubview(quantity)
        contentView.addSubview(add)
        contentView.addSubview(minus)
        contentView.addSubview(price)
        contentView.addSubview(priceShow)
        
       let line = UIView()
        line.backgroundColor=UIColor.grayColor()
        contentView.addSubview(line)
        
        
        img.frame=CGRect(x: 5, y: 15, width: imgw, height: imgw)
        img.layer.masksToBounds=true
        img.layer.cornerRadius=6
        
       
        name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(img.snp_right).offset(5)
            make.right.equalTo(-10)
            make.top.equalTo(5)
        }
        money.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(name)
            make.bottom.equalTo(price.snp_top).offset(-5)
        }
       price.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(name)
            make.bottom.equalTo(-5)
        }
        
        contentView.backgroundColor=iColor(246, g: 246, b: 246)
        backgroundColor=iColor(246, g: 246, b: 246)
        
        line.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func btnClick(b:UIButton){
        if let _ = dict {
            var count=dict!.quan
            b == add ? count++ : count--
            count=count>99 ? 99 : (count<0 ? 0 : count)

            self.dict!.quan=count
            
            updateUI()
            quantityChange?(dict:self.dict!)
        }
       
    }
    
}
