//
//  FrameTableView.swift
//  GUI view for the second tab called "Physical Memory"
//
//  Created by Morrie Cunningham on 11/10/16.
//  Copyright © 2016 Morrie Cunningham. All rights reserved.
//

import Foundation
import UIKit

class FrameTableView: UIViewController {
    
    // Initializes all GUI elements
    @IBOutlet weak var FrameTableLabel: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    @IBOutlet weak var ShowEventLabel: UILabel!
    @IBOutlet weak var FTLabel: UILabel!
    
    @IBOutlet weak var P0Label: UILabel!
    @IBOutlet weak var P1Label: UILabel!
    @IBOutlet weak var P2Label: UILabel!
    @IBOutlet weak var P3Label: UILabel!
    @IBOutlet weak var P4Label: UILabel!
    @IBOutlet weak var P5Label: UILabel!
    @IBOutlet weak var P6Label: UILabel!
    @IBOutlet weak var P7Label: UILabel!
    @IBOutlet weak var P8Label: UILabel!
    
    var fileName = ""
    let pt = pageTutor.sharedInstance
    var pArr = [String]()
    
    // This function only fires off, when user hits Physical Memory tab at bottom
    override func viewWillAppear(_ animated: Bool) {
        
        ShowEventLabel.text = pt.eventsArr[0]
        
        self.FrameTableLabel.text = pt.printFrameTable()
        
        pArr = pt.printPageTables()
        P0Label.text = pArr[0];
        P1Label.text = pArr[1];
        P2Label.text = pArr[2];
        P3Label.text = pArr[3];
        P4Label.text = pArr[4];
        P5Label.text = pArr[5];
        P6Label.text = pArr[6];
        P7Label.text = pArr[7];
        P8Label.text = pArr[8];
    
    }
    
    // This function only fires off when this controller is first loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Default input is input3a.data
        pt.readFile(file: "input3a")
        
        P0Label.text = ""
        P1Label.text = ""
        P2Label.text = ""
        P3Label.text = ""
        P4Label.text = ""
        P5Label.text = ""
        P6Label.text = ""
        P7Label.text = ""
        P8Label.text = ""
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is the "action listener" for my previous button
    @IBAction func PreviousButton(_ sender: Any) {
        if(pt.eCount >= 1) {
            pt.eCount -= 1
            pt.previousEvent(c: pt.eCount)
            self.FrameTableLabel.text = pt.printFrameTable()
        
            ShowEventLabel.text = pt.eventsArr[pt.eCount]
        }
        
        pArr = pt.printPageTables()
        
        P0Label.text = pArr[0];
        P1Label.text = pArr[1];
        P2Label.text = pArr[2];
        P3Label.text = pArr[3];
        P4Label.text = pArr[4];
        P5Label.text = pArr[5];
        P6Label.text = pArr[6];
        P7Label.text = pArr[7];
        P8Label.text = pArr[8];

    }
    
    // This is the "action listener" for my next button
    @IBAction func NextButton(_ sender: Any) {
        if(pt.eCount < pt.eventsArr.count) {
            pt.nextEvent(c: pt.eCount)
            self.FrameTableLabel.text = pt.printFrameTable()
            pt.eCount += 1
        }
        
        if(pt.eCount >= pt.eventsArr.count) {
            ShowEventLabel.text = "END OF EVENTS!"
        } else {
            ShowEventLabel.text = pt.eventsArr[pt.eCount]
        }
        
        pArr = pt.printPageTables()
        
        P0Label.text = pArr[0];
        P1Label.text = pArr[1];
        P2Label.text = pArr[2];
        P3Label.text = pArr[3];
        P4Label.text = pArr[4];
        P5Label.text = pArr[5];
        P6Label.text = pArr[6];
        P7Label.text = pArr[7];
        P8Label.text = pArr[8];
        
    }
}
