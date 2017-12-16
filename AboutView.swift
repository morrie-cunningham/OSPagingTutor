//
//  AboutView.swift
//  GUI for the first tab called "About"
//
//  Created by Morrie Cunningham on 11/16/16.
//  Copyright © 2016 Morrie Cunningham. All rights reserved.
//

import Foundation
import UIKit

class AboutView: UIViewController {
    
    var pt = pageTutor.sharedInstance
    
    var FV = FrameTableView()
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func Input3aButton(_ sender: Any) {
        
        // Re-Initializes all of pageTutor components to read in new file
        pt.frameArr = Array(repeating: Array(repeating: "", count: 4), count: 8)
        pt.pageTableStrArr = Array(repeating: "", count: 9)
        for i in 0...7 {
            pt.frameArr[i][0] = String(i)
        }
        pt.eCount = 0
        
        // Reads in new file from input3a.data
        pt.readFile(file: "input3a")
    }
    
    @IBAction func Input3bButton(_ sender: Any) {
        
        // Re-Initializes all of pageTutor components to read in new file
        pt.eventsArr = [String]()
        pt.frameArr = Array(repeating: Array(repeating: "", count: 4), count: 8)
        pt.pageTableStrArr = Array(repeating: "", count: 9)
        for i in 0...7 {
            pt.frameArr[i][0] = String(i)
        }
        pt.eCount = 0
        
        // Reads in new file from input3b.data
        pt.readFile(file: "input3b")
    }
    @IBAction func Input3cButton(_ sender: Any) {
        
        // Re-Initializes all of pageTutor components to read in new file
        pt.eventsArr = [String]()
        pt.frameArr = Array(repeating: Array(repeating: "", count: 4), count: 8)
        pt.pageTableStrArr = Array(repeating: "", count: 9)
        for i in 0...7 {
            pt.frameArr[i][0] = String(i)
        }
        pt.eCount = 0
        
        // Reads in new file from input3c.data
        pt.readFile(file: "input3c")
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
