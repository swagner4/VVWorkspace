//
//  FileUtility.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 12/9/16.
//  Copyright © 2016 Q Is Silqent. All rights reserved.
//

import Foundation


//Definitions
let matchHeader: String = "number0, match0, autoCorner0, autoVortex0, autoBeacons0, autoBeaconsDNA0, parkPts0, autoCapBallPts0, autoCapBallDNA0, autoPts0, cornerBalls0, vortexBalls0, telePts0, capBallPts0, capBallDNA0, beacons0, endGamePts0, outcome0, calculatedScore0, allianceScore0, officialScore0 | number1, match1, autoCorner1, autoVortex1, autoBeacons1, autoBeaconsDNA1, parkPts1, autoCapBallPts1, autoCapBallDNA1, autoPts1, cornerBalls1, vortexBalls1, telePts1, capBallPts1, capBallDNA1, beacons1, endGamePts1, outcome1, calculatedScore1, allianceScore1, officialScore1 | number2, match2, autoCorner2, autoVortex2, autoBeacons2, autoBeaconsDNA2, parkPts2, autoCapBallPts2, autoCapBallDNA2, autoPts2, cornerBalls2, vortexBalls2, telePts2, capBallPts2, capBallDNA2, beacons2, endGamePts2, outcome2, calculatedScore2, allianceScore2, officialScore2 | number3, match3, autoCorner3, autoVortex3, autoBeacons3, autoBeaconsDNA3, parkPts3, autoCapBallPts3, autoCapBallDNA3, autoPts3, cornerBalls3, vortexBalls3, telePts3, capBallPts3, capBallDNA3, beacons3, endGamePts3, outcome3, calculatedScore3, allianceScore3, officialScore3"
let tournamentHeader: String = "Name,Type,Date,FileLocation"

var currentTournament: String = ""

let docsPath = NSSearchPathForDirectoriesInDomains(
    FileManager.SearchPathDirectory.documentDirectory,
    FileManager.SearchPathDomainMask.userDomainMask,
    true)[0] as NSString

//MATCH DATA

//Reads match data from the given file name and returns error status
func readMatchDataFromFile(fileName: String) -> Bool{
    //let path = Bundle.main.path(forResource: file, ofType: "txt")
    let path = docsPath.appendingPathComponent("\(fileName).txt")
    let fm = FileManager.default
    
    print("\nReading match data from: \(path)\n")
    
    if fm.fileExists(atPath: path){
        do{
            let fullText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            print("\nfullText for matchData: \n\(fullText)-ENDOFFILE-")
            let lines = fullText.components(separatedBy: "\n") as [String]
            
            //Get team list
            teamList = [:]
            let teamInfo = lines[1].components(separatedBy: ",")
            if(teamInfo.count % 3 == 0){
                for f in stride(from: 0, through: teamInfo.count-1, by: 3) {
                    teamList[teamInfo[f]] = (name: teamInfo[f+1], fav: Bool(teamInfo[f+2])!)
                    //print(teamList[teamInfo[f]])
                }
            }
            
            //Get match data
            matchData = []
            var i = 0
            for k in 2..<lines.count{
                if lines[k] != ""{
                    let data = lines[k].components(separatedBy: ",")
                    var tmp = 0
                    matchData.append([teamInMatch(),teamInMatch(),teamInMatch(),teamInMatch()])
                    for j in 0..<4{
                        matchData[i][j].number = Int(data[tmp+0])!
                        matchData[i][j].match = Int(data[tmp+1])!
                        matchData[i][j].autoCorner = Int(data[tmp+2])!
                        matchData[i][j].autoVortex = Int(data[tmp+3])!
                        matchData[i][j].autoBeacons = Int(data[tmp+4])!
                        
                        matchData[i][j].autoNBeacons = Int(data[tmp+5])!
                        matchData[i][j].autoBType = getTypeIntArray(data[tmp+6])
                        
                        matchData[i][j].autoBeaconsDNA = Bool(data[tmp+7])!
                        matchData[i][j].parkPts = Int(data[tmp+8])!
                        matchData[i][j].autoCapBallPts = Int(data[tmp+9])!
                        matchData[i][j].autoCapBallDNA = Bool(data[tmp+10])!
                        matchData[i][j].autoPts = Int(data[tmp+11])!
                        matchData[i][j].cornerBalls = Int(data[tmp+12])!
                        matchData[i][j].vortexBalls = Int(data[tmp+13])!
                        matchData[i][j].telePts = Int(data[tmp+14])!
                        matchData[i][j].capBallPts = Int(data[tmp+15])!
                        matchData[i][j].capBallDNA = Bool(data[tmp+16])!
                        matchData[i][j].beacons = Int(data[tmp+17])!
                        
                        matchData[i][j].NBeacons = Int(data[tmp+18])!
                        matchData[i][j].bType = getTypeIntArray(data[tmp+19])
                        matchData[i][j].bCount = Int(data[tmp+20])!
                        
                        matchData[i][j].endGamePts = Int(data[tmp+21])!
                        matchData[i][j].outcome = Int(data[tmp+22])!
                        matchData[i][j].calculatedScore = Int(data[tmp+23])!
                        matchData[i][j].allianceScore = Int(data[tmp+24])!
                        matchData[i][j].officialScore = Int(data[tmp+25])!
                        tmp += 26
                    }
                    i += 1
                }
            }
            return true
        }catch{
            return false
        }
    }
    else{
        return false
    }
}

