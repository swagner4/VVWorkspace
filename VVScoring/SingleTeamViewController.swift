//
//  SingleTeamViewController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 1/31/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class SingleTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdendifier = "SingleTeamViewCell"
    
    //Definitions
    //Top bar
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamNumber: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var ratio: UILabel!
    @IBOutlet weak var opr: UILabel!
    //Auto
    @IBOutlet weak var autoCorner: UILabel!
    @IBOutlet weak var autoVortex: UILabel!
    @IBOutlet weak var parkingPoints: UILabel!
    @IBOutlet weak var autoBeacons: UILabel!
    @IBOutlet weak var capBallPoints: UILabel!
    @IBOutlet weak var autoPoints: UILabel!
    //Tele
    @IBOutlet weak var teleCorner: UILabel!
    @IBOutlet weak var teleVortex: UILabel!
    @IBOutlet weak var telePoints: UILabel!
    //End
    @IBOutlet weak var endCapPoints: UILabel!
    @IBOutlet weak var beacons: UILabel!
    @IBOutlet weak var beaconPresses: UILabel!
    @IBOutlet weak var endGame: UILabel!
    //Other
    @IBOutlet weak var allianceScore: UILabel!
    @IBOutlet weak var opposingScore: UILabel!
    @IBOutlet weak var officialScore: UILabel!
    @IBOutlet weak var luck: UILabel!
    
    var matches: [teamInMatch] = []
    var averages: teamAverage = teamAverage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        averages = getAverages(num: selectedTeam)
        matches = getMatches(num: selectedTeam)
        
        setLabels()
        
        tableView.register(SingleTeamViewCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRatioString() -> String{
        return "\(averages.W)-\(averages.L)=\(averages.T)"
    }
    
    func setLabels(){
        teamName.text = String (findNumber(selectedTeam))
        teamNumber.text = String (selectedTeam)
        ratio.text = getRecord(num: selectedTeam)
        opr.text = String (Round(averages.opr, to: 100))
        autoCorner.text = String (Round(averages.autoCorner))
        autoVortex.text = String (Round(averages.autoVortex))
        parkingPoints.text = String (Round(averages.parkPts))
        autoBeacons.text = String (Round(averages.autoBeacons))
        capBallPoints.text = String (Round(averages.autoCapBallPts))
        autoPoints.text = String (Round(averages.autoPts))
        teleCorner.text = String (Round(averages.cornerBalls))
        teleVortex.text = String (Round(averages.vortexBalls))
        telePoints.text = String (Round(averages.telePts))
        endCapPoints.text = String (Round(averages.capBallPts))
        beacons.text = String (Round(averages.beacons))
        beaconPresses.text = String (Round(averages.totalBeacons, to: 1))
        endGame.text = String (averages.endGamePts)
        allianceScore.text = String (Round(averages.allianceScore))
        luck.text = String (Round(averages.allianceScore - averages.opr))
        rank.text = String (getRank(num: selectedTeam))
        opposingScore.text = String (Round(averages.opposingScore))
        officialScore.text = String (Round(averages.officialScore))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath as IndexPath) as! SingleTeamViewCell
        
        cell.labels["match"]?.Label.text = String(matches[indexPath.row].match + 1)
        cell.labels["autoCorBalls"]?.Label.text = String(matches[indexPath.row].autoCorner)
        cell.labels["autoVorBalls"]?.Label.text = String(matches[indexPath.row].autoVortex)
        cell.labels["autoBeacons"]?.Label.text = String(matches[indexPath.row].autoBeacons)
        cell.labels["autoPark"]?.Label.text = String(matches[indexPath.row].parkPts)
        cell.labels["autoCapPts"]?.Label.text = String(matches[indexPath.row].autoCapBallPts)
        cell.labels["autoPts"]?.Label.text = String(matches[indexPath.row].autoPts)
        cell.labels["corBalls"]?.Label.text = String(matches[indexPath.row].cornerBalls)
        cell.labels["vorBalls"]?.Label.text = String(matches[indexPath.row].vortexBalls)
        cell.labels["telePts"]?.Label.text = String(matches[indexPath.row].telePts)
        cell.labels["capPts"]?.Label.text = String(matches[indexPath.row].capBallPts)
        cell.labels["beaconsControlled"]?.Label.text = String(matches[indexPath.row].beacons)
        cell.labels["beaconsHit"]?.Label.text = String(matches[indexPath.row].bCount)
        cell.labels["endPts"]?.Label.text = String(matches[indexPath.row].endGamePts)
        cell.labels["calcScore"]?.Label.text = String(matches[indexPath.row].calculatedScore)
        cell.labels["allianceScore"]?.Label.text = String(matches[indexPath.row].allianceScore)
        cell.labels["officialScore"]?.Label.text = String(matches[indexPath.row].officialScore)
        if(cell.labels["officialScore"]?.Label.text == "-1"){
            cell.labels["officialScore"]?.Label.text = "N/A"
        }
        
        
        return cell
    }
}
