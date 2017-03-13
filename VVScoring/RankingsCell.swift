//
//  RankingsCell.swift
//  NBNP2Scoring
//
//  Created by CLARK, THOMAS on 10/24/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import UIKit

class RankingsCell: UITableViewCell {
    
    var labels: [String: (Label: UILabel, x: Int, y: Int, width: Int, height: Int)] = [
        "number": (UILabel(),20, 0, 50, 30),
        "name": (UILabel(),90, 0, 150, 30),
        "rank": (UILabel(),285, 0, 30, 30),
        "RP": (UILabel(),325, 0, 100, 30),
        "wins": (UILabel(),385, 0, 30, 30),
        "losses": (UILabel(),420, 0, 30, 30),
        "tie": (UILabel(),455, 0, 30, 30),
        "opr": (UILabel(),490, 0, 50, 30),
        "autoPts": (UILabel(),558, 0, 60, 30),
        "autoBalls": (UILabel(),625, 0, 30, 30),
        "autoBeacons": (UILabel(),685, 0, 30, 30),
        "teleBalls": (UILabel(),745, 0, 50, 30),
        "endBeacons": (UILabel(), 817, 0, 30, 30),
        "capPts": (UILabel(), 872, 0, 50, 30),
        "partnerScore": (UILabel(), 920, 0, 60, 30)
    ]
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add elements as subview to the contentView
        //self.contentView.addSubview(dataLabel)
        for ( _ , value) in labels{
            self.contentView.addSubview(value.Label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
    }*/
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Set element sizes
        //dataLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
        
        for (_, val) in labels{
            val.Label.frame = CGRect(x: val.x, y: val.y, width: val.width, height: val.height)
        }
    }
}