func setupInitialUtilityFiles(refresh: Bool){
    let fm = FileManager.default
    
    //Refresh tournament file
    if refresh{
        //Get paths and check if file already exists
        let oldTpath = Bundle.main.path(forResource: "tournaments", ofType: "txt")!
        let tPath = docsPath.appendingPathComponent("tournaments.txt")
        let tExist = fm.fileExists(atPath: tPath)
        
        print("Refreshing tournament file\n")
        
        do{
            //Remove old file
            if tExist{
                print("Removing old tournament file...")
                do{
                    try fm.removeItem(atPath: tPath)
                }catch{
                    print("\nError removing item!\n")
                }
            }
            
            //Get contents of old file
            let fullText = try String(contentsOfFile: oldTpath, encoding: String.Encoding.utf8)
            let length = fullText.characters.count
            let newText = fullText.substring(0, end: length - 2)
            
            print("Using fullText: \(newText)")
            
            //Create new file with copied contents
            fm.createFile(atPath: tPath, contents: newText.data(using: .utf8), attributes: nil)
        }catch{
            print("(Tournament) Error in copying file to \(tPath)\n")
        }
    }else{
        print("Not refreshing tournament file\n")
    }
    
    //-Match File-
    //Get paths to files and check if file already exists
    let mPath = docsPath.appendingPathComponent("example.txt")
    let oldMpath = Bundle.main.path(forResource: "example", ofType: "txt")!
    let mExist = fm.fileExists(atPath: mPath)
    
    //Print whether the file exists
    mExist ? print("Match file exits\n") : print("Match file doesn't exist\n")
    
    do{
        if mExist{
            do{
                try fm.removeItem(atPath: mPath)
            }catch{
                print("\nError removing item!\n")
            }
        }
        
        //Get contents of old file
        let fullText = try String(contentsOfFile: oldMpath, encoding: String.Encoding.utf8)
        
        //Create file with copied contents
        fm.createFile(atPath: mPath, contents: fullText.data(using: .utf8), attributes: nil)
    }catch{
        print("(Match Data) Error in copying file to \(mPath)\n")
    }
}

func saveMatchData(){
    if currentTournament == ""{
        print("\n\n---Error: current tournament is nil---\n\n")
        return
    }
    truncateFile(fileName: currentTournament)
    writeMatchDataToFile(fileName: currentTournament)
}

func createTypeString(array: [Int]) -> String{
    var out: String = ""
    for i in 0..<array.count{
        out += "\(array[i])"
        if i != array.count - 1{
            out += "."
        }
    }
    return out
}

func getTypeIntArray(_ val: String) -> [Int]{
    return (val.components(separatedBy: ".")).map{ Int($0)! }
}

