//
//  customView.swift
//  DaleAndLewisChessTracker
//
//  Created by Lewis on 07/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
@IBDesignable

class CustomLabelView: UILabel {
    
    override func prepareForInterfaceBuilder() {
        loadCustomViews()
    }

    override func awakeFromNib() {
        loadCustomViews()
    }
    
    func loadCustomViews() {
        
    }

}
