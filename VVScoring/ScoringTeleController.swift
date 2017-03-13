//
//  ScoringTeleController.swift
//  NBNP2Scoring
//
//  Created by MUELLER, HANS on 11/9/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import UIKit

class ScoringTeleController: UIViewController {
    
    
    
    
    //save data
    @IBAction func toAuto(_ sender: AnyObject) {
        saveMatchData()
    }
    
    //save data
    @IBAction func toMatches(_ sender: AnyObject) {
        saveMatchData()
    }
    
    
    @IBOutlet var redAllianceScore: UILabel!
    @IBOutlet var blueAllianceScore: UILabel!
    @IBOutlet var matchLabel: UILabel!
    
    

    @IBOutlet weak var r1TNumField: UITextField!
    @IBOutlet var r1TCenter: UILabel!
    @IBOutlet var r1TCorner: UILabel!
    @IBOutlet var r1TCapPts: UILabel!
    @IBOutlet var r1TScore: UILabel!
    @IBOutlet var r1TMatchScore: UILabel!
    @IBOutlet var r1TCapDNA: UISwitch!
    @IBOutlet weak var r1NameField: UITextField!
    var r1numValid = true
    
    @IBAction func r1NameChange(_ sender: AnyObject) {

        if let temp = teamList[r1TNumField.text!]?.name {
            r1NameField.text = teamList[r1TNumField.text!]?.name
            matchData[currentMatch][0].number = Int (r1TNumField.text!)!
            r1numValid = true
        }
        else {
            r1NameField.text = "Wrong Number"
            r1numValid = false
        }
        refreshLabels()

    }
    
    
    @IBOutlet weak var r2TNumField: UITextField!
    @IBOutlet var r2TCenter: UILabel!
    @IBOutlet var r2TCorner: UILabel!
    @IBOutlet var r2TCapPts: UILabel!
    @IBOutlet var r2TScore: UILabel!
    @IBOutlet var r2TMatchScore: UILabel!
    @IBOutlet var r2TCapDNA: UISwitch!
    @IBOutlet weak var r2NameField: UITextField!
    var r2numValid = true
    
    @IBAction func r2NameChange(_ sender: AnyObject) {

        if let temp = teamList[r2TNumField.text!]?.name {
            r2NameField.text = teamList[r2TNumField.text!]?.name
            matchData[currentMatch][1].number = Int (r2TNumField.text!)!
            r2numValid = true
        }
        else {
            r2NameField.text = "Wrong Number"
            r2numValid = false
        }
        refreshLabels()
    }
    
    @IBOutlet weak var b1TNumField: UITextField!
    @IBOutlet var b1TCenter: UILabel!
    @IBOutlet var b1TCorner: UILabel!
    @IBOutlet var b1TCapPts: UILabel!
    @IBOutlet var b1TScore: UILabel!
    @IBOutlet var b1TMatchScore: UILabel!
    @IBOutlet var b1TCapDNA: UISwitch!
    @IBOutlet weak var b1NameField: UITextField!
    var b1numValid = true
    
    @IBAction func b1NameChange(_ sender: AnyObject) {

        if let temp = teamList[b1TNumField.text!]?.name {
            b1NameField.text = teamList[b1TNumField.text!]?.name
            matchData[currentMatch][2].number = Int (b1TNumField.text!)!
            b1numValid = true
        }
        else {
            b1NameField.text = "Wrong Number"
            b1numValid = false
        }
        refreshLabels()
    }
    
    @IBOutlet weak var b2TNumField: UITextField!
    @IBOutlet var b2TCenter: UILabel!
    @IBOutlet var b2TCorner: UILabel!
    @IBOutlet var b2TCapPts: UILabel!
    @IBOutlet var b2TScore: UILabel!
    @IBOutlet var b2TMatchScore: UILabel!
    @IBOutlet var b2TCapDNA: UISwitch!
    @IBOutlet weak var b2NameField: UITextField!
    var b2numValid = true
    

    @IBAction func b2NameChange(_ sender: AnyObject) {
    
        if let temp = teamList[b2TNumField.text!]?.name {
            b2NameField.text = teamList[b2TNumField.text!]?.name
            matchData[currentMatch][3].number = Int (b2TNumField.text!)!
            b2numValid = true
        }
        else {
            b2NameField.text = "Wrong Number"
            b2numValid = false
        }
        refreshLabels()
    }
    
    
    //Beacons
    
    
    