func formatMatchDataToCSV() -> String{
    var output: String = ""
    
    //Add team list to beginning of file
    output += "\(formatTeamListToString())\n"
    
    //Add all the match data
    for i in 0..<matchData.count{
        for j in 0..<4{
            output += String(matchData[i][j].number) + ","
            output += String(matchData[i][j].match) + ","
            output += String(matchData[i][j].autoCorner) + ","
            output += String(matchData[i][j].autoVortex) + ","
            output += String(matchData[i][j].autoBeacons) + ","
            
            output += String(matchData[i][j].autoNBeacons) + ","
            output += createTypeString(array: matchData[i][j].autoBType) + ","
            
            output += String(matchData[i][j].autoBeaconsDNA) + ","
            output += String(matchData[i][j].parkPts) + ","
            output += String(matchData[i][j].autoCapBallPts) + ","
            output += String(matchData[i][j].autoCapBallDNA) + ","
            output += String(matchData[i][j].autoPts) + ","
            output += String(matchData[i][j].cornerBalls) + ","
            output += String(matchData[i][j].vortexBalls) + ","
            output += String(matchData[i][j].telePts) + ","
            output += String(matchData[i][j].capBallPts) + ","
            output += String(matchData[i][j].capBallDNA) + ","
            output += String(matchData[i][j].beacons) + ","
            
            output += String(matchData[i][j].NBeacons) + ","
            output += createTypeString(array: matchData[i][j].bType) + ","
            output += String(matchData[i][j].bCount) + ","
            
            output += String(matchData[i][j].endGamePts) + ","
            output += String(matchData[i][j].outcome) + ","
            output += String(matchData[i][j].calculatedScore) + ","
            output += String(matchData[i][j].allianceScore) + ","
            output += String(matchData[i][j].officialScore)
            if j != 3{
                output += ","
            }
        }
        output += "\n"
    }
    return output
}

func writeMatchDataToFile(fileName: String){
    //let path = Bundle.main.path(forResource: fileName, ofType: "txt")!
    let path = docsPath.appendingPathComponent("\(fileName).txt")
    let file: FileHandle? = FileHandle(forWritingAtPath: path)
    
    print("\nWriting to match file at: \(path)\n")
    
    if file != nil {
        // Set the data we want to write
        let data = (formatMatchDataToCSV() as NSString).data(using: String.Encoding.utf8.rawValue)
        
        // Write it to the file
        file?.seekToEndOfFile()
        file?.write(data!)
        
        // Close the file
        file?.closeFile()
    }
    else {
        print("Could not find match file!")
    }
}

//TOURNAMENT CONTROL
func readTournamentList(){
    //let path = Bundle.main.path(forResource: "tournaments", ofType: "txt")
    let path = docsPath.appendingPathComponent("tournaments.txt")
    let fm = FileManager.default
    
    //Checks if file exists
    if fm.fileExists(atPath: path){
        print("Tournament file exists...reading file")
        do{
            let fullText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            print("List: \(fullText)")
            let lines = fullText.components(separatedBy: "\n") as [String]
            var index = 0
            
            //Increment through lines
            tournamentList = []
            for i in 1..<lines.count{
                if lines[i] != ""{
                    let data = lines[i].components(separatedBy: ",")
                    tournamentList.append(tournament())
                    tournamentList[index].name = data[0]
                    tournamentList[index].type = data[1]
                    tournamentList[index].date = data[2]
                    tournamentList[index].fileLocation = data[3]
                    index += 1
                }
            }
        }catch{
            print("Error in tournament read")
        }
    }
}

func addTournament(Tname: String, Ttype: String, Tdate: String, TfileName: String){
    //Add a new index to tournament list
    tournamentList.append(tournament())
    let index = tournamentList.count - 1
    
    //Add inputed data into new tournament index
    tournamentList[index].name = Tname
    tournamentList[index].type = Ttype
    tournamentList[index].date = Tdate
    tournamentList[index].fileLocation = TfileName
    
    //Save tournament array to list file
    truncateTournamentFile()
    print("\nFormatting:\n\(formatTournamentsToCSV())\n\n")
    writeToTournamentList()
    
    //Create new file for data
    createFile(withName: TfileName)
    
    //Set current tournament
    currentTournament = TfileName
}

//Removes tournament from list by file name
func removeTournament(fileName: String) -> Bool{
    for t in 0..<tournamentList.count{
        if tournamentList[t].fileLocation == fileName{
            tournamentList.remove(at: t)
            truncateTournamentFile()
            writeToTournamentList()
            return true
        }
    }
    return false
}

