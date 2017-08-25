//
//  SwiftCountdownButton.swift
//  SwiftCountdownButtonExample
//
//  Created by Gesen on 15/6/4.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

class SwiftCountdownButton: UIButton {
    
    // MARK: Properties
    
    var maxSecond = 60
    var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    fileprivate var second = 0
    fileprivate var timer: Timer?
    
    // MARK: Life Cycle
    
    deinit {
        countdown = false
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    // MARK: Private
    
    fileprivate func startCountdown() {
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    fileprivate func updateNormal() {
        maxSecond = 60
        isEnabled = true
        setTitle("获取验证码", for: .normal);
    }
    
    fileprivate func updateDisabled() {
        isEnabled = false
        let titleStr = String.init(format: "获取验证码(%d)", second);
        setTitle(titleStr, for: .normal);
    }
    
    @objc fileprivate func updateCountdown() {
        second -= 1
        if second <= 0 {
            countdown = false
        } else {
            updateDisabled()
        }
    }
    
}
