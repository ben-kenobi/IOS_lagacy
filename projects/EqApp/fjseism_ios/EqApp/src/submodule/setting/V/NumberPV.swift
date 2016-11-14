//
//  NumberPV.swift
//  EqApp
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class NumberPV: BottomPopV {
    var number:Int = 61
    var selidx:Int = 30
    lazy var pv:UIPickerView={
        let pv = UIPickerView()
        pv.delegate=self
        pv.dataSource=self
        return pv
        
    }()
    
    override func custCotent(cv: UIView) {
        pv.frame=cv.bounds
        cv.addSubview(pv)
        update()
    }
    
    func update(){
        pv.selectRow(number*50+selidx, inComponent: 0, animated: false)
    }
    func selIdx()->Int{
        return pv.selectedRowInComponent(0)%number
    }

}

extension NumberPV:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number*100
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row%number)"
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
}
