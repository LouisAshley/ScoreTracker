//
//  ParallaxEffect.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 08/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

//import UIKit
//import CoreMotion
//
//class ParallaxEffect: UIImageView   {
//    
//    func setUpParallax(background: UIImageView) {
//        
//        let min = CGFloat(-30)
//        let max = CGFloat(30)
//        
//        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
//        xMotion.minimumRelativeValue = min
//        xMotion.maximumRelativeValue = max
//        
//        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
//        yMotion.minimumRelativeValue = min
//        yMotion.maximumRelativeValue = max
//        
//        let motionEffectGroup = UIMotionEffectGroup()
//        motionEffectGroup.motionEffects = [xMotion, yMotion]
//        
//        background.addMotionEffect(motionEffectGroup)
//        
//    }
//    
//    
//}
