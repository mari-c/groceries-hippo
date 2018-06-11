//
//  exerciseGameController.swift
//  GroceryGame
//
//  Created by ahely on 2018-05-31.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import CoreMotion

class ExerciseGameController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var index = 0
    var tasks = [String]()
    var points = Int()
    
    var stepLabel = UILabel(frame: CGRect(x: 253, y: 97, width: 180, height: 101))
    var motionManager = CMMotionManager()
    var altimeter = CMAltimeter()
    var pedometer = CMPedometer()
    
    // Choose threshold values to detect task completion
    var MIN_STRETCH_HEIGHT = 0.35
    var ACCELERATION_FORCE = 2.0
    var MIN_CROUCH_HEIGHT = 0.20
    
    // Default points per task completed
    var TASK_POINTS = 100
    // Default points per step
    var STEP_POINTS = 5
    
    // Crouch task timer
    var timer = Timer()
    var timerSeconds = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Only show button when task is completed successfully
        doneButton.isHidden = true
        
        // Only show Start button in tasks involving step count
        startButton.isHidden = true
        
        pointsLabel.text = String(points)

        loadText()
        let ind = displayText()
        requestTask(index: ind)
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    // MARK: Actions
    
    @IBAction func countSteps(_ sender: UIButton) {
        startButton.isHidden = true
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date(), withHandler: { (data, error) in
                if let stepData = data {
                    DispatchQueue.main.sync {
                        self.stepLabel.text = "Steps: \(stepData.numberOfSteps)"
                        self.doneButton.isHidden = false
                        self.pedometer.stopUpdates()
                        let total = Int(truncating: stepData.numberOfSteps) * self.STEP_POINTS + self.TASK_POINTS
                        self.points += total
                        self.pointsLabel.text = String(self.points)
                    }
                }
            })
        }
        view.addSubview(self.stepLabel)
    }
    
    // MARK: Private Methods
    
    private func loadText() {
        // File location
        let fileURLProject = Bundle.main.path(forResource: "ProjectTextFile", ofType: "txt")
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            self.tasks = readStringProject.components(separatedBy: .newlines)
        } catch let error as NSError {
            print("Failed reading from project")
            print(error)
        }
        
    }
    
    private func displayText() -> Int {
        let ind = Int(arc4random_uniform(UInt32(tasks.count - 1)))
        
        // USE THIS TO TEST EACH TASK; CHANGE ind FROM var TO let THEN DELETE WHEN DONE!
        // ind = 3
        
        taskLabel.text = tasks[ind]
        return ind
    }
    
    private func requestTask(index: Int) {
        motionManager.accelerometerUpdateInterval = 0.3
        switch index {
        case 0:
            // Reach as high as you can
            if CMAltimeter.isRelativeAltitudeAvailable() {
                altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                    if let altitudeData = data {
                        let position = Double(truncating: altitudeData.relativeAltitude)
                        // print("RELATIVE ALTITUDE: \(altitudeData.relativeAltitude)")
                        // print("HEIGHT CHANGE: \(heightChange)")
                        if position > self.MIN_STRETCH_HEIGHT {
                            self.doneButton.isHidden = false
                            self.altimeter.stopRelativeAltitudeUpdates()
                            self.updatePoints()
                        }
                    }
                })
            }
        case 1, 2:
            // Shake
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let accelerationData = data {
                    if accelerationData.acceleration.x > self.ACCELERATION_FORCE || accelerationData.acceleration.y > self.ACCELERATION_FORCE {
                        self.doneButton.isHidden = false
                        self.motionManager.stopAccelerometerUpdates()
                        self.updatePoints()
                    }
                }
            }
        case 3:
            // Crouch and count to 3
            if CMAltimeter.isRelativeAltitudeAvailable() {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCrouchTimer), userInfo: nil, repeats: true)
                altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                    if let altitudeData = data {
                        let position = Double(truncating: altitudeData.relativeAltitude)
                        // print("HEIGHT CHANGE: \(position)")
                        if position < 0 && abs(position) > self.MIN_CROUCH_HEIGHT && self.timerSeconds < 1 {
                            self.doneButton.isHidden = false
                            self.altimeter.stopRelativeAltitudeUpdates()
                            self.updatePoints()
                        }
                    }
                })
            }
        case 4:
            // Walk with long steps for a few seconds
            stepLabel.textAlignment = .left
            stepLabel.text = "Steps: ..."
            stepLabel.font = stepLabel.font.withSize(20.0)
            startButton.isHidden = false
        default:
            fatalError("Task index does not exist. Task could not be requested.")
        }
    }
    
    @objc private func updateCrouchTimer() {
        if timerSeconds < 1 {
            timer.invalidate()
        } else {
            timerSeconds -= 1
        }
    }
    
    private func updatePoints() {
        points += TASK_POINTS
        pointsLabel.text = String(points)
    }
    
}
