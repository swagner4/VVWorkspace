//
//  NewTournamentController.swift
//  VVScoring
//
//  Created by Tom Clark on 12/17/16.
//  Copyright © 2016 Q Is Silqent. All rights reserved.
//

import UIKit

class NewTournamentController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeSegmenter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButton(_ sender: AnyObject) {
        //Make sure to not go if the value is nil
        if nameField.text == nil{
            return
        }
        
        //Get data to create tournament
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let strDate = dateFormatter.string(from: date.date)
        
        let Name = nameField.text!
        let Type = String(typeSegmenter.selectedSegmentIndex)
        let FileName = formatFileName(name: nameField.text!)
        
        //Create tournament
        addTournament(Tname: Name, Ttype: Type, Tdate: strDate, TfileName: FileName)
        
        self.removeAnimate()
        
        //Segue to rankings screen
        let viewController = storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        present(viewController!, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancelButton(_ sender: AnyObject) {
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
