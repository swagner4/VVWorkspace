//
//  TournamentSelectController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 12/8/16.
//  Copyright © 2016 Q Is Silqent. All rights reserved.
//

import UIKit

class TournamentSelectController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellID = "TournamentCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.tableView.register(TournamentCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    @IBAction func cancelAction(_ sender: AnyObject) {
        //self.view.removeFromSuperview()
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
    
    //Selecting row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let tname = tournamentList[indexPath.row].fileLocation
        currentTournament = tname
        _ = readMatchDataFromFile(fileName: tname)
        
        removeAnimate()
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        present(viewController!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            //Deleting files
            let fileN = "\(tournamentList[indexPath.row].fileLocation).txt"
            if removeFile(withName: fileN){
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournamentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath) as! TournamentCell
        
        let tData = tournamentList[indexPath.row]
        
        cell.labels["name"]?.Label.text = tData.name
        cell.labels["date"]?.Label.text = tData.date
        
        return cell
    }
}
