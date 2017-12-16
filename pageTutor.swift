//
//  pageTutor.swift
//  This is the model class for the paging tutor project. 
//  This class does all the grunt work for the app.
//
//  Created by Morrie Cunningham on 11/8/16.
//  Copyright © 2016 Morrie Cunningham. All rights reserved.
//

import Foundation

class pageTutor {
    
    // This sets up one page tutor instance for all other classes to use as well
    static let sharedInstance = pageTutor()
    
    // Data structures for the array of events, frame table, and page tables
    var eventsArr = [String]()
    var frameArr = Array(repeating: Array(repeating: "", count: 4), count: 8)
    var pageTableStrArr = Array(repeating: "", count: 9)
    var eCount = 0
    
    // Constructor
    private init(){
        for i in 0...7 {
            frameArr[i][0] = String(i)
        }
    }
    
    // This function reads the events from the data file
    func readFile(file: String) {
        
        eventsArr = [String]()
        
        if let path = Bundle.main.path(forResource: file, ofType: "data") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                var events = data.components(separatedBy: "\r\n")
                events.remove(at: events.count-1)
                //print("Size of file: " + String(events.count))
                //print(events)
                eventsArr = events
            } catch {
                print(error)
            }
        }
    }
    
    // This function executes the next event
    func nextEvent(c: Int) {
        // Parses through line of event array separated by spaces
        let event = eventsArr[c].components(separatedBy: " ")
        
        let procID = event[0]
        let segmentT = "Text"
        let segmentD = "Data"
        var pNum = 0, fNum = 0
        var numTFrames = 0, numDFrames = 0
        
        // If the event has three arguments (AKA not a halt command)
        if(event.count == 3) {
            
            // Gets how many text frames are needed
            if((Int(event[1]))! % 512 == 0) {
                numTFrames = ((Int(event[1]))!/512)
            } else {
                numTFrames = ((Int(event[1]))!/512)+1
            }
            
            // Gets how many data frames are needed
            if((Int(event[2]))! % 512 == 0) {
                numDFrames = ((Int(event[2]))!/512)
            } else {
                numDFrames = ((Int(event[2]))!/512)+1
            }
        
            pageTableStrArr[Int(procID)!] = ("Process " + procID + ": ")
            pageTableStrArr[Int(procID)!] += ("\n\t\tPage\tFrame\n")
            
            pageTableStrArr[Int(procID)!] += segmentT
            
            while(numTFrames > 0) {
                while(frameArr[fNum][1] != ""){
                    fNum += 1
                }
                frameArr[fNum][1] = procID
                frameArr[fNum][2] = segmentT
                frameArr[fNum][3] = String(pNum)
                
                if(pNum == 0) {
                    pageTableStrArr[Int(procID)!] += ("\t\t" + String(pNum) + "\t\t" + String(fNum) + "\n")
                } else {
                    pageTableStrArr[Int(procID)!] += ("\t\t\t" + String(pNum) + "\t\t" + String(fNum) + "\n")
                }
                pNum += 1
                fNum += 1
                numTFrames -= 1
            }
        
            pNum = 0
            
            pageTableStrArr[Int(procID)!] += ("\n" + segmentD)
            
            while(numDFrames > 0) {
                while(frameArr[fNum][1] != ""){
                    fNum += 1
                }
                frameArr[fNum][1] = procID
                frameArr[fNum][2] = segmentD
                frameArr[fNum][3] = String(pNum)
            
                if(pNum == 0) {
                    pageTableStrArr[Int(procID)!] += ("\t\t" + String(pNum) + "\t\t" + String(fNum))
                } else {
                    pageTableStrArr[Int(procID)!] += ("\t\t\t" + String(pNum) + "\t\t" + String(fNum))
                }
                
                if(numDFrames != 1) {
                    pageTableStrArr[Int(procID)!] += "\n"
                }
            
                pNum += 1
                fNum += 1
                numDFrames -= 1
            }
        }
        // If the event is a halt command
        else {
            for i in 0...7 {
                if(frameArr[i][1] == procID) {
                    frameArr[i][1] = ""
                    frameArr[i][2] = ""
                    frameArr[i][3] = ""
                }
            }
            pageTableStrArr[Int(procID)!] = ""
        }
    }
    
    // This function executes the previous event
    func previousEvent(c: Int) {
        // Parses through line of event array separated by spaces
        let event = eventsArr[c].components(separatedBy: " ")
        
        let procID = event[0]
        
        // If the previous event was not a halt command
        if(event.count == 3) {
            for j in 0...7 {
                if(frameArr[j][1] == procID) {
                    frameArr[j][1] = ""
                    frameArr[j][2] = ""
                    frameArr[j][3] = ""
                }
            }
            pageTableStrArr[Int(procID)!] = ""

        }
        // If the previous event was a halt command
        else {
            
            frameArr = Array(repeating: Array(repeating: "", count: 4), count: 8)
            for j in 0...7 {
                frameArr[j][0] = String(j)
            }
            
            pageTableStrArr = Array(repeating: "", count: 9)
            
            for i in 0...c-1 {
                nextEvent(c: i)
            }
        
        }
    }
    
    // This function returns the frame table as a string formated correctly
    func printFrameTable() -> String {
        var str = ""
        
        for i in 0...7 {
            if(frameArr[i][1] != "") {
                str += ("\nFrame " + frameArr[i][0] + "\t\t" + "P" + frameArr[i][1] + " " + frameArr[i][2] + " Page " + frameArr[i][3] + "\n")
            } else {
                str += ("\nFrame " + frameArr[i][0] + "\n")
            }
        }
        return str
    }
    
    // This function returns the string array of page tables to be printed by FrameTableView.swift
    func printPageTables() -> [String] {
        return pageTableStrArr
    }
}
