//
//  ViewController.swift
//  CommunicationPatterns
//
//  Created by mac on 4/5/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeLabel: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        
        let chooseVC = storyboard?.instantiateViewController(withIdentifier: "ChooseViewController") as! ChooseViewController
        
        //(5) set the worker (or delegate) as SELF
        chooseVC.worker = self
        
        //I can use this to pass information forward
        chooseVC.myVar = 5
        
        //present the vc that we created
        present(chooseVC, animated: true, completion: nil)
        
    }
    
}

//(4) conform to the protocol
extension HomeViewController: SetOfInstructions {
    
    
    func passInformation(image: UIImage, name: String) {
        
        //To update the UI you MUST go to the main thread
        DispatchQueue.main.async {
            
            self.homeLabel.image = image
            self.teamLabel.text = name
            self.teamLabel.isHidden = false
        }
    }
    
}

