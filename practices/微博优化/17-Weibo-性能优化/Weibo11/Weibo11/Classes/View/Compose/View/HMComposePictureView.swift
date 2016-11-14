//
//  HMComposePictureView.swift
//  Weibo11
//
//  Created by itheima on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

// 可重用标识符
private let HMComposePictureViewCellId = "HMComposePictureViewCellId"

class HMComposePictureView: UICollectionView {
    
    var addImageClosure: (()->())?

    lazy var images: [UIImage] = [UIImage]()
    
    // MARK: - 控件初始化
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        // 注册 cell
        registerClass(HMComposePictureViewCell.self, forCellWithReuseIdentifier: HMComposePictureViewCellId)
        // 设置数据源为自己
        dataSource = self
        delegate = self
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        hidden = true
    }
    
    // MARK: - 供外界使用的方法
    
    func addImage(image: UIImage){
        images.append(image)
        // 刷新数据
        reloadData()
        
        hidden = false
    }
    
    /// 调整 item 的大小,为什么要放在这个地方
    // 因为 item 的大小由当前控件宽度以及高度来决定的
    // 所在这个方法里面计算 itemSize
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 计算其 item 大小
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        // 每个 item 之前的间距
        let itemMargin: CGFloat = 5
        // 计算 item 的大小
        let itemSizeWH = CGFloat(Int(width - itemMargin * 2) / 3)
        layout.itemSize = CGSize(width: itemSizeWH, height: itemSizeWH)
        // 设置水平方向以及垂直方向 cell 的最小的间距
        layout.minimumInteritemSpacing = itemMargin
        layout.minimumLineSpacing = itemMargin
        
    }
}

// MARK: - 数据源方法
extension HMComposePictureView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 如果是0张图片或者 9 张图片,就返回 images.count
        // 否则返回 images.count + 1
        let count = images.count
        return (count == 0 || count == 9) ? count : count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMComposePictureViewCellId, forIndexPath: indexPath) as! HMComposePictureViewCell
        
        if indexPath.row == images.count {
            // 设置加号按钮image
            cell.image = nil
        }else{
            cell.image = images[indexPath.row]
        }
        
        cell.indexPath = indexPath
        // 能 cell 设置删除按钮点击的闭包执行逻辑
        cell.deleteButtonClickClosure = { [weak self] (indexPath: NSIndexPath)->() in
            // 移除图片
            self?.images.removeAtIndex(indexPath.row)
            // 刷新数据
            self?.reloadData()
            self?.hidden = self?.images.count == 0
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 让对应的 cell 取消选中
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == images.count {
            // 执行添加方法
            addImageClosure?()
        }
    }
}


// MARK: - 自定义的 cell
class HMComposePictureViewCell: UICollectionViewCell {
    
    // 删除按钮点击执行的闭包
    var deleteButtonClickClosure: ((indexPath: NSIndexPath)->())?
    // 记录当前 cell 是在 collectionView 里面哪个位置,以便在移除图片的时候,知道要移除哪一张图片
    var indexPath: NSIndexPath?
    
    // 其内容显示的图片
    var image: UIImage? {
        didSet{
            if image == nil {
                // 当 image 为 nil, 是代表外界让其设置成加号按钮
                imageView.image = UIImage(named: "compose_pic_add")
                imageView.highlightedImage = UIImage(named: "compose_pic_add_highlighted")
            }else{
                imageView.image = image
                // 去掉 高亮的图片 (cell 会涉及到复用)
                imageView.highlightedImage = nil
            }
            // 根据是否有设置图片显示删除按钮
            deleteButton.hidden = image == nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        // 添加控件
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        
        // 添加约束
        imageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        deleteButton.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView)
            make.top.equalTo(contentView)
        }
    }
    
    @objc private func deleteButtonClick(){
        // 删除按钮点击了,要回调到 HMComposePictureView 里面
        deleteButtonClickClosure?(indexPath: indexPath!)
    }
    

    // MARK: - 懒加载
    
    private lazy var imageView: UIImageView = UIImageView()
    
    // 删除按钮
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "deleteButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Normal)
        return button
    }()
}
