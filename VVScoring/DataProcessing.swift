//
//  newProc.swift
//  NBNP2Scoring
//
//  Created by Tom Clark on 11/2/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import Foundation

struct teamInMatch{
    var number: Int = 0 //Team number
    var match: Int = 0
    /*  Match number for qualification match                ex. qualification match 45 = 45
     *  1000 plus match number for semifinal match          ex. semifinal match 2-3 = 1023
     *  10000 plus match number for division final match    ex. final match 1 = 10001
     *  100000 plus match number for final match            ex. interdivision final match 2 = 100002
    */
    var autoCorner: Int = 0 //amount
    var autoVortex: Int = 0 //amount
    var autoBeacons: Int = 0 //amount
    var autoNBeacons: Int = 0 //amount
    var autoBType: [Int] = [0,0,0,0] //which beacon
    var autoBeaconsDNA: Bool = false
    var parkPts: Int = 0 //points
    var autoCapBallPts: Int = 0 //points
    var autoCapBallDNA: Bool = false
    var autoPts: Int = 0 //points
    var cornerBalls: Int = 0 // amount
    var vortexBalls: Int = 0 //amount
    var telePts: Int = 0 //points
    var capBallPts: Int = 0 //points
    var capBallDNA: Bool = false
    var beacons: Int = 0 //amount
    var NBeacons: Int = 0 //amount
    var bType: [Int] = [0,0,0,0] //which beacon
    /*
        0,0,0,0: nothing
        1,1,1,1: all red
        2,2,2,2: all blue
    */
    var bCount: Int = 0 //total claims
    var endGamePts: Int = 0 //points
    var outcome: Int = 0 //Win 0, loss 1, tie 2
    var calculatedScore: Int = 0 //OPR points
    var allianceScore: Int = -1
    var officialScore: Int = -1
}

struct teamAverage{
    var number: Int = 0
    var autoCorner: Double = 0.0
    var autoVortex: Double = 0.0
    var autoCapBallPts: Double = 0.0
    var autoBeacons: Double = 0.0
    var parkPts: Double = 0.0
    var autoPts: Double = 0.0
    var cornerBalls: Double = 0.0
    var vortexBalls: Double = 0.0
    var telePts: Double = 0.0
    var capBallPts: Double = 0.0
    var beacons: Double = 0.0
    var totalBeacons: Double = 0.0
    var endGamePts: Double = 0.0
    var opr: Double = 0.0
    var allianceScore: Double = 0.0
    var opposingScore: Double = 0.0
    var officialScore: Double = 0.0
    var QP: Int = 0
    var RP: Int = 0
    var W: Int = 0
    var L: Int = 0
    var T: Int = 0
}

var teamList: [String : (name: String, fav: Bool)] = [:]

var matchData: [[teamInMatch]] = []

struct tournament{
    var name: String = "nil"
    var type: String = "nil"
    var date: String = "nil"
    var fileLocation: String = "nil"
}

var tournamentList: [tournament] = []

var selectedTeam: Int = -1

func sortMatchData(){
    matchData = matchData.sorted{ $0[0].match < $1[0].match }
}

func getMatchLabel(index: Int) -> String {
    if matchData[index][0].match < 1010 {
        return "Q\(matchData[index][0].match + 1)"
    }
    if matchData[index][0].match < 1020 {
        return "S1-\(matchData[index][0].match - 1009)"
    }
    if matchData[index][0].match < 1030 {
        return "S2-\(matchData[index][0].match - 1019)"
    }
    if matchData[index][0].match < 1040 {
        return "F\(matchData[index][0].match - 1029)"
    }
    else {
        return "C\(matchData[index][0].match - 1039)"
    }
    
}

func getRank(num: Int) -> Int {
    var rank = -1
    var sorted: [teamAverage] = []
    var teamAverages: [teamAverage] = []
    
    for (number, _) in teamList {
        teamAverages.append(getAverages(num: Int(number)!))
    }
    
    sorted = teamAverages.sorted{
        if $0.QP != $1.QP{
            return $0.QP > $1.QP
        }
        else if $0.RP != $1.RP {
            return $0.RP > $1.RP
        }
        else{
            return $0.opr > $1.opr
        }
    }
    
    for i in 0..<sorted.count {
        if(sorted[i].number == num){
            rank = i + 1
            break
        }
    }
    
    return rank
}

