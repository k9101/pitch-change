//
//  PlayerViewController.swift
//  
//
//  Created by Kris Penney on 2015-09-07.
//
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

	var player = AVAudioPlayer()
	var recievedAudioData = RecordedAudio()
	var engine = AVAudioEngine()
	var audioFile = AVAudioFile()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		audioFile = AVAudioFile(forReading: recievedAudioData.filePathUrl, error: nil)
		
        // Do any additional setup after loading the view.
		if let movieQuote = recievedAudioData.filePathUrl {
			var error:NSError?
			player = AVAudioPlayer(contentsOfURL: movieQuote, error: &error)
			player.enableRate = true
			
			player.prepareToPlay()
			
			if let isError = error{
				print(isError.localizedDescription)
			}
		}else{
			print("Could not file the audio file: \(recievedAudioData.title)")
		}
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		resetEngine()
	}

	
	func manipulateAudio(audioRate: Float, audioPitch: Float){
		var playerNode = AVAudioPlayerNode()
		var timePitch = AVAudioUnitTimePitch()
		
		resetEngine()
		playerNode.stop()
		
		
		timePitch.pitch = audioPitch
		timePitch.rate = audioRate
		
		engine.attachNode(timePitch)
		engine.attachNode(playerNode)
		
		engine.connect(playerNode, to: timePitch, format: nil)
		engine.connect(timePitch, to: engine.outputNode, format: nil)
		
		playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
		engine.startAndReturnError(nil)
		
		playerNode.play()
	}
	
	func resetEngine(){
		engine.stop()
		engine.reset()
	}
    
	@IBAction func playAudioSlow(sender: UIButton) {
		manipulateAudio(0.5, audioPitch: 1.0)
	}

	@IBAction func playAudioFast(sender: UIButton) {
		manipulateAudio(2.0, audioPitch: 1.0)
	}
	@IBAction func stopAllAudio(sender: UIButton) {
		resetEngine()
	}

	@IBAction func highPitchedAudio(sender: AnyObject) {
		manipulateAudio(1.0, audioPitch: 1000)
	}
	
	@IBAction func downPitchAudio(sender: UIButton) {
		manipulateAudio(1.0, audioPitch: -1000)
	}

}
