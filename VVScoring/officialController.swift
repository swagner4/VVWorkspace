//
//  officialController.swift
//  VVScoring
//
//  Created by Tom Clark on 2/9/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class officialController: UIViewController {
    @IBOutlet weak var blueScore: UITextField!
    @IBOutlet weak var bluePen: UITextField!
    @IBOutlet weak var redScore: UITextField!
    @IBOutlet weak var redPen: UITextField!
    @IBOutlet weak var matchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        matchLabel.text = getMatchLabel(index: currentMatch)
    }
    
    @IBAction func submit(_ sender: Any) {
        if boxesLegit(){
            let rscore: Int = Int(redScore.text!)! + Int(redPen.text!)!
            let bscore: Int = Int(blueScore.text!)!  + Int(bluePen.text!)!
            
            matchData[currentMatch][0].officialScore = rscore
            matchData[currentMatch][1].officialScore = rscore
            matchData[currentMatch][2].officialScore = bscore
            matchData[currentMatch][3].officialScore = bscore
            calculateOutcome(forMatch: currentMatch)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            self.removeAnimate()
        }
    }
    
    func boxesLegit() -> Bool{
        if redScore.text != "" && blueScore.text != "" && redPen.text != "" && bluePen.text != ""{
            return true
        }
        return false
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
