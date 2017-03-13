//
//  MatchesController.swift
//  NBNP2Scoring
//
//  Created by CLARK, THOMAS on 10/24/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import UIKit

var currentMatch = 0

class MatchesController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    
    let cellReuseIdendifier = "MatchCell"
    
    @IBOutlet weak var modeSegment: UISegmentedControl!
    @IBOutlet weak var tView: UITableView!
    
    @IBOutlet weak var addMatchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tView.register(MatchCell.self, forCellReuseIdentifier: self.cellReuseIdendifier)
        tView.dataSource = self
        tView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector (MatchesController.loadList(notification:)),name:NSNotification.Name(rawValue: "load"), object: nil)
        
        tView.reloadData()
    }
    
    @IBAction func unwindToMatches(sender: UIStoryboardSegue){
        bCurrent = [0,0,0,0]
    }
    
    @IBAction func popover(_ sender: AnyObject) {
        // get a reference to the view controller for the popover
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newMatch")
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as? UIView // button
        popController.popoverPresentationController?.sourceRect = sender.bounds
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    @IBAction func officialPop(_ sender: AnyObject) {
        // get a reference to the view controller for the popover
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "officialEntry")
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as? UIView // button
        popController.popoverPresentationController?.sourceRect = sender.bounds
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    
    func loadList(notification: NSNotification){
        //load data here
        tView.reloadData()
    }
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //Get reversed index
        let nindex = (matchData.count - 1) - indexPath.row
        currentMatch = nindex
        
        if modeSegment.selectedSegmentIndex == 0{
            //Transfer Views
            let vcName = "match"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            present(viewController!, animated: true, completion: nil)
        }else{
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "officialEntry") as! officialController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tView.dequeueReusableCell(withIdentifier: self.cellReuseIdendifier, for: indexPath as IndexPath) as! MatchCell
        
        //Non reversed Index
        let nindex = (matchData.count - 1) - indexPath.row
        
        //Sort match data by number
        sortMatchData()
        
        //Get Team numbers
        var tmpTeams: [String] = []
        for x in 0..<4{
            if matchData[nindex][x].number != 0{
                tmpTeams.append(String(matchData[nindex][x].number))
            }else{
                tmpTeams.append("-")
            }
        }
        
        //Font Size
        let cfs: CGFloat = 18
        
        //Match Number
        cell.labels["match"]?.Label.text = getMatchLabel(index: nindex)
        cell.labels["match"]?.Label.font = UIFont.boldSystemFont(ofSize: cfs)
        
        //Red 1
        cell.labels["r1"]?.Label.text = String(tmpTeams[0])
        cell.labels["r1"]?.Label.font = cell.labels["r1"]?.Label.font.withSize(cfs)
        cell.labels["r1name"]?.Label.text = teamList[String(tmpTeams[0])]?.name
        cell.labels["r1name"]?.Label.font = cell.labels["r1name"]?.Label.font.withSize(16)
        
        //Red 2
        cell.labels["r2"]?.Label.text = String(tmpTeams[1])
        cell.labels["r2"]?.Label.font = cell.labels["r2"]?.Label.font.withSize(cfs)
        cell.labels["r2name"]?.Label.text = teamList[String(tmpTeams[1])]?.name
        cell.labels["r2name"]?.Label.font = cell.labels["r2name"]?.Label.font.withSize(16)
        
        //Red Score
        if matchData[nindex][0].allianceScore == -1{
            cell.labels["rscore"]?.Label.text = "-"
        }else{
            if matchData[nindex][0].officialScore == -1{
                let allianceScore = matchData[nindex][0].allianceScore
                cell.labels["rscore"]?.Label.text = String(allianceScore)
                if allianceScore > matchData[nindex][2].allianceScore{
                    cell.labels["rscore"]?.Label.textColor = UIColor.red
                    cell.labels["bscore"]?.Label.textColor = UIColor.black
                }
            }else{
                let officialScore = matchData[nindex][0].officialScore
                cell.labels["rscore"]?.Label.text = String(officialScore)
                if officialScore > matchData[nindex][2].officialScore{
                    cell.labels["rscore"]?.Label.textColor = UIColor.red
                    cell.labels["bscore"]?.Label.textColor = UIColor.black
                }
            }
        }
        cell.labels["rscore"]?.Label.font = cell.labels["rscore"]?.Label.font.withSize(20)
        
        //Divider
        cell.labels["divider"]?.Label.text = "|"
        cell.labels["divider"]?.Label.font = UIFont.boldSystemFont(ofSize: 20)
        
        //Blue Score
        if matchData[nindex][2].allianceScore == -1{
            cell.labels["bscore"]?.Label.text = "-"
        }else{
            if matchData[nindex][2].officialScore == -1{
                let allianceScore = matchData[nindex][2].allianceScore
                cell.labels["bscore"]?.Label.text = String(allianceScore)
                if allianceScore > matchData[nindex][0].allianceScore{
                    cell.labels["bscore"]?.Label.textColor = UIColor.blue
                    cell.labels["rscore"]?.Label.textColor = UIColor.black
                }
            }else{
                let officialScore = matchData[nindex][2].officialScore
                cell.labels["bscore"]?.Label.text = String(officialScore)
                if officialScore > matchData[nindex][0].officialScore{
                    cell.labels["bscore"]?.Label.textColor = UIColor.blue
                    cell.labels["rscore"]?.Label.textColor = UIColor.black
                }
            }
        }
        
        cell.labels["bscore"]?.Label.font = cell.labels["bscore"]?.Label.font.withSize(20)
        
        //Blue 1
        cell.labels["b1"]?.Label.text = String(tmpTeams[2])
        cell.labels["b1"]?.Label.font = cell.labels["b1"]?.Label.font.withSize(cfs)
        cell.labels["b1name"]?.Label.text = teamList[String(tmpTeams[2])]?.name
        cell.labels["b1name"]?.Label.font = cell.labels["b1name"]?.Label.font.withSize(16)
        
        //Blue 2
        cell.labels["b2"]?.Label.text = String(tmpTeams[3])
        cell.labels["b2"]?.Label.font = cell.labels["b2"]?.Label.font.withSize(cfs)
        cell.labels["b2name"]?.Label.text = teamList[String(tmpTeams[3])]?.name
        cell.labels["b2name"]?.Label.font = cell.labels["b2name"]?.Label.font.withSize(16)
        
        return cell
    }
}
