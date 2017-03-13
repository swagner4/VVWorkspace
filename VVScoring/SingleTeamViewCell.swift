//
//  SingleTeamViewCell.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 1/31/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class SingleTeamViewCell: UITableViewCell {

    var labels: [String: (Label: UILabel, x: Int, y: Int, width: Int, height: Int)] = [
        "match":            (UILabel(), 18, 0, 50, 30),
        "autoCorBalls":     (UILabel(), 75, 0, 50, 30),
        "autoVorBalls":     (UILabel(),124, 0, 50, 30),
        "autoBeacons":      (UILabel(),185, 0, 50, 30),
        "autoPark":         (UILabel(),250, 0, 50, 30),
        "autoCapPts":       (UILabel(),315, 0, 50, 30),
        "autoPts":          (UILabel(),370, 0, 50, 30),
        "corBalls":         (UILabel(),433, 0, 50, 30),
        "vorBalls":         (UILabel(),486, 0, 50, 30),
        "telePts":          (UILabel(),546, 0, 50, 30),
        "capPts":           (UILabel(),610, 0, 50, 30),
        "beaconsControlled":(UILabel(),675, 0, 50, 30),
        "beaconsHit":       (UILabel(),740, 0, 50, 30),
        "endPts":           (UILabel(),800, 0, 50, 30),
        "calcScore":        (UILabel(),860, 0, 50, 30),
        "allianceScore":    (UILabel(),920, 0, 50, 30),
        "officialScore":    (UILabel(),980, 0, 50, 30),
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
