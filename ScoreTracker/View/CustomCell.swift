//
//  CustomGameCell.swift
//  ScoreTracker
//
//  Created by Lewis on 13/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var cellBackground: UIImageView!
    @IBOutlet weak var gameNameText: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var opponentImage: UIImageView!
    @IBOutlet weak var versesText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    
    func configMatchesCell(username: String, opponentsName: String) {
        userImage.layer.cornerRadius = 20
        opponentImage.layer.cornerRadius = 20
        versesText.text = "\(username) \nVS \n\(opponentsName)"
    }
    
    
    
    
    func configGamesCell(gameType: String) {
        gameNameText.highlightedTextColor = UIColor.black
        let textOutline: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .strokeWidth : -4.0,
        ]
        gameNameText.attributedText = NSAttributedString(string: gameType, attributes: textOutline)
        
        switch gameType {
        case "Chess":
            cellBackground.image = UIImage(named: CHESS)
        case "Pool":
            cellBackground.image = UIImage(named: POOL)
        case "Tennis":
            cellBackground.image = UIImage(named: TENNISTWO)
        default:
            return
        }
        
    }
    
    
    
}
