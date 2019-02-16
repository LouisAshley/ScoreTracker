//
//  CustomButtonView.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 07/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit

@IBDesignable

class CustomButtonView: UIButton {
    
    override func prepareForInterfaceBuilder() {
        customView()
    }
    
    override func awakeFromNib() {
        customView()
    }
    
    func customView() {
        layer.borderColor = #colorLiteral(red: 0.7801570596, green: 0.7801570596, blue: 0.7801570596, alpha: 0.801056338)
        layer.borderWidth = 3
        
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 20
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        layer.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.3518889127)
        
        
        setTitleColor(UIColor.white, for: .normal)
        
        setTitleColor(UIColor.white, for: .selected)
    }
    
    
}
