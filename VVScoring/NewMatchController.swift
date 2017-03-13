//
//  NewMatchController.swift
//  VVScoring
//
//  Created by WAGNER, STEVEN on 1/9/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class NewMatchController: UIViewController {

    var Q = 0
    var SF1 = 0
    var SF2 = 0
    var F = 0
    var C = 0

    @IBAction func Q(_ sender: AnyObject) {
        countMatches()
        matchData.append([teamInMatch(), teamInMatch(), teamInMatch(), teamInMatch()])
        for i in 0..<4{
            matchData[matchData.count - 1][i].match = Q
        }
        reload()
    }
    
    @IBAction func SF1(_ sender: AnyObject) {
        countMatches()
        matchData.append([teamInMatch(), teamInMatch(), teamInMatch(), teamInMatch()])
        for i in 0..<4{
            matchData[matchData.count - 1][i].match = SF1 + 1010
        }
        reload()
    }
    
    @IBAction func SF2(_ sender: AnyObject) {
        countMatches()
        matchData.append([teamInMatch(), teamInMatch(), teamInMatch(), teamInMatch()])
        for i in 0..<4{
            matchData[matchData.count - 1][i].match = SF2 + 1020
        }
        reload()
    }

    
    @IBAction func F(_ sender: AnyObject) {
        countMatches()
        matchData.append([teamInMatch(), teamInMatch(), teamInMatch(), teamInMatch()])
        for i in 0..<4{
            matchData[matchData.count - 1][i].match = F + 1030
        }
        reload()
    }
    
    @IBAction func C(_ sender: AnyObject) {
        countMatches()
        matchData.append([teamInMatch(), teamInMatch(), teamInMatch(), teamInMatch()])
        matchData[matchData.count - 1][0].match = C + 1040
        matchData[matchData.count - 1][1].match = C + 1040
        matchData[matchData.count - 1][2].match = C + 1040
        matchData[matchData.count - 1][3].match = C + 1040
        reload()
    }
    
    func reload(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    
    func countMatches(){
        Q = 0
        SF1 = 0
        SF2 = 0
        F = 0
        C = 0
        for match in matchData{
            if(match[0].match < 1010){
                Q += 1
            }
            else if(match[0].match <= 1019){
                SF1 += 1
            }
            else if(match[0].match <= 1029){
                SF2 += 1
            }
            else if(match[0].match <= 1039){
                F += 1
            }
            else if(match[0].match <= 1049){
                C += 1
            }
        }
        //print("\n\ncountMatches: Q:\(Q), SF1:\(SF1), SF2:\(SF2), F:\(F), C:\(C)\n\n")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
