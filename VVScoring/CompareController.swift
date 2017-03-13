//
//  CompareController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 2/22/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class CompareController: UIViewController {

    //MARK: Properties
    
    //Top bar
    @IBOutlet weak var t1Name: UIButton!
    @IBOutlet weak var t1Number: UIButton!
    @IBOutlet weak var t1Rank: UILabel!
    @IBOutlet weak var t1WLT: UILabel!
    @IBOutlet weak var t2Name: UIButton!
    @IBOutlet weak var t2Number: UIButton!
    @IBOutlet weak var t2Rank: UILabel!
    @IBOutlet weak var t2WLT: UILabel!
    
    
    //SIDE 1
    @IBOutlet weak var OPR: UILabel!
    @IBOutlet weak var alliance: UILabel!
    
    //Auto
    @IBOutlet weak var autoBeacons: UILabel!
    @IBOutlet weak var autoVortex: UILabel!
    @IBOutlet weak var autoCorner: UILabel!
    @IBOutlet weak var autoParkPts: UILabel!
    @IBOutlet weak var autoCapBall: UILabel!
    @IBOutlet weak var totalAuto: UILabel!
    
    //Tele
    @IBOutlet weak var vortex: UILabel!
    @IBOutlet weak var corner: UILabel!
    @IBOutlet weak var teleTotal: UILabel!
    
    //End
    @IBOutlet weak var beacons: UILabel!
    @IBOutlet weak var beaconsControl: UILabel!
    @IBOutlet weak var capBallPts: UILabel!
    @IBOutlet weak var totalEnd: UILabel!
    
    
    //SIDE 2
    @IBOutlet weak var OOPR: UILabel!
    @IBOutlet weak var Oalliance: UILabel!
    
    //Auto
    @IBOutlet weak var OautoBeacons: UILabel!
    @IBOutlet weak var OautoVortex: UILabel!
    @IBOutlet weak var OautoCorner: UILabel!
    @IBOutlet weak var OautoParkPts: UILabel!
    @IBOutlet weak var OautoCapBall: UILabel!
    @IBOutlet weak var OtotalAuto: UILabel!
    
    //Tele
    @IBOutlet weak var Ovortex: UILabel!
    @IBOutlet weak var Ocorner: UILabel!
    @IBOutlet weak var OteleTotal: UILabel!
    
    //End
    @IBOutlet weak var Obeacons: UILabel!
    @IBOutlet weak var ObeaconsControl: UILabel!
    @IBOutlet weak var OcapBallPts: UILabel!
    @IBOutlet weak var OtotalEnd: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if filledSelections(){
            let calcComp = compareTeams(num1: selected[0], num2: selected[1])
            setLabels(calcComp.team1Averages, calcComp.team2Averages, calcComp.compare)
        }
    }
    
    @IBAction func team1Transfer(_ sender: AnyObject) {
        selectedTeam = selected[0]
        let vc = (storyboard?.instantiateViewController(withIdentifier: "singleView"))!
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func team2Transfer(_ sender: AnyObject) {
        selectedTeam = selected[1]
        let vc = (storyboard?.instantiateViewController(withIdentifier: "singleView"))!
        present(vc, animated: true, completion: nil)
    }
    
    func setLabels(_ t1: teamAverage, _ t2: teamAverage, _ comp: [Int]){
        // 0 = team1 greater : 1 = team2 greater : 2 = equal or close
        let team1: Int = selected[0]
        let team2: Int = selected[1]
        
        t1Name.setTitle(teamList["\(team1)"]?.name, for: .normal)
        t1Number.setTitle(String(team1), for: .normal)
        t1Rank.text = String(getRank(num: team1))
        t1WLT.text = getRecord(num: team1)
        
        t2Name.setTitle(teamList["\(team2)"]?.name, for: .normal)
        t2Number.setTitle(String(team2), for: .normal)
        t2Rank.text = String(getRank(num: team2))
        t2WLT.text = getRecord(num: team2)
        
        //------------Team 1------------
        OPR.text = String (t1.opr)
        alliance.text = String (Round(t1.allianceScore))
        
        autoBeacons.text = String (Round(t1.autoBeacons))
        autoVortex.text = String (Round(t1.autoVortex))
        autoCorner.text = String (Round(t1.autoCorner))
            autoParkPts.text = String (Round(t1.parkPts))
        autoCapBall.text = String (Round(t1.autoCapBallPts))
        totalAuto.text = String (Round(t1.autoPts))
        
        vortex.text = String (Round(t1.vortexBalls))
        corner.text = String (Round(t1.cornerBalls))
        teleTotal.text = String (Round(t1.telePts))
        
        beacons.text = String (Round(t1.beacons))
        beaconsControl.text = String (Round(t1.totalBeacons))
        capBallPts.text = String (Round(t1.capBallPts))
        totalEnd.text = String (Round(t1.endGamePts))
        
        //------------Team 2------------
        OOPR.text = String (t2.opr)
        Oalliance.text = String (Round(t2.allianceScore))
        
        OautoBeacons.text = String (Round(t2.autoBeacons))
        OautoVortex.text = String (Round(t2.autoVortex))
        OautoCorner.text = String (Round(t2.autoCorner))
        OautoParkPts.text = String (Round(t2.parkPts))
        OautoCapBall.text = String (Round(t2.autoCapBallPts))
        OtotalAuto.text = String (Round(t2.autoPts))
        
        Ovortex.text = String (Round(t2.vortexBalls))
        Ocorner.text = String (Round(t2.cornerBalls))
        OteleTotal.text = String (Round(t2.telePts))
        
        Obeacons.text = String (Round(t2.beacons))
        ObeaconsControl.text = String (Round(t2.totalBeacons))
        OcapBallPts.text = String (Round(t2.capBallPts))
        OtotalEnd.text = String (Round(t2.endGamePts))
        //------------------------------
        
        if comp.count <= 13{
            print("\nComp array invalid length: \(comp.count)\n")
            return
        }
        
        let gFlo = convertColorValues(withRGB: 26, 204, 53)
        let oFlo = convertColorValues(withRGB: 244, 168, 36)
        
        let green = UIColor.init(red: gFlo.red, green: gFlo.green, blue: gFlo.blue, alpha: 1)
        let orange = UIColor.init(red: oFlo.red, green: oFlo.green, blue: oFlo.blue, alpha: 1)
        let red = UIColor.red
        
        //Alliance
        switch comp[0]{
        case 0:
            alliance.textColor = green
            Oalliance.textColor = red
        case 1:
            alliance.textColor = red
            Oalliance.textColor = green
        case 2:
            alliance.textColor = orange
            Oalliance.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Auto beacons
        switch comp[1]{
        case 0:
            autoBeacons.textColor = green
            OautoBeacons.textColor = red
        case 1:
            autoBeacons.textColor = red
            OautoBeacons.textColor = green
        case 2:
            autoBeacons.textColor = orange
            OautoBeacons.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Auto cap ball points
        switch comp[2]{
        case 0:
            autoCapBall.textColor = green
            OautoCapBall.textColor = red
        case 1:
            autoCapBall.textColor = red
            OautoCapBall.textColor = green
        case 2:
            autoCapBall.textColor = orange
            OautoCapBall.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Auto Corner
        switch comp[3]{
        case 0:
            autoCorner.textColor = green
            OautoCorner.textColor = red
        case 1:
            autoCorner.textColor = red
            OautoCorner.textColor = green
        case 2:
            autoCorner.textColor = orange
            OautoCorner.textColor = orange
        default:
            print("Error in comp")
        }
        //Autonomous points
        switch comp[4]{
        case 0:
            totalAuto.textColor = green
            OtotalAuto.textColor = red
        case 1:
            totalAuto.textColor = red
            OtotalAuto.textColor = green
        case 2:
            totalAuto.textColor = orange
            OtotalAuto.textColor = orange
        default:
            print("Error in comp")
        }

        //Auto Vortex
        switch comp[5]{
        case 0:
            autoVortex.textColor = green
            OautoVortex.textColor = red
        case 1:
            autoVortex.textColor = red
            OautoVortex.textColor = green
        case 2:
            autoVortex.textColor = orange
            OautoVortex.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Beacons
        switch comp[6]{
        case 0:
            beacons.textColor = green
            Obeacons.textColor = red
        case 1:
            beacons.textColor = red
            Obeacons.textColor = green
        case 2:
            beacons.textColor = orange
            Obeacons.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Cap ball points
        switch comp[7]{
        case 0:
            capBallPts.textColor = green
            OcapBallPts.textColor = red
        case 1:
            capBallPts.textColor = red
            OcapBallPts.textColor = green
        case 2:
            capBallPts.textColor = orange
            OcapBallPts.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Corner balls
        switch comp[8]{
        case 0:
            corner.textColor = green
            Ocorner.textColor = red
        case 1:
            corner.textColor = red
            Ocorner.textColor = green
        case 2:
            corner.textColor = orange
            Ocorner.textColor = orange
        default:
            print("Error in comp")
        }
        
        //End points
        switch comp[9]{
        case 0:
            totalEnd.textColor = green
            OtotalEnd.textColor = red
        case 1:
            totalEnd.textColor = red
            OtotalEnd.textColor = green
        case 2:
            totalEnd.textColor = orange
            OtotalEnd.textColor = orange
        default:
            print("Error in comp")
        }
        
        //OPR
        switch comp[10]{
        case 0:
            OPR.textColor = green
            OOPR.textColor = red
        case 1:
            OPR.textColor = red
            OOPR.textColor = green
        case 2:
            OPR.textColor = orange
            OOPR.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Park points
        switch comp[11]{
        case 0:
            autoParkPts.textColor = green
            OautoParkPts.textColor = red
        case 1:
            autoParkPts.textColor = red
            OautoParkPts.textColor = green
        case 2:
            autoParkPts.textColor = orange
            OautoParkPts.textColor = orange
        default:
            print("Error in comp")
        }
        
        
        //Tele total
        switch comp[12]{
        case 0:
            teleTotal.textColor = green
            OteleTotal.textColor = red
        case 1:
            teleTotal.textColor = red
            OteleTotal.textColor = green
        case 2:
            teleTotal.textColor = orange
            OteleTotal.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Vortex balls
        switch comp[13]{
        case 0:
            vortex.textColor = green
            Ovortex.textColor = red
        case 1:
            vortex.textColor = red
            Ovortex.textColor = green
        case 2:
            vortex.textColor = orange
            Ovortex.textColor = orange
        default:
            print("Error in comp")
        }
        
        //Beacons Controlled
        switch comp[14]{
        case 0:
            beaconsControl.textColor = green
            ObeaconsControl.textColor = red
        case 1:
            beaconsControl.textColor = red
            ObeaconsControl.textColor = green
        case 2:
            beaconsControl.textColor = orange
            ObeaconsControl.textColor = orange
        default:
            print("Error in comp")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