func sortTeamsBy(mode: String, dir: Int) -> [teamAverage]{
    //dir: Int is the sorting direction (increasing/decreasing) inc is 1, dec is 0
    //Output array
    var output: [teamAverage] = []
    
    //Check for extraneous values in the direction parameter
    if dir > 1 || dir < 0{
        print("Can't find direction in data process")
        return output
    }
    
    //Averages from all teams
    var teamAverages: [teamAverage] = []
    
    //Stores all averages based on all teams in list
    for (number, _) in teamList {
        teamAverages.append(getAverages(num: Int(number)!))
    }
    
    //Check mode to sort by
    switch(mode){
    case "W":
        if(dir == 0){
            output = teamAverages.sorted{
                if $0.W != $1.W{
                    return $0.W > $1.W
                }
                else if $0.T != $1.T {
                    return $0.T > $1.T
                }
                else{
                    return $0.L < $1.L
                }
            }
        }else{
            output = teamAverages.sorted{
                if $0.W != $1.W{
                    return $0.W < $1.W
                }
                else if $0.T != $1.T {
                    return $0.T < $1.T
                }
                else{
                    return $0.L > $1.L
                }
            }

    }
    case "L":
        if(dir == 0){
            output = teamAverages.sorted{ $0.L < $1.L }
        }else{
            output = teamAverages.sorted{ $0.L > $1.L }
        }
    case "T":
        if(dir == 0){
            output = teamAverages.sorted{ $0.T < $1.T }
        }else{
            output = teamAverages.sorted{ $0.T > $1.T }
        }
    case "autoCorner":
        if(dir == 0){
            output = teamAverages.sorted{ $0.autoCorner < $1.autoCorner }
        }else{
            output = teamAverages.sorted{ $0.autoCorner > $1.autoCorner }
        }
    case "capPts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.capBallPts < $1.capBallPts }
        }else{
            output = teamAverages.sorted{ $0.capBallPts > $1.capBallPts }
        }
    case "autoVortex":
        if(dir == 0){
            output = teamAverages.sorted{ $0.autoVortex < $1.autoVortex }
        }else{
            output = teamAverages.sorted{ $0.autoVortex > $1.autoVortex }
        }
    case "luck":
        if(dir == 0){
            output = teamAverages.sorted{ $0.allianceScore - $0.opr < $1.allianceScore - $1.opr }
        }else{
            output = teamAverages.sorted{ $0.allianceScore - $0.opr > $1.allianceScore - $1.opr }
        }
    case "autoBeacons":
        if(dir == 0){
            output = teamAverages.sorted{ $0.autoBeacons < $1.autoBeacons }
        }else{
            output = teamAverages.sorted{ $0.autoBeacons > $1.autoBeacons }
        }
        
    case "parkPts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.parkPts < $1.parkPts }
        }else{
            output = teamAverages.sorted{ $0.parkPts > $1.parkPts }
        }
        
    case "autoCapBallPts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.autoCapBallPts < $1.autoCapBallPts }
        }else{
            output = teamAverages.sorted{ $0.autoCapBallPts > $1.autoCapBallPts }
        }
        
    case "autoPts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.autoPts < $1.autoPts }
        }else{
            output = teamAverages.sorted{ $0.autoPts > $1.autoPts }
        }
        
    case "cornerBalls":
        if(dir == 0){
            output = teamAverages.sorted{ $0.cornerBalls < $1.cornerBalls }
        }else{
            output = teamAverages.sorted{ $0.cornerBalls > $1.cornerBalls }
        }
        
    case "vortexBalls":
        if(dir == 0){
            output = teamAverages.sorted{ $0.vortexBalls < $1.vortexBalls }
        }else{
            output = teamAverages.sorted{ $0.vortexBalls > $1.vortexBalls }
        }
        
    case "telePts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.telePts < $1.telePts }
        }else{
            output = teamAverages.sorted{ $0.telePts > $1.telePts }
        }
        
    case "capBallPts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.capBallPts < $1.capBallPts }
        }else{
            output = teamAverages.sorted{ $0.capBallPts > $1.capBallPts }
        }
        
    case "beacons":
        if(dir == 0){
            output = teamAverages.sorted{ $0.beacons < $1.beacons }
        }else{
            output = teamAverages.sorted{ $0.beacons > $1.beacons }
        }
        
    case "endGamePts":
        if(dir == 0){
            output = teamAverages.sorted{ $0.endGamePts < $1.endGamePts }
        }else{
            output = teamAverages.sorted{ $0.endGamePts > $1.endGamePts }
        }
        
    case "opr":
        if(dir == 0){
            output = teamAverages.sorted{ $0.opr < $1.opr }
        }else{
            output = teamAverages.sorted{ $0.opr > $1.opr }
        }
    default:
        //Sort by rank
        if(dir == 0){
            output = teamAverages.sorted{
                if $0.QP != $1.QP{
                    return $0.QP > $1.QP
                }
                else if $0.RP != $1.RP {
                    return $0.RP > $1.RP
                }
                else{
                    return $0.opr > $1.opr
                }
            }
        }
        else{
            output = teamAverages.sorted{
                if $0.QP != $1.QP{
                return $0.QP < $1.QP
            }
                else if $0.RP != $1.RP {
                    return $0.RP < $1.RP
                }
                else{
                    return $0.opr < $1.opr
                }
            }
        }
    }
    
    
    
    //Return sorted averages array
    return output
}


