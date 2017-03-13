//
//  MatchCell.swift
//  NBNP2Scoring
//
//  Created by Tom Clark on 11/9/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    
    var labels: [String: (Label: UILabel, x: Int, y: Int, width: Int, height: Int)] = [
        "match": (UILabel(),    0,   2, 40,  40),
        "r1": (UILabel(),       40,  2, 60,  40),
        "r1name": (UILabel(),   95,  2, 130, 40),
        "r2": (UILabel(),       230, 2, 60,  40),
        "r2name": (UILabel(),   285, 2, 150, 40),
        "rscore": (UILabel(),   445, 2, 40,  40),
        "divider": (UILabel(),  485, 0, 10,  40),
        "bscore": (UILabel(),   498, 2, 40,  40),
        "b1": (UILabel(),       570, 2, 60,  40),
        "b1name": (UILabel(),   630, 2, 140, 40),
        "b2": (UILabel(),       780, 2, 60,  40),
        "b2name": (UILabel(),   830, 2, 150, 40)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Set element sizes
        //dataLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
        
        for (_, val) in labels{
            val.Label.frame = CGRect(x: val.x, y: val.y, width: val.width, height: val.height)
        }
    }
}
