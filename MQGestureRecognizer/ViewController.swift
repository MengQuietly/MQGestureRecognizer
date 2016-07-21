//
//  ViewController.swift
//  MQGestureRecognizer
//
//  Created by mengmeng on 16/7/20.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/**
 1. UIGustureRecognizer 的基本使用
 2. 若想同时使用多个手势，需借助代理实现
 */

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var imageV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tapDemo() // 点按手势
//        longPressDemo() // 长按手势
//        swipeDemo() // 轻扫手势
//        rotationDemo() // 旋转手势
//        pinchDemo() // 捏合手势
        panDemo() // 拖拽／移动手势
    }
    /******** Tap：点按 */
    /// 点按手势
    func tapDemo() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        tap.delegate = self
        imageV.addGestureRecognizer(tap)
    }
    /// 点按手势处理
    func tapClick(tap:UITapGestureRecognizer){
        print(#function)
    }
    /******** longPress：长按(默认触发2次) */
    func longPressDemo(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressClick))
        
        imageV.addGestureRecognizer(longPress)
    }
    func longPressClick(longPress:UILongPressGestureRecognizer){
        // 解决调用2次的问题
        if longPress.state == UIGestureRecognizerState.Began {
            print(#function)
        }
    }
    
    /******** swipe：轻扫(默认向右轻扫) */
    func swipeDemo(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeClick))
        // 设置轻扫 的方向（注：一个手势一个方向，若想设置多个方向，则需设置多个手势）
        swipe.direction = UISwipeGestureRecognizerDirection.Up
        imageV.addGestureRecognizer(swipe)
    }
    func swipeClick(swipe:UISwipeGestureRecognizer){
        print(#function+"\(swipe.direction)")
    }

    /******** rotation：旋转(默认传递的旋转角度是相对于最初始位置，so 需复位) */
    func rotationDemo(){
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationClick))
        imageV.addGestureRecognizer(rotation)
    }
    func rotationClick(rotation:UIRotationGestureRecognizer){
        print(#function+"\(rotation.rotation)")
        imageV.transform = CGAffineTransformRotate(imageV.transform, rotation.rotation)
        rotation.rotation = 0 // 复位
    }
    
    /******** pinch：捏合(默认传递的捏合角度是相对于最初始位置，so 需复位) */
    func pinchDemo(){
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchClick))
        imageV.addGestureRecognizer(pinch)
    }
    func pinchClick(pinch:UIPinchGestureRecognizer){
        print(#function+"\(pinch.scale)")
        imageV.transform = CGAffineTransformScale(imageV.transform, pinch.scale, pinch.scale)
        pinch.scale = 1.0 // 复位
    }
    
    /******** pan：拖拽／移动视图 (默认传递的移动是相对于最初始位置，so 需复位) */
    func panDemo(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        imageV.addGestureRecognizer(pan)
    }
    func panClick(pan:UIPanGestureRecognizer){
        
//        let currentP = pan.locationInView(imageV) // 获取手势触摸点
        // 获取 手势的移动（相对于最初始位置）
        let translateP = pan.translationInView(imageV)
        
        print(#function+"\(translateP)")
        imageV.transform = CGAffineTransformTranslate(imageV.transform, translateP.x, translateP.y)
        pan.setTranslation(CGPoint.zero, inView: imageV) // 复位
    }
    
    /** UIGestureRecognizerDelegate */
    /// 是否允许开始触发手势
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    /// 是否允许多手势(默认不支持 多手势)
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    /// 是否允许接收手指触摸点
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
//        // 当前触摸点
//        let currentP = touch.locationInView(imageV)
//        print("\(currentP.x)")
//        // imageV 左边不允许触摸，右边允许触摸
//        return (currentP.x < imageV.bounds.size.width * 0.5) ? false:true
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

