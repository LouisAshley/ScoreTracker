//
//  CustomLabelFile.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 07/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit

@IBDesignable

class CustomLabelFile: UILabel {
    
    override func prepareForInterfaceBuilder() {
        customView()
    }
    
    override func awakeFromNib() {
        customView()
    }
    
    func customView() {
        layer.borderColor = #colorLiteral(red: 0.7801570596, green: 0.7801570596, blue: 0.7801570596, alpha: 0.801056338)
        layer.borderWidth = 2
        
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 20
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.34)
        
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }

    
}
