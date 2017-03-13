//
//  FileCell.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 2/2/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class FileCell: UITableViewCell {

    var labels: [String: (Label: UILabel, x: Int, y: Int, width: Int, height: Int)] = [
        "file": (UILabel(), 40, 0, 300, 40),
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
