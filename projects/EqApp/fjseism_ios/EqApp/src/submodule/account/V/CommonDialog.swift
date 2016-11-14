//
//  CommonDialog.swift
//  am
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CommonDialog: BaseDialog {
    static let celliden="celliden"
    var btns:[String]?
    var btnColor:[UIColor] = [iConst.TextRed,iConst.TextBlue]
    
    
    var cb:((pos:Int,dialog:CommonDialog)->Bool)?
    
    
    lazy var titleLab:UILabel={
        let title = UILabel(txt: "", color:iConst.orgTitCol , font: ibFont(19), align: NSTextAlignment.Center, line: 1, bgColor: iConst.blueBg)
        
        return title
        
    }()
   
    //    lazy var stack:BGStackV={
    //        let stack = BGStackV(frame:CGRectMake(0, 0, 0, 0))
    //        stack.backgroundColor=iColor(0xffeeeeee)
    //
    //        return stack
    //    }()
    
    lazy var grid:UICollectionView={
        let lo = UICollectionViewFlowLayout()
        lo.minimumInteritemSpacing=1
        let grid = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: lo)
        grid.delegate = self
        grid.dataSource=self
        grid.registerClass(TextCell.self, forCellWithReuseIdentifier: CommonDialog.celliden)
        grid.bounces=false
        grid.showsVerticalScrollIndicator=false
        grid.backgroundColor=UIColor.clearColor()
        
        return grid
    }()
    
    lazy var midContent:UIView=UIView()
    
    required init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(titleLab)
        contentView.addSubview(midContent)
        contentView.addSubview(grid)
        midContent.backgroundColor=iConst.khakiBg
        contentView.backgroundColor=iColor(0xffaaaaaa)

        titleLab.snp_makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.right.top.equalTo(0)
        }
        
        grid.snp_makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.right.bottom.equalTo(0)
        }
        
        midContent.snp_makeConstraints { (make) in
            make.top.equalTo(titleLab.snp_bottom).offset(1)
            make.bottom.equalTo(grid.snp_top).offset(-1)
            make.left.right.equalTo(0)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.greaterThanOrEqualTo(110)
        }
        
        
        iNotiCenter.addObserver(grid, selector: #selector(grid.reloadData), name:UIDeviceOrientationDidChangeNotification, object: nil)


    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit{
        iNotiCenter.removeObserver(grid)
    }

}





extension CommonDialog:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return btns?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CommonDialog.celliden, forIndexPath: indexPath) as! TextCell
        cell.lab.text=btns![indexPath.row]
        cell.lab.textColor=btnColor[indexPath.row%btnColor.count]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        if (cb?(pos: indexPath.row,dialog:self)) == true{
            dismiss()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let hei = collectionView.h
        let wid = (collectionView.w - CGFloat(btns!.count-1))/CGFloat(btns!.count)
        return CGSizeMake(wid, hei)
    }
}





class TextCell:UICollectionViewCell{
    
    
    lazy var lab:UILabel={
        let lab = UILabel( txt: "", color: iConst.TextBlue, font: ibFont(20), align: NSTextAlignment.Center, line: 1)
        
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.whiteColor()
        let selbg = UIView()
        selbg.backgroundColor=iColor(0xaaff8888)
        selectedBackgroundView=selbg
        contentView.addSubview(lab)
        lab.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