func writeToTournamentList(){
    //let path = Bundle.main.path(forResource: "tournaments", ofType: "txt")!
    let path = docsPath.appendingPathComponent("tournaments.txt")
    let file: FileHandle? = FileHandle(forWritingAtPath: path)
    
    print("\nWriting to tournament list file at: \(path)\n")
    
    if file != nil {
        // Set the data we want to write
        let data = (formatTournamentsToCSV() as NSString).data(using: String.Encoding.utf8.rawValue)
        
        // Write it to the file
        file?.seekToEndOfFile()
        file?.write(data!)
        
        // Close the file
        file?.closeFile()
    }
    else {
        print("Could not find tournament file!")
    }
}

//FORMATTING AND UTILITY
func formatTournamentsToCSV() -> String{
    var out: String = ""
    
    for i in 0..<tournamentList.count{
        out += (tournamentList[i].name + ",")
        out += (tournamentList[i].type + ",")
        out += (tournamentList[i].date + ",")
        out += (tournamentList[i].fileLocation)
        out += "\n"
    }
    return out
}

func formatFileName(name: String) -> String{
    var out: String = ""
    for i in 0..<name.characters.count{
        let char = name.substring(i, end: i)
        if char != " "{
            out += char
        }
    }
    return out.lowercased()
}

func formatTeamListToString() -> String{
    var output: String = ""
    var index = 0
    for (number, inside) in teamList{
        output += ("\(number),\(inside.name),\(String(inside.fav))")
        if index != teamList.count-1{
            output += ","
        }
        index += 1
    }
    return output
}

func truncateFile(fileName: String){
    //let path = Bundle.main.path(forResource: fileName, ofType: "txt")!
    let path = docsPath.appendingPathComponent("\(fileName).txt")
    let file: FileHandle? = FileHandle(forWritingAtPath: path)
    
    print("\nTruncating file at path: \(path)\n")
    
    if file != nil {
        
        // Write it to the file
        file?.truncateFile(atOffset: 1102)
        
        // Close the file
        file?.closeFile()
    }
    else {
        print("Truncating matchData file failed!")
    }
}

func truncateTournamentFile(){
    //let path = Bundle.main.path(forResource: "tournaments", ofType: "txt")!
    let path = docsPath.appendingPathComponent("tournaments.txt")
    let file: FileHandle? = FileHandle(forWritingAtPath: path)
    
    print("\nTruncating file at path: \(path)\n")
    
    if file != nil {
        
        // Write it to the file
        file?.truncateFile(atOffset: 28)
        
        // Close the file
        file?.closeFile()
    }
    else {
        print("Truncating tournament file failed!")
    }
}

func createFile(withName fileName: String){
    //let path = Bundle.main.bundlePath + "/\(name).txt"
    let path = docsPath.appendingPathComponent("\(fileName).txt")
    
    print("\nCreated file at path: \(path)\n")
    let header: String = "\(matchHeader)\n"
    
    do{
        try header.write(toFile: path, atomically: true, encoding: .utf8)
    }
    catch{
        print("Error in creating a file!")
    }
}

//DEBUGING
func getFileList() -> [String]{
    do {
        // Get the directory contents urls (including subfolders urls)
        let directoryContents = try FileManager.default.contentsOfDirectory(atPath: docsPath as String)
        return directoryContents
        //print(directoryContents)
    }
    catch{
        print("Error getting file list")
    }
    return []
}

func removeFile(withName file: String) -> Bool{
    //let path = Bundle.main.path(forResource: "tournaments", ofType: "txt")
    let path = docsPath.appendingPathComponent(file)
    let fm = FileManager.default
    
    if path == ""{
        return false
    }
    
    //Checks if file exists
    if fm.fileExists(atPath: path){
        do{
            try fm.removeItem(atPath: path)
            let fileN = file.substring(0, end: file.characters.count - 5)
            print("\n\(fileN)\n")
            if !removeTournament(fileName: fileN){
                print("Tournament remove failed")
                return false
            }
            return true
        }catch{
            print("Error removing file")
            return false
        }
    }
    return false
}

func resetArrays(){
    matchData = []
    teamList = [:]
    tournamentList = []
}
