//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes:[String:Int] = ["Soft":300,"Medium":420,"Hard":720]
    var timer = Timer()
    var player:AVAudioPlayer!
    var totalTime:Int = 0
    var secondsPassed:Int = 0
    
    @IBOutlet weak var progreeEgg: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progreeEgg.progress = 0.0
        }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        timer.invalidate()
        player = nil
        titleLabel.text = sender.currentTitle!
        progreeEgg.progress = 0.0
        secondsPassed = 0
        
        totalTime = eggTimes[sender.currentTitle!]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            secondsPassed += 1
            progreeEgg.progress = Float(secondsPassed)/Float(totalTime)
            print("\(Float(secondsPassed)/Float(totalTime))")

        }else{
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound(soundName: "alarm_sound")
            
        }
    }
    
    
    func playSound(soundName:String){
            let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
                    player = try! AVAudioPlayer(contentsOf: url!)
                    player.play()
        }
}
