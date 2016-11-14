//
//  HMEmoticonKeyboard.swift
//  Weibo11
//
//  Created by itheima on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//  表情键盘 View

import UIKit
/// 可重用 Id
private let HMEmoticonCollectionViewId = "HMEmoticonCollectionViewId"

class HMEmoticonKeyboard: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 视图初始化
    private func setupUI(){
        backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
        
        // 添加子控件
        addSubview(toolBar)
        addSubview(emoticonCollectionView)
        addSubview(emotionPageControl)
        
        // 添加约束
        toolBar.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(37)
        }
        
        emoticonCollectionView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.bottom.equalTo(toolBar.snp_top)
            make.leading.equalTo(self)
        }
        
        emotionPageControl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(toolBar.snp_top)
        }
        
        // 让界面完全显示完成之后,去滚动
        
        // 主线程异步里面的代码会在其他主线程逻辑操作完成之后再去执行
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let indexPath = NSIndexPath(forItem: 0, inSection: 1)
            // 将 collectionView 滚动到第指定组
            self.emoticonCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            self.setPageControlData(indexPath)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 取到 layout 设置 itemSize
        let layout = emoticonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = emoticonCollectionView.size
        
    }
    
    // MARK: - 懒加载控件
    private lazy var toolBar: HMEmoticonToolBar = {
        let toolBar = HMEmoticonToolBar(frame: CGRectZero)
        // 成为代理,监听 toolBar 点击事件
        toolBar.delegate = self
        return toolBar
    }()
    
    /// 显示表情的 CollectionView
    private lazy var emoticonCollectionView: UICollectionView = {
        
        // 初始化 layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        // 注册cell 
        collectionView.registerClass(HMEmoticonPageView.self, forCellWithReuseIdentifier: HMEmoticonCollectionViewId)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        // 隐藏滚动条
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        // 开启分页
        collectionView.pagingEnabled = true
        // 水平方向的弹簧效果关闭
        collectionView.bounces = false
        return collectionView
    }()
    
    // pageControl 
    private lazy var emotionPageControl: UIPageControl = {
        let pageControl = UIPageControl()
// 使用 Xcode 6.4 在头文件里面看到的
//        UIImage*        _currentPageImage;
//        UIImage*        _pageImage;
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKeyPath: "_currentPageImage")
        pageControl.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKeyPath: "_pageImage")
        
        return pageControl
    }()
}

// MARK: - HMEmoticonToolBarDelegate 按钮点击的方法
extension HMEmoticonKeyboard: HMEmoticonToolBarDelegate {
    func didselectedButtonWithType(type: HMEmoticonType) {
        // 常量有一次的赋值机会
        let indexPath: NSIndexPath
        switch type{
        case .Recent:
            indexPath = NSIndexPath(forItem: 0, inSection: 0)
            print("最近.当 collectionView滚动到第0组")
        case .Default:
            indexPath = NSIndexPath(forItem: 0, inSection: 1)
            print("默认")
        case .Emoji:
            indexPath = NSIndexPath(forItem: 0, inSection: 2)
            print("Emoji")
        case .Lxh:
            indexPath = NSIndexPath(forItem: 0, inSection: 3)
            print("浪小花")
        }
        // 将 collectionView 滚动到第指定组
        emoticonCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        setPageControlData(indexPath)
    }
}

extension HMEmoticonKeyboard: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return HMEmoticonTools.shareTools.allEmoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 返回某个表情有多少页
        return HMEmoticonTools.shareTools.allEmoticons[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMEmoticonCollectionViewId, forIndexPath: indexPath) as! HMEmoticonPageView
        printLog("section:\(indexPath.section)")
        cell.indexPath = indexPath
        cell.emoticons = HMEmoticonTools.shareTools.allEmoticons[indexPath.section][indexPath.item]
        return cell
    }
    
    
    // 监听滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 1. 取到界面上显示的 cell 
        let cells = emoticonCollectionView.visibleCells()
        
        // 2. 判断哪一个 cell 在界面上显示得多
        if cells.count == 2 {
            
            // 取到两个 cell
            let firstCell = cells.first!
            let secondCell = cells.last!
            
            // 判断哪一个 cell 在界面上显示得多 --> 怎么判断
            // contenOffset
            // 拿 cell 的 x 与 contentOffset.x 值进入相差,取绝对值
            // 哪个绝对值小,哪一个就显示得多
            
            let firstCellR = abs(Int32(firstCell.x - scrollView.contentOffset.x))
            let secondCellR = abs(Int32(secondCell.x - scrollView.contentOffset.x))
            
            let cell: UICollectionViewCell
            if firstCellR < secondCellR {
                // 第一个显示得多
                cell = firstCell
            }else{
                // 第二个显示得多
                cell = secondCell
            }
            // 根据哪一个cell 在界面显得多,取到其在 collectionView 中的 indexPath
            let indexPath = emoticonCollectionView.indexPathForCell(cell)!
                // printLog("当前是第 \(indexPath.section) 组")
                // 从 toolBar 找对对应表情类型的按钮.让其选中,让之前的取消选中
                // 只要告诉 toolBar 当前滚动到第几组就可以了.其一概不管
            toolBar.currentSection = indexPath.section
//                toolBar.viewWithTag(indexPath.section)
            setPageControlData(indexPath)
        }
    }
    /// 设置 pageControl 的数据以及显示和隐藏
    ///
    /// - parameter indexPath: <#indexPath description#>
    private func setPageControlData(indexPath: NSIndexPath){
        // 设置 pageControl 的数据
        emotionPageControl.numberOfPages = HMEmoticonTools.shareTools.allEmoticons[indexPath.section].count
        emotionPageControl.currentPage = indexPath.item
        // 如果是第0组,就隐藏
        emotionPageControl.hidden = indexPath.section == 0
    }
}
