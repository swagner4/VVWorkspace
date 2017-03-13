//
//  RankingsController.swift
//  NBNP2Scoring
//
//  Created by CLARK, THOMAS on 10/18/16.
//  Copyright © 2016 CLARK. All rights reserved.
//

import UIKit

var selected: [Int] = [-1, -1]

class RankingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    //default sorting by rank
    var data = sortTeamsBy(mode: "", dir: 0)
    
    var currentSort = 0
    
    //first number is decreasing, second is increasing
    
    @IBAction func rank(_ sender: AnyObject) {//1,2
        if currentSort == 1 {
            data = sortTeamsBy(mode: "rank", dir: 1)
            currentSort = 2
        }
        else {
            data = sortTeamsBy(mode: "rank", dir: 0)
            currentSort = 1
        }
        tableView.reloadData()
    }
    @IBAction func RP(_ sender: AnyObject) {//3,4
        if currentSort == 3 {
            data = sortTeamsBy(mode: "rp", dir: 1)
            currentSort = 4
        }
        else {
            data = sortTeamsBy(mode: "rp", dir: 0)
            currentSort = 3
        }
        tableView.reloadData()
    }
    @IBAction func W(_ sender: AnyObject) {//5,6
        if currentSort == 5 {
            data = sortTeamsBy(mode: "", dir: 1)
            currentSort = 6
        }
        else {
            data = sortTeamsBy(mode: "", dir: 0)
            currentSort = 5
        }
        tableView.reloadData()
    }
    @IBAction func L(_ sender: AnyObject) {//7,8
        if currentSort == 7 {
            data = sortTeamsBy(mode: "", dir: 1)
            currentSort = 8
        }
        else {
            data = sortTeamsBy(mode: "", dir: 0)
            currentSort = 7
        }
        tableView.reloadData()
    }
    @IBAction func T(_ sender: AnyObject) {//9,10
        if currentSort == 9 {
            data = sortTeamsBy(mode: "", dir: 1)
            currentSort = 10
        }
        else {
            data = sortTeamsBy(mode: "", dir: 0)
            currentSort = 9
        }
        tableView.reloadData()
    }
    @IBAction func OPR(_ sender: AnyObject) {//11,12
        if currentSort == 11 {
            data = sortTeamsBy(mode: "opr", dir: 1)
            currentSort = 12
        }
        else {
            data = sortTeamsBy(mode: "opr", dir: 0)
            currentSort = 11
        }
        tableView.reloadData()
    }
    @IBAction func autoPts(_ sender: AnyObject) {//13,14
        if currentSort == 13 {
            data = sortTeamsBy(mode: "autoPts", dir: 1)
            currentSort = 14
        }
        else {
            data = sortTeamsBy(mode: "autoPts", dir: 0)
            currentSort = 13
        }
        tableView.reloadData()
    }
    @IBAction func autoBalls(_ sender: AnyObject) {//15,16
        if currentSort == 15 {
            data = sortTeamsBy(mode: "autoVortex", dir: 1)
            currentSort = 16
        }
        else {
            data = sortTeamsBy(mode: "autoVortex", dir: 0)
            currentSort = 15
        }
        tableView.reloadData()
    }
    @IBAction func autoBs(_ sender: AnyObject) {//17,18
        if currentSort == 17 {
            data = sortTeamsBy(mode: "autoBeacons", dir: 1)
            currentSort = 18
        }
        else {
            data = sortTeamsBy(mode: "autoBeacons", dir: 0)
            currentSort = 17
        }
        tableView.reloadData()
    }
    @IBAction func teleBalls(_ sender: AnyObject) {//19,20
        if currentSort == 19 {
            data = sortTeamsBy(mode: "vortexBalls", dir: 1)
            currentSort = 20
        }
        else {
            data = sortTeamsBy(mode: "vortexBalls", dir: 0)
            currentSort = 19
        }
        tableView.reloadData()
    }
    @IBAction func endBs(_ sender: AnyObject) {//21,22
        if currentSort == 21 {
            data = sortTeamsBy(mode: "beacons", dir: 1)
            currentSort = 22
        }
        else {
            data = sortTeamsBy(mode: "beacons", dir: 0)
            currentSort = 21
        }
        tableView.reloadData()
    }
    @IBAction func capPts(_ sender: AnyObject) {//23,24
        if currentSort == 23 {
            data = sortTeamsBy(mode: "capPts", dir: 1)
            currentSort = 24
        }
        else {
            data = sortTeamsBy(mode: "capPts", dir: 0)
            currentSort = 23
        }
        tableView.reloadData()
    }
    @IBAction func luck(_ sender: AnyObject) {//25,26
        if currentSort == 25 {
            data = sortTeamsBy(mode: "luck", dir: 1)
            currentSort = 26
        }
        else {
            data = sortTeamsBy(mode: "luck", dir: 0)
            currentSort = 25
        }
        tableView.reloadData()
    }
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editButton(_ sender: AnyObject) {
        tableView.isEditing ? tableView.setEditing(false, animated: true) : tableView.setEditing(true, animated: true)
    }
    
    let cellReuseIdendifier = "RankingsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RankingsCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    @IBAction func unwindToRankings(sender: UIStoryboardSegue){
        selected = [-1, -1]
    }
    
    func vc(withName vcName: String) -> UIViewController{
        return (storyboard?.instantiateViewController(withIdentifier: vcName))!
    }
    
    func addSelection(withNumber num: Int){
        for i in 0..<selected.count{
            if selected[i] == -1{
                selected[i] = num
                break
            }
        }
        if selected[0] != -1 && selected[1] != -1{
            present(vc(withName: "compare"), animated: true, completion: nil)
        }
    }
    
    func removeSelection(withNumber num: Int){
        for i in 0..<selected.count{
            if selected[i] == num{
                selected[i] = -1
                return
            }
        }
        print("Error: no team found for removal")
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if let sr = tableView.indexPathsForSelectedRows {
            if sr.count == 2 {
                return nil
            }
        }
        let selectedNumber = data[indexPath.row].number
        addSelection(withNumber: selectedNumber)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        let selectedNumber = data[indexPath.row].number
        removeSelection(withNumber: selectedNumber)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if !tableView.isEditing{
            //Get reversed index
            selectedTeam = data[indexPath.row].number
            
            //Transfer
            present(vc(withName: "singleView"), animated: true, completion: nil)
        }
    }
    
    @IBAction func addTeamButton(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addTeamController") as! AddTeamController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            var counter = 0
            for (name, _) in teamList{
                if counter == indexPath.row{
                    teamList.removeValue(forKey: name)
                    break
                }
                counter += 1
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert{
            //Do stuff
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath as IndexPath) as! RankingsCell
        
        //Data for Cells
        let t = data[indexPath.row]
        
        cell.labels["number"]?.Label.text = String (t.number)
        cell.labels["name"]?.Label.text = teamList[String (t.number)]?.name
        cell.labels["rank"]?.Label.text = String (getRank(num: t.number))
        cell.labels["RP"]?.Label.text = String(getAverages(num: t.number).RP)
        cell.labels["wins"]?.Label.text = String(getAverages(num: t.number).W)
        cell.labels["losses"]?.Label.text = String(getAverages(num: t.number).L)
        cell.labels["tie"]?.Label.text = String(getAverages(num: t.number).T)
        cell.labels["opr"]?.Label.text = String(Round(t.opr))
        cell.labels["autoPts"]?.Label.text = String(Round(t.autoPts))
        cell.labels["autoBalls"]?.Label.text = String(Round(t.autoVortex))
        cell.labels["autoBeacons"]?.Label.text = String(Round(t.autoBeacons))
        cell.labels["teleBalls"]?.Label.text = String(Round(t.vortexBalls))
        cell.labels["endBeacons"]?.Label.text = String(Round(t.beacons))
        cell.labels["capPts"]?.Label.text = String(Round(t.capBallPts))
        cell.labels["partnerScore"]?.Label.text = String(Round(t.allianceScore - t.opr))
        
        return cell
    }
}