func compareTeams(num1: Int, num2: Int) -> (team1Averages: teamAverage, team2Averages: teamAverage, compare: [Int])
{
    let team1Averages = getAverages(num: num1)
    let team2Averages = getAverages(num: num2)
    var compare: [Int] = []                          // 0=team1 greater  1=team2 greater     2=equal or close
    if(abs(team1Averages.allianceScore - team2Averages.allianceScore) <= 10){
        compare.append(2)
    }
    else{
        if(team1Averages.allianceScore < team2Averages.allianceScore){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.autoBeacons - team2Averages.autoBeacons) <= 0.2){
        compare.append(2)
    }
    else{
        if(team1Averages.autoBeacons < team2Averages.autoBeacons){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.autoCapBallPts - team2Averages.autoCapBallPts) <= 5){
        compare.append(2)
    }
    else{
        if(team1Averages.autoCapBallPts < team2Averages.autoCapBallPts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.autoCorner - team2Averages.autoCorner) <= 0.5){
        compare.append(2)
    }
    else{
        if(team1Averages.autoCorner < team2Averages.autoCorner){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.autoPts - team2Averages.autoPts) <= 5){
        compare.append(2)
    }
    else{
        if(team1Averages.autoPts < team2Averages.autoPts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.autoVortex - team2Averages.autoVortex) <= 0.5){
        compare.append(2)
    }
    else{
        if(team1Averages.autoVortex < team2Averages.autoVortex){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.beacons - team2Averages.beacons) <= 0.5){
        compare.append(2)
    }
    else{
        if(team1Averages.beacons < team2Averages.beacons){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.capBallPts - team2Averages.capBallPts) <= 5){
        compare.append(2)
    }
    else{
        if(team1Averages.capBallPts < team2Averages.capBallPts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.cornerBalls - team2Averages.cornerBalls) <= 1){
        compare.append(2)
    }
    else{
        if(team1Averages.cornerBalls < team2Averages.cornerBalls){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.endGamePts - team2Averages.endGamePts) <= 5){
        compare.append(2)
    }
    else{
        if(team1Averages.endGamePts < team2Averages.endGamePts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.opr - team2Averages.opr) <= 3){
        compare.append(2)
    }
    else{
        if(team1Averages.opr < team2Averages.opr){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.parkPts - team2Averages.parkPts) <= 2){
        compare.append(2)
    }
    else{
        if(team1Averages.parkPts < team2Averages.parkPts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.telePts - team2Averages.telePts) <= 5){
        compare.append(2)
    }
    else{
        if(team1Averages.telePts < team2Averages.telePts){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.vortexBalls - team2Averages.vortexBalls) <= 1){
        compare.append(2)
    }
    else{
        if(team1Averages.vortexBalls < team2Averages.vortexBalls){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    if(abs(team1Averages.totalBeacons - team2Averages.totalBeacons) <= 0.5){
        compare.append(2)
    }
    else{
        if(team1Averages.totalBeacons < team2Averages.totalBeacons){
            compare.append(1)
        }
        else{
            compare.append(0)
        }
    }
    
    return (team1Averages, team2Averages, compare)
}


func getMatches(num: Int) -> [teamInMatch]{
    var output: [teamInMatch] = []
    for match in matchData{
        for team in match{
            if team.number == num{
                output.append(team)
            }
        }
    }
    return output
}


func getAverages(num: Int) -> teamAverage{
    var output = teamAverage()
    var matchAmount = 0.0
    var officialMatchAmount = 0.0
    
    for match in matchData{
        for team in match{
            if team.number == num{
                matchAmount += 1
                
                output.autoCorner += Double(team.autoCorner)
                output.autoVortex += Double(team.autoVortex)
                if(!team.autoCapBallDNA){
                    output.autoCapBallPts += Double(team.autoCapBallPts)
                }
                if(!team.autoBeaconsDNA){
                    output.autoBeacons += Double(team.autoBeacons)
                }
                output.parkPts += Double(team.parkPts)
                output.autoPts += Double(team.autoPts)
                output.cornerBalls += Double(team.cornerBalls)
                output.vortexBalls += Double(team.vortexBalls)
                output.telePts += Double(team.telePts)
                if(!team.capBallDNA){
                    output.capBallPts += Double(team.capBallPts)
                }
                output.beacons += Double(team.beacons)
                output.totalBeacons += Double(team.bCount)
                output.endGamePts += Double(team.endGamePts)
                output.allianceScore += Double(team.allianceScore)
                output.opr += Double(team.calculatedScore)
                if(team.officialScore != -1){
                    output.officialScore += Double (team.officialScore)
                    officialMatchAmount += 1
                }
                
                //Outcome
                switch(team.outcome){
                case 0:
                    output.W += 1
                    output.QP += 2
                case 1:
                    output.L += 1
                case 2:
                    output.T += 1
                    output.QP += 1
                default:
                    print("Error in data process: Outcome is not desired")
                }
            }
        }
    }
    
    //Calculate RP
    for x in 0..<matchData.count{
        for i in 0..<4{
            if matchData[x][i].number == num {
                if (i == 0)||(i == 1){
                    if matchData[x][i].outcome == 0 {
                        output.RP += matchData[x][2].allianceScore
                    }
                    else{
                        output.RP += matchData[x][0].allianceScore
                    }
                    output.opposingScore += Double (matchData[x][2].allianceScore)
                }
                else{
                    if matchData[x][i].outcome == 0 {
                        output.RP += matchData[x][0].allianceScore
                    }
                    else{
                        output.RP += matchData[x][2].allianceScore
                    }
                    output.opposingScore += Double (matchData[x][0].allianceScore)
                }

            }
        }
    }
    
    output.number = num
    output.autoCorner /= matchAmount
    output.autoVortex /= matchAmount
    output.autoBeacons /= matchAmount
    output.parkPts /= matchAmount
    output.autoPts /= matchAmount
    output.cornerBalls /= matchAmount
    output.vortexBalls /= matchAmount
    output.telePts /= matchAmount
    output.capBallPts /= matchAmount
    output.beacons /= matchAmount
    output.totalBeacons /= matchAmount
    output.endGamePts /= matchAmount
    output.allianceScore /= matchAmount
    output.opr /= matchAmount
    if(output.officialScore != 0){
        output.officialScore /= officialMatchAmount
    }
    output.opposingScore /= matchAmount
    
    return output
}

func calculateOutcome(forMatch number: Int){
    if(matchData[number][0].officialScore == -1){
        if(matchData[number][0].allianceScore > matchData[number][2].allianceScore){
            matchData[number][0].outcome = 0
            matchData[number][1].outcome = 0
            matchData[number][2].outcome = 1
            matchData[number][3].outcome = 1
        }
        else if(matchData[number][0].allianceScore < matchData[number][2].allianceScore){
            matchData[number][0].outcome = 1
            matchData[number][1].outcome = 1
            matchData[number][2].outcome = 0
            matchData[number][3].outcome = 0
        }
        else{
            matchData[number][0].outcome = 2
            matchData[number][1].outcome = 2
            matchData[number][2].outcome = 2
            matchData[number][3].outcome = 2
        }
    }else{
        if(matchData[number][0].officialScore > matchData[currentMatch][2].officialScore){
            matchData[number][0].outcome = 0
            matchData[number][1].outcome = 0
            matchData[number][2].outcome = 1
            matchData[number][3].outcome = 1
        }
        else if(matchData[number][0].officialScore < matchData[number][2].officialScore){
            matchData[number][0].outcome = 1
            matchData[number][1].outcome = 1
            matchData[number][2].outcome = 0
            matchData[number][3].outcome = 0
        }
        else{
            matchData[number][0].outcome = 2
            matchData[number][1].outcome = 2
            matchData[number][2].outcome = 2
            matchData[number][3].outcome = 2
        }
    }
}
