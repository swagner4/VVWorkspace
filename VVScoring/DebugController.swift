//
//  DebugController.swift
//  VVScoring
//
//  Created by CLARK, THOMAS on 2/2/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit

class DebugController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var documentList: [String] = []
    
    let cellReuseIdendifier = "FileCell"
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func loadData(_ sender: AnyObject) {
        
        let data = sheetAPI.getDataFromSheet()
        
        //  print(data)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sheetAPI = SheetsAPI()
        sheetAPI.removeState()
        sheetAPI.auth(viewController: self)
        //sheetAPI.loadState()
        
        
        
        tableView.register(FileCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forceRefresh(_ sender: AnyObject) {
        setupInitialUtilityFiles(refresh: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let path = docsPath.appendingPathComponent(documentList[indexPath.row])
        
        do{
            let fullText = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            textView.text = fullText
        }catch{
            print("ERROR")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            if removeFile(withName: documentList[indexPath.row]){
                documentList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath as IndexPath) as! FileCell
        
        documentList = getFileList()
        
        cell.labels["file"]?.Label.text = documentList[indexPath.row]
        
        return cell
    }
}
