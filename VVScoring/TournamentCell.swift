//
//  TournamentCell.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 12/8/16.
//  Copyright © 2016 Q Is Silqent. All rights reserved.
//

import UIKit

class TournamentCell: UITableViewCell {

    var labels: [String: (Label: UILabel, x: Int, y: Int, width: Int, height: Int)] = [
        "name": (UILabel(), 20, 0, 200, 30),
        "date": (UILabel(), 220, 0, 100, 30)
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
    
    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
