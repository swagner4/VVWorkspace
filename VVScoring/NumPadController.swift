//
//  NumPadController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 1/18/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

var teamInputText: String = ""

class NumPadController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButton(_ sender: AnyObject) {
        let length = teamInputText.characters.count
        if length > 0{
            teamInputText = teamInputText.substring(0,end: length-2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modifyData(_ sender: AnyObject) {
        teamInputText += "\(sender.titleLabel)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