    @IBOutlet var r1r: UIButton!
    @IBOutlet var r1b: UIButton!
    @IBOutlet var r2r: UIButton!
    @IBOutlet var r2b: UIButton!
    @IBOutlet var b1r: UIButton!
    @IBOutlet var b1b: UIButton!
    @IBOutlet var b2r: UIButton!
    @IBOutlet var b2b: UIButton!
    
    @IBOutlet var r1team: UIButton!
    @IBOutlet var r2team: UIButton!
    @IBOutlet var b1team: UIButton!
    @IBOutlet var b2team: UIButton!
    
    
    @IBAction func r1select(_ sender: AnyObject) {
        currentTeam = matchData[currentMatch][0].number
        selectedTeam.text = String (currentTeam)
    }
    @IBAction func r2select(_ sender: AnyObject) {
        currentTeam = matchData[currentMatch][1].number
        selectedTeam.text = String (currentTeam)
    }
    @IBAction func b1select(_ sender: AnyObject) {
        currentTeam = matchData[currentMatch][2].number
        selectedTeam.text = String (currentTeam)
    }
    @IBAction func b2select(_ sender: AnyObject) {
        currentTeam = matchData[currentMatch][3].number
        selectedTeam.text = String (currentTeam)
    }
    
    
    @IBOutlet var selectedTeam: UILabel!
    
    //var bCurrent: [Int] = [0,0,0,0]
    
    func bCheck(beacon: Int, check: Int){
        for i in 0..<4{ //i -> 4 teams
            if(matchData[currentMatch][i].bType[beacon] == check){
                matchData[currentMatch][i].bType[beacon] = 0

            }
        }
    }
    
    func teamIndex(number: Int) -> Int {
        for i in 0..<4{
            if(matchData[currentMatch][i].number == number){
                return i
            }
        }
        return -1
    }

    @IBAction func r1red(_ sender: AnyObject) {
        if(bCurrent[0] == 1){
            return
        }
        else if (bCurrent[0] == 2){
            bCheck(beacon: 0, check: 2)
        }
        matchData[currentMatch][teamIndex(number: currentTeam)].bType[0] = 1
        matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
        r1owner.text = String (currentTeam)
        refreshLabels()
    }
    @IBAction func r1blue(_ sender: AnyObject) {
        if(bCurrent[0] == 2){
            return
        }
        else if (bCurrent[0] == 1){
            bCheck(beacon: 0, check: 1)
        }
            matchData[currentMatch][teamIndex(number: currentTeam)].bType[0] = 2
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            r1owner.text = String (currentTeam)
        refreshLabels()
    }
    @IBOutlet var r1owner: UILabel!
    
    @IBAction func r2red(_ sender: AnyObject) {
        if(bCurrent[1] == 1){
            return
        }
        else if (bCurrent[1] == 2){
            bCheck(beacon: 1, check: 2)
        }
            matchData[currentMatch][teamIndex(number: currentTeam)].bType[1] = 1
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            r2owner.text = String (currentTeam)
        refreshLabels()
    }
    @IBAction func r2blue(_ sender: AnyObject) {
        if(bCurrent[1] == 2){
            return
        }
        else if (bCurrent[1] == 1){
            bCheck(beacon: 1, check: 1)
        }
            matchData[currentMatch][teamIndex(number: currentTeam)].bType[1] = 2
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            r2owner.text = String (currentTeam)
        refreshLabels()
    }
    @IBOutlet var r2owner: UILabel!
    
    @IBAction func b1red(_ sender: AnyObject) {
        if(bCurrent[2] == 1){
            return
        }
        else if (bCurrent[2] == 2){
            bCheck(beacon: 2, check: 2)
        }

            matchData[currentMatch][teamIndex(number: currentTeam)].bType[2] = 1
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            b1owner.text = String (currentTeam)
        
        refreshLabels()
    }
    @IBAction func b1blue(_ sender: AnyObject) {
        if(bCurrent[2] == 2){
            return
        }
        else if (bCurrent[2] == 1){
            bCheck(beacon: 2, check: 1)
        }

            matchData[currentMatch][teamIndex(number: currentTeam)].bType[2] = 2
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            b1owner.text = String (currentTeam)
        
        refreshLabels()
    }
    @IBOutlet var b1owner: UILabel!

