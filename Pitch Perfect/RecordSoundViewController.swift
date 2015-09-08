//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Kris Penney on 2015-09-07.
//  Copyright (c) 2015 Kris Penney. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

	var audioRecorder: AVAudioRecorder!
	var recordedAudio: RecordedAudio!
	
	@IBOutlet weak var recordingInProgressLabel: UILabel!
	@IBOutlet weak var loadingIcon: UIActivityIndicatorView!
	@IBOutlet weak var stopRecordingButton: UIButton!
	@IBOutlet weak var recordingButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
		
		if(flag){
			//save recorded audio
			
			recordedAudio = RecordedAudio()
			
			recordedAudio.filePathUrl = recorder.url
			recordedAudio.title = recorder.url.lastPathComponent
			
			//TODO: seque to effects
			
			performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
		}else{
			print("The audio wasn't recorded successfully")
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "stopRecordingSegue"){
			let playSoundsVC:PlayerViewController = segue.destinationViewController as! PlayerViewController
			let recordedAudio:RecordedAudio = sender as! RecordedAudio
			
			playSoundsVC.recievedAudioData = recordedAudio
		}
		
	}

	@IBAction func recordButtonClicked(sender: UIButton) {
		//Show the recording in progress label
		
		recordingInProgressLabel.hidden = false
		loadingIcon.startAnimating()
		stopRecordingButton.hidden = false
		recordingButton.enabled = false
		
		//Record the user's voice
		
		let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
		
		let recordingName = "voice_recording.wav"
		let pathArray = [dirPath, recordingName]
		let recordingPath = NSURL.fileURLWithPathComponents(pathArray)
		
		var session = AVAudioSession.sharedInstance()
		session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		
		audioRecorder = AVAudioRecorder(URL: recordingPath, settings: nil, error: nil)
		
		audioRecorder.delegate = self
		
		audioRecorder.meteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
		
	}

	@IBAction func stopRecording(sender: UIButton) {
		
		audioRecorder.stop()
		var audioSession = AVAudioSession.sharedInstance()
		audioSession.setActive(false, error: nil)
		
		
		stopRecordingButton.hidden = true
		loadingIcon.stopAnimating()
		recordingInProgressLabel.hidden = true
		recordingButton.enabled = true
		
	}
	
}

