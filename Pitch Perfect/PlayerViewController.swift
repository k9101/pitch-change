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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		//TODO: Get File Path
		if let movieQuote = recievedAudioData.filePathUrl { //NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)!){
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
		
		//TODO: Create Instance of AVAudioPlayer
		//TODO: Play the audio
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		if player.playing{
			player.stop()
		}
	}
	
	func playAudioAtRate(audioRate: Float) -> Void{
		if player.playing{
			player.stop()
			player.currentTime = 0
		}
		
		player.rate = audioRate
		player.play()
	}
	
    
	@IBAction func playAudioSlow(sender: UIButton) {
		playAudioAtRate(0.5)
	}

	@IBAction func playAudioFast(sender: UIButton) {
		playAudioAtRate(2.0)
	}
	@IBAction func stopAllAudio(sender: UIButton) {
		if player.playing{
			player.stop()
			player.currentTime = 0
		}
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