    @IBAction func b2red(_ sender: AnyObject) {
        if(bCurrent[3] == 1){
            return
        }
        else if (bCurrent[3] == 2){
            bCheck(beacon: 3, check: 2)
        }

            
            matchData[currentMatch][teamIndex(number: currentTeam)].bType[3] = 1
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            b2owner.text = String (currentTeam)
        
        refreshLabels()
    }
    @IBAction func b2blue(_ sender: AnyObject) {
        if(bCurrent[3] == 2){
            return
        }
        else if (bCurrent[3] == 1){
            bCheck(beacon: 3, check: 1)
        }

            matchData[currentMatch][teamIndex(number: currentTeam)].bType[3] = 2
            matchData[currentMatch][teamIndex(number: currentTeam)].bCount += 1
            b2owner.text = String (currentTeam)
        
        refreshLabels()
    }
    @IBOutlet var b2owner: UILabel!

    
    var currentTeam = 7655
    
    
    func populateBeacons(){
        /*
        for teams in 0..<4{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].autoBType[beacons] == 1){
                    bCurrent[beacons] = 1
                    if(beacons == 0){
                        r1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 1){
                        r2owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 2){
                        b1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 3){
                        b2owner.text = String (matchData[currentMatch][teams].number)
                    }
                }
                if(matchData[currentMatch][teams].autoBType[beacons] == 2){
                    bCurrent[beacons] = 2
                    if(beacons == 0){
                        r1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 1){
                        r2owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 2){
                        b1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 3){
                        b2owner.text = String (matchData[currentMatch][teams].number)
                    }
                }
            }
        }
        */
        for teams in 0..<4{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].bType[beacons] == 1){
                    bCurrent[beacons] = 1
                    if(beacons == 0){
                        r1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 1){
                        r2owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 2){
                        b1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 3){
                        b2owner.text = String (matchData[currentMatch][teams].number)
                    }
                }
                if(matchData[currentMatch][teams].bType[beacons] == 2){
                    bCurrent[beacons] = 2
                    if(beacons == 0){
                        r1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 1){
                        r2owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 2){
                        b1owner.text = String (matchData[currentMatch][teams].number)
                    }
                    else if(beacons == 3){
                        b2owner.text = String (matchData[currentMatch][teams].number)
                    }
                }
            }
        }
    }
    
    
    //SCORING
    func refreshLabels(){
        
        //populate bCurrent
        populateBeacons()
        
        
        if matchData[currentMatch][0].number == 0 {
            r1team.setTitle("", for: .normal)
        }
        else {
            print("\n\nsomething:\(matchData[currentMatch][0].number)")
            r1team.setTitle(String (matchData[currentMatch][0].number), for: .normal)
        }
        if matchData[currentMatch][1].number == 0 {
            r2team.setTitle("", for: .normal)
        }
        else {
            print("\n\nsomething:\(matchData[currentMatch][1].number)")
            r2team.setTitle(String (matchData[currentMatch][1].number), for: .normal)
        }
        if matchData[currentMatch][2].number == 0 {
            b1team.setTitle("", for: .normal)
        }
        else {
            print("\n\nsomething:\(matchData[currentMatch][2].number)")
            b1team.setTitle(String (matchData[currentMatch][2].number), for: .normal)
        }
        if matchData[currentMatch][3].number == 0 {
            b2team.setTitle("", for: .normal)
        }
        else {
            print("\n\nsomething:\(matchData[currentMatch][3].number)")
            b2team.setTitle(String (matchData[currentMatch][3].number), for: .normal)
        }

        
        if(r1team.titleLabel?.text == "0"){
            r1team.setTitle("", for: .normal)
        }
        if(r2team.titleLabel?.text == "0"){
            r2team.setTitle("", for: .normal)
        }
        if(b1team.titleLabel?.text == "0"){
            b1team.setTitle("", for: .normal)
        }
        if(b2team.titleLabel?.text == "0"){
            b2team.setTitle("", for: .normal)
        }
        
        
        for teams in 0..<4{
            matchData[currentMatch][teams].beacons = 0
            matchData[currentMatch][teams].NBeacons = 0
            matchData[currentMatch][teams].autoBeacons = 0
            matchData[currentMatch][teams].autoNBeacons = 0
        }
        
        
        //AUTO
        for teams in 0..<2{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].autoBType[beacons] == 1){
                    matchData[currentMatch][teams].autoBeacons += 1
                }
                if(matchData[currentMatch][teams].autoBType[beacons] == 2){
                    matchData[currentMatch][teams].autoNBeacons += 1
                }
            }
        }
        
        for teams in 2..<4{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].autoBType[beacons] == 1){
                    matchData[currentMatch][teams].autoNBeacons += 1
                }
                if(matchData[currentMatch][teams].autoBType[beacons] == 2){
                    matchData[currentMatch][teams].autoBeacons += 1
                }
            }
        }
        
        
        
        //TELE
        for teams in 0..<2{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].bType[beacons] == 1){
                    matchData[currentMatch][teams].beacons += 1
                }
                if(matchData[currentMatch][teams].bType[beacons] == 2){
                    matchData[currentMatch][teams].NBeacons += 1
                }
            }
        }
        
        for teams in 2..<4{
            for beacons in 0..<4{
                if(matchData[currentMatch][teams].bType[beacons] == 1){
                    matchData[currentMatch][teams].NBeacons += 1
                }
                if(matchData[currentMatch][teams].bType[beacons] == 2){
                    matchData[currentMatch][teams].beacons += 1
                }
            }
        }

        
        //color beacon buttons
        if(bCurrent[0] == 0) {
            r1r.backgroundColor = UIColor.gray
        }
        else if bCurrent[0] == 1 {
            r1r.backgroundColor = UIColor.red
        }
        else {
            r1r.backgroundColor = UIColor.gray
        }
        
        if(bCurrent[0] == 0) {
            r1b.backgroundColor = UIColor.gray
        }
        else if bCurrent[0] == 1 {
            r1b.backgroundColor = UIColor.gray
        }
        else {
            r1b.backgroundColor = UIColor.blue
        }
        
        if(bCurrent[1] == 0) {
            r2r.backgroundColor = UIColor.gray
        }
        else if bCurrent[1] == 1 {
            r2r.backgroundColor = UIColor.red
        }
        else {
            r2r.backgroundColor = UIColor.gray
        }
        
        if(bCurrent[1] == 0) {
            r2b.backgroundColor = UIColor.gray
        }
        else if bCurrent[1] == 1 {
            r2b.backgroundColor = UIColor.gray
        }
        else {
            r2b.backgroundColor = UIColor.blue
        }
        
        if(bCurrent[2] == 0) {
            b1r.backgroundColor = UIColor.gray
        }
        else if bCurrent[2] == 1 {
            b1r.backgroundColor = UIColor.red
        }
        else {
            b1r.backgroundColor = UIColor.gray
        }
        
        if(bCurrent[2] == 0) {
            b1b.backgroundColor = UIColor.gray
        }
        else if bCurrent[2] == 1 {
            b1b.backgroundColor = UIColor.gray
        }
        else {
            b1b.backgroundColor = UIColor.blue
        }
        
        if(bCurrent[3] == 0) {
            b2r.backgroundColor = UIColor.gray
        }
        else if bCurrent[3] == 1 {
            b2r.backgroundColor = UIColor.red
        }
        else {
            b2r.backgroundColor = UIColor.gray
        }
        
        if(bCurrent[3] == 0) {
            b2b.backgroundColor = UIColor.gray
        }
        else if bCurrent[3] == 1 {
            b2b.backgroundColor = UIColor.gray
        }
        else {
            b2b.backgroundColor = UIColor.blue
        }
        
        
        
        
        
        //Calculate and score the calculated data points
        
        
        //RED 1
        matchData[currentMatch][0].autoPts = (matchData[currentMatch][0].autoCorner * 5) + (matchData[currentMatch][0].autoVortex * 15) + matchData[currentMatch][0].parkPts + matchData[currentMatch][0].autoCapBallPts
        matchData[currentMatch][0].autoPts += matchData[currentMatch][0].autoBeacons * 30
        matchData[currentMatch][0].telePts = matchData[currentMatch][0].cornerBalls + (matchData[currentMatch][0].vortexBalls * 5)
        matchData[currentMatch][0].endGamePts = matchData[currentMatch][0].capBallPts
        matchData[currentMatch][0].endGamePts += matchData[currentMatch][0].beacons * 10
        matchData[currentMatch][0].calculatedScore = matchData[currentMatch][0].autoPts + matchData[currentMatch][0].telePts + matchData[currentMatch][0].endGamePts
        
        
        //RED 2
        matchData[currentMatch][1].autoPts = (matchData[currentMatch][1].autoCorner * 5) + (matchData[currentMatch][1].autoVortex * 15) + matchData[currentMatch][1].parkPts + matchData[currentMatch][1].autoCapBallPts
        matchData[currentMatch][1].autoPts += matchData[currentMatch][1].autoBeacons * 30
        matchData[currentMatch][1].telePts = matchData[currentMatch][1].cornerBalls + (matchData[currentMatch][1].vortexBalls * 5)
        matchData[currentMatch][1].endGamePts = matchData[currentMatch][1].capBallPts
        matchData[currentMatch][1].endGamePts += matchData[currentMatch][1].beacons * 10
        matchData[currentMatch][1].calculatedScore = matchData[currentMatch][1].autoPts + matchData[currentMatch][1].telePts + matchData[currentMatch][1].endGamePts
        
        matchData[currentMatch][0].allianceScore = matchData[currentMatch][0].calculatedScore + matchData[currentMatch][1].calculatedScore
        matchData[currentMatch][1].allianceScore = matchData[currentMatch][0].calculatedScore + matchData[currentMatch][1].calculatedScore
        
        
        //BLUE 1
        matchData[currentMatch][2].autoPts = (matchData[currentMatch][2].autoCorner * 5) + (matchData[currentMatch][2].autoVortex * 15) + matchData[currentMatch][2].parkPts + matchData[currentMatch][2].autoCapBallPts
        matchData[currentMatch][2].autoPts += matchData[currentMatch][2].autoBeacons * 30
        matchData[currentMatch][2].telePts = matchData[currentMatch][2].cornerBalls + (matchData[currentMatch][2].vortexBalls * 5)
        matchData[currentMatch][2].endGamePts = matchData[currentMatch][2].capBallPts
        matchData[currentMatch][2].endGamePts += matchData[currentMatch][2].beacons * 10
        matchData[currentMatch][2].calculatedScore = matchData[currentMatch][2].autoPts + matchData[currentMatch][2].telePts + matchData[currentMatch][2].endGamePts
        
        
        //BLUE 2
        matchData[currentMatch][3].autoPts = (matchData[currentMatch][3].autoCorner * 5) + (matchData[currentMatch][3].autoVortex * 15) + matchData[currentMatch][3].parkPts + matchData[currentMatch][3].autoCapBallPts
        matchData[currentMatch][3].autoPts += matchData[currentMatch][3].autoBeacons * 30
        matchData[currentMatch][3].telePts = matchData[currentMatch][3].cornerBalls + (matchData[currentMatch][3].vortexBalls * 5)
        matchData[currentMatch][3].endGamePts = matchData[currentMatch][3].capBallPts
        matchData[currentMatch][3].endGamePts += matchData[currentMatch][3].beacons * 10
        matchData[currentMatch][3].calculatedScore = matchData[currentMatch][3].autoPts + matchData[currentMatch][3].telePts + matchData[currentMatch][3].endGamePts
        
        matchData[currentMatch][2].allianceScore = matchData[currentMatch][2].calculatedScore + matchData[currentMatch][3].calculatedScore
        matchData[currentMatch][3].allianceScore = matchData[currentMatch][2].calculatedScore + matchData[currentMatch][3].calculatedScore
        
        
        
        //Check if beacons were scored for the other teams
        matchData[currentMatch][0].allianceScore += (matchData[currentMatch][2].autoNBeacons * 30)
        matchData[currentMatch][1].allianceScore += (matchData[currentMatch][2].autoNBeacons * 30)
        matchData[currentMatch][0].allianceScore += (matchData[currentMatch][3].autoNBeacons * 30)
        matchData[currentMatch][1].allianceScore += (matchData[currentMatch][3].autoNBeacons * 30)
        matchData[currentMatch][2].allianceScore += (matchData[currentMatch][0].autoNBeacons * 30)
        matchData[currentMatch][3].allianceScore += (matchData[currentMatch][0].autoNBeacons * 30)
        matchData[currentMatch][2].allianceScore += (matchData[currentMatch][1].autoNBeacons * 30)
        matchData[currentMatch][3].allianceScore += (matchData[currentMatch][1].autoNBeacons * 30)
        
        //Tele
        matchData[currentMatch][0].allianceScore += (matchData[currentMatch][2].NBeacons * 10)
        matchData[currentMatch][1].allianceScore += (matchData[currentMatch][2].NBeacons * 10)
        matchData[currentMatch][0].allianceScore += (matchData[currentMatch][3].NBeacons * 10)
        matchData[currentMatch][1].allianceScore += (matchData[currentMatch][3].NBeacons * 10)
        matchData[currentMatch][2].allianceScore += (matchData[currentMatch][0].NBeacons * 10)
        matchData[currentMatch][3].allianceScore += (matchData[currentMatch][0].NBeacons * 10)
        matchData[currentMatch][2].allianceScore += (matchData[currentMatch][1].NBeacons * 10)
        matchData[currentMatch][3].allianceScore += (matchData[currentMatch][1].NBeacons * 10)

        //CALCULATE WIN/LOSS
        calculateOutcome(forMatch: currentMatch)
        
        //MATCH LABEL
        matchLabel.text = "Match \(getMatchLabel(index: currentMatch))"
        
        
        //RED 1
        if(r1numValid){
            if(matchData[currentMatch][0].number != 0){
                r1TNumField.text = String(matchData[currentMatch][0].number)
                r1NameField.text = teamList[r1TNumField.text!]?.name
            }
            else {
                r1TNumField.text = ""
            }
        }
        
        r1TCenter.text = String(matchData[currentMatch][0].vortexBalls)
        r1TCorner.text = String(matchData[currentMatch][0].cornerBalls)
        r1TCapPts.text = String(matchData[currentMatch][0].capBallPts)
        r1TCapDNA.setOn(matchData[currentMatch][0].capBallDNA, animated: false)
        
        //RED 2
        if(r2numValid){
            if(matchData[currentMatch][1].number != 0){
                r2TNumField.text = String(matchData[currentMatch][1].number)
                r2NameField.text = teamList[r2TNumField.text!]?.name
            }
            else {
                r2TNumField.text = ""
            }
        }
        r2TCenter.text = String(matchData[currentMatch][1].vortexBalls)
        r2TCorner.text = String(matchData[currentMatch][1].cornerBalls)
        r2TCapPts.text = String(matchData[currentMatch][1].capBallPts)
        r2TCapDNA.setOn(matchData[currentMatch][1].capBallDNA, animated: false)
        
        //BLUE 1
        if(b1numValid){
            if(matchData[currentMatch][2].number != 0){
                b1TNumField.text = String(matchData[currentMatch][2].number)
                b1NameField.text = teamList[b1TNumField.text!]?.name
            }
            else {
                b1TNumField.text = ""
            }
        }
        b1TCenter.text = String(matchData[currentMatch][2].vortexBalls)
        b1TCorner.text = String(matchData[currentMatch][2].cornerBalls)
        b1TCapPts.text = String(matchData[currentMatch][2].capBallPts)
        b1TCapDNA.setOn(matchData[currentMatch][2].capBallDNA, animated: false)
        
        //BLUE 2
        if(b2numValid){
            if(matchData[currentMatch][3].number != 0){
                b2TNumField.text = String(matchData[currentMatch][3].number)
                b2NameField.text = teamList[b2TNumField.text!]?.name
            }
            else {
                b2TNumField.text = ""
            }
        }
        b2TCenter.text = String(matchData[currentMatch][3].vortexBalls)
        b2TCorner.text = String(matchData[currentMatch][3].cornerBalls)
        b2TCapPts.text = String(matchData[currentMatch][3].capBallPts)
        b2TCapDNA.setOn(matchData[currentMatch][3].capBallDNA, animated: false)
        

        
        
        redAllianceScore.text = String(matchData[currentMatch][0].allianceScore)
        blueAllianceScore.text = String(matchData[currentMatch][2].allianceScore)
        
        
        r1TScore.text = String(matchData[currentMatch][0].telePts + matchData[currentMatch][0].endGamePts)
        r1TMatchScore.text = String(matchData[currentMatch][0].calculatedScore)
        r2TScore.text = String(matchData[currentMatch][1].telePts + matchData[currentMatch][1].endGamePts)
        r2TMatchScore.text = String(matchData[currentMatch][1].calculatedScore)
        redAllianceScore.text = String(matchData[currentMatch][0].allianceScore)
        
        b1TScore.text = String(matchData[currentMatch][2].telePts + matchData[currentMatch][2].endGamePts)
        b1TMatchScore.text = String(matchData[currentMatch][2].calculatedScore)
        b2TScore.text = String(matchData[currentMatch][3].telePts + matchData[currentMatch][3].endGamePts)
        b2TMatchScore.text = String(matchData[currentMatch][3].calculatedScore)
        blueAllianceScore.text = String(matchData[currentMatch][3].allianceScore)
        
        
    }
    
    
    //RED 1
    @IBAction func r1TCenterBallsPlus(_ sender: AnyObject) {
       
        matchData[currentMatch][0].vortexBalls += 1
        refreshLabels()
    
    }
    @IBAction func r1TCenterBallsMinus(_ sender: AnyObject) {
        if matchData[currentMatch][0].vortexBalls - 1 >= 0{
            matchData[currentMatch][0].vortexBalls -= 1
            refreshLabels()
        }

    }
    @IBAction func r1TCornerBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][0].cornerBalls += 1
        refreshLabels()
    }
    @IBAction func r1TCornerBallsMinus(_ sender: AnyObject) {
        if matchData[currentMatch][0].cornerBalls - 1 >= 0{
            matchData[currentMatch][0].cornerBalls -= 1
            refreshLabels()
        }
    }
    @IBAction func r1TBeaconsPlus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][0].beacons += 1
        }
        else if matchData[currentMatch][0].beacons < 0 {
            matchData[currentMatch][0].beacons += 1
        }
        refreshLabels()
    }
    @IBAction func r1TBeaconsMinus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][0].beacons -= 1
        }
        else if matchData[currentMatch][0].beacons > 0 {
            matchData[currentMatch][0].beacons -= 1
        }
        refreshLabels()
    }
    @IBAction func r1TCapBallPtsPlus(_ sender: AnyObject) {
        switch (matchData[currentMatch][0].capBallPts){
        case 0:
            matchData[currentMatch][0].capBallPts = 10
        case 10:
            matchData[currentMatch][0].capBallPts = 20
        case 20:
            matchData[currentMatch][0].capBallPts = 40
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func r1CapBallPtsMinus(_ sender: AnyObject) {
        switch (matchData[currentMatch][0].capBallPts){
        case 40:
            matchData[currentMatch][0].capBallPts = 20
        case 10:
            matchData[currentMatch][0].capBallPts = 0
        case 20:
            matchData[currentMatch][0].capBallPts = 10
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func r1TCapBallDNA(_ sender: AnyObject) {
        matchData[currentMatch][0].capBallDNA = r1TCapDNA.isOn
        refreshLabels()

    }
    
    
    //RED 2
    @IBAction func r2TCenterBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][1].vortexBalls += 1
        refreshLabels()
    }
    @IBAction func r2TCenterBallsMinus(_ sender: AnyObject) {
        if matchData[currentMatch][1].vortexBalls - 1 >= 0{
            matchData[currentMatch][1].vortexBalls -= 1
            refreshLabels()
        }
    }
    @IBAction func r2TCornerBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][1].cornerBalls += 1
        refreshLabels()
    }
    @IBAction func r2TCornerBallsMinus(_ sender: AnyObject) {
        if matchData[currentMatch][1].cornerBalls - 1 >= 0{
            matchData[currentMatch][1].cornerBalls -= 1
            refreshLabels()
        }
    }
    @IBAction func r2TBeaconsPlus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][1].beacons += 1
        }
        else if matchData[currentMatch][1].beacons < 0 {
            matchData[currentMatch][1].beacons += 1
        }
        refreshLabels()
    }
    @IBAction func r2TBeaconsMinus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][1].beacons -= 1
        }
        else if matchData[currentMatch][1].beacons > 0 {
            matchData[currentMatch][1].beacons -= 1
        }
        refreshLabels()
    }
    @IBAction func r2TCapBallPtsPlus(_ sender: AnyObject) {
        switch (matchData[currentMatch][1].capBallPts){
        case 0:
            matchData[currentMatch][1].capBallPts = 10
        case 10:
            matchData[currentMatch][1].capBallPts = 20
        case 20:
            matchData[currentMatch][1].capBallPts = 40
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func r2TCapBallPtsMinus(_ sender: AnyObject) {
        switch (matchData[currentMatch][1].capBallPts){
        case 40:
            matchData[currentMatch][1].capBallPts = 20
        case 10:
            matchData[currentMatch][1].capBallPts = 0
        case 20:
            matchData[currentMatch][1].capBallPts = 10
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func r2TCapBallDNA(_ sender: AnyObject) {
        matchData[currentMatch][1].capBallDNA = r1TCapDNA.isOn
        refreshLabels()
    }
    
    
    //BLUE 1
    @IBAction func b1TCenterBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][2].vortexBalls += 1
        refreshLabels()
    }
    @IBAction func b1TCenterBallsMinus(_ sender: AnyObject) {
        if(matchData[currentMatch][2].vortexBalls != 0){
            matchData[currentMatch][2].vortexBalls -= 1
        }
        refreshLabels()
    }
    @IBAction func b1TCornerBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][2].cornerBalls += 1
        refreshLabels()
    }
    @IBAction func b1TCornerBallsMinus(_ sender: AnyObject) {
        if(matchData[currentMatch][2].cornerBalls != 0){
            matchData[currentMatch][2].cornerBalls -= 1
        }
        refreshLabels()
    }
    @IBAction func b1TBeaconsPlus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][2].beacons += 1
        }
        else if matchData[currentMatch][2].beacons < 0 {
            matchData[currentMatch][2].beacons += 1
        }
        refreshLabels()
    }
    @IBAction func b1TBeaconsMinus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][2].beacons -= 1
        }
        else if matchData[currentMatch][2].beacons > 0 {
            matchData[currentMatch][2].beacons -= 1
        }
        refreshLabels()
    }
    @IBAction func b1TCapBallPtsPlus(_ sender: AnyObject) {
        switch (matchData[currentMatch][2].capBallPts){
        case 0:
            matchData[currentMatch][2].capBallPts = 10
        case 10:
            matchData[currentMatch][2].capBallPts = 20
        case 20:
            matchData[currentMatch][2].capBallPts = 40
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func b1TCapBallPtsMinus(_ sender: AnyObject) {
        switch (matchData[currentMatch][2].capBallPts){
        case 40:
            matchData[currentMatch][2].capBallPts = 20
        case 10:
            matchData[currentMatch][2].capBallPts = 0
        case 20:
            matchData[currentMatch][2].capBallPts = 10
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func b1TCapBallDNA(_ sender: AnyObject) {
        matchData[currentMatch][2].capBallDNA = r1TCapDNA.isOn
        refreshLabels()
    }
    
    
    //BLUE 2
    @IBAction func b2TCenterBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][3].vortexBalls += 1
        refreshLabels()
    }
    @IBAction func b2TCenterBallsMinus(_ sender: AnyObject) {
        if(matchData[currentMatch][3].vortexBalls != 0){
            matchData[currentMatch][3].vortexBalls -= 1
        }
        refreshLabels()
    }
    @IBAction func b2TCornerBallsPlus(_ sender: AnyObject) {
        matchData[currentMatch][3].cornerBalls += 1
        refreshLabels()
    }
    @IBAction func b2TCornerBallsMinus(_ sender: AnyObject) {
        if(matchData[currentMatch][3].cornerBalls != 0){
            matchData[currentMatch][3].cornerBalls -= 1
        }
        refreshLabels()
    }
    @IBAction func b2TBeaconsPlus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][3].beacons += 1
        }
        else if matchData[currentMatch][3].beacons < 0 {
            matchData[currentMatch][3].beacons += 1
        }
        refreshLabels()
    }
    @IBAction func b2TBeaconsMinus(_ sender: AnyObject) {
        if((absn(matchData[currentMatch][2].beacons) + absn(matchData[currentMatch][3].beacons) + absn(matchData[currentMatch][0].beacons) + absn(matchData[currentMatch][1].beacons)) < 4){
            matchData[currentMatch][3].beacons -= 1
        }
        else if matchData[currentMatch][3].beacons > 0 {
            matchData[currentMatch][3].beacons -= 1
        }
        refreshLabels()
    }
    @IBAction func b2TCapBallPtsPlus(_ sender: AnyObject) {
        switch (matchData[currentMatch][3].capBallPts){
        case 0:
            matchData[currentMatch][3].capBallPts = 10
        case 10:
            matchData[currentMatch][3].capBallPts = 20
        case 20:
            matchData[currentMatch][3].capBallPts = 40
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func b2TCapBallPtsMinus(_ sender: AnyObject) {
        switch (matchData[currentMatch][3].capBallPts){
        case 40:
            matchData[currentMatch][3].capBallPts = 20
        case 10:
            matchData[currentMatch][3].capBallPts = 0
        case 20:
            matchData[currentMatch][3].capBallPts = 10
        default:
            break
        }
        refreshLabels()
    }
    @IBAction func b2TCapBallDNA(_ sender: AnyObject) {
        matchData[currentMatch][3].capBallDNA = r1TCapDNA.isOn
        refreshLabels()
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        refreshLabels()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
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
