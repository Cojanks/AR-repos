//
//  ViewController.swift
//  counter
//
//  Created by Corey Jenkins on 4/15/18.
//  Copyright © 2018 Corey Jenkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
//    let someVariable: String? = nil
    var number: Int = 0
    @IBAction func perform(_ sender: Any) {
        self.number += 1
        self.label.text = String(number)
        
        
        //        A note on optionals:
        
//        if let number = self.label.text {
//            print(number)
//        } else {
//            print("value is nil")
//        }
        
//        Forces a data type onto some value but will fail if nil
//        guard let number = self.label.text else {return}
//        print(number)
        
        
//        Allows a tpye-conflict to fail gracefull
//        if let value = someVariable {
//            print(value)
//        } else {
//            print ("no value")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

