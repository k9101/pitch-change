//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Kris Penney on 2015-09-07.
//  Copyright (c) 2015 Kris Penney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var recordingInProgressLabel: UILabel!
	@IBOutlet weak var loadingIcon: UIActivityIndicatorView!
	@IBOutlet weak var stopRecordingButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func recordButtonClicked(sender: UIButton) {
		//Show the recording in progress label
		
		recordingInProgressLabel.hidden = false
		loadingIcon.startAnimating()
		stopRecordingButton.hidden = false
		
		//TODO: Record the user's voice
	}

	@IBAction func stopRecording(sender: UIButton) {
		
		stopRecordingButton.hidden = true
		loadingIcon.stopAnimating()
		recordingInProgressLabel.hidden = true
		
	}
	
}

