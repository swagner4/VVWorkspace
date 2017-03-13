//
//  MenuController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 12/8/16.
//  Copyright © 2016 Q Is Silqent. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialUtilityFiles(refresh: false)
        _ = readTournamentList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMenu(sender: UIStoryboardSegue){
        resetArrays()
    }
    
    @IBAction func loadTournament(_ sender: AnyObject) {
        //Read tournament list
        _ = readTournamentList()
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tournamentSelectTV") as! TournamentSelectController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }

    @IBAction func createTournamentAction(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createTournament") as! NewTournamentController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
}
