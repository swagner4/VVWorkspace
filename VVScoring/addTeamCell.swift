//
//  addTeamCell.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 1/19/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class addTeamCell: UITableViewCell {

    var labels: [String: (Label: UITextField, x: Int, y: Int, width: Int, height: Int)] = [
        "number": (UITextField(),10, 0, 50, 40),
        "name": (UITextField(),65, 0, 150, 40)
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
