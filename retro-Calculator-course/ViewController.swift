//
//  ViewController.swift
//  retro-Calculator-course
//
//  Created by Grandon Lin on 2016-07-30.
//  Copyright © 2016 Grandon Lin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var leftVal = ""
    var rightVal = ""
    var currentNumber = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
     
        
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
            currentNumber += "\(btn.tag)"
            outputLbl.text = currentNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        clearUp()
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            if currentNumber != "" {
                rightVal = currentNumber
                currentNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }
                
                leftVal = result
                outputLbl.text = result

            }
            
            currentOperation = op
            
        } else {
            //This is the first time the operator is pressed
            leftVal = currentNumber
            currentNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func clearUp() {
        leftVal = ""
        rightVal = ""
        currentNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
}

