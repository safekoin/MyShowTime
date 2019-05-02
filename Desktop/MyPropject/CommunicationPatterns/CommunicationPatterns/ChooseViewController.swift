//
//  ChooseViewController.swift
//  CommunicationPatterns
//
//  Created by mac on 4/5/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

//(1) create a protocol and conform it to class to be able to make the variable WEAK
protocol SetOfInstructions: class {
    func passInformation(image: UIImage, name: String)
}

class ChooseViewController: UIViewController {
    
    
    //(2) delegate variable
    //Make sure its weak to avoid retain cycles
    weak var worker: SetOfInstructions?
    
    var myVar = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func evilButtonTapped(_ sender: UIButton) {
        //(3) call the worker to pass the information
        worker?.passInformation(image: UIImage(named: "frieza")!, name: "Frieza")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func goodButtonTapped(_ sender: UIButton) {
        //(3) call the worker to pass the information
        worker?.passInformation(image: UIImage(named: "vegeta")!, name: "Vegeta")
        
        dismiss(animated: true, completion: nil)
    }
    

}
