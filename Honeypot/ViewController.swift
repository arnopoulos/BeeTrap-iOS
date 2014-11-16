//
//  ViewController.swift
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/14/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet var addressLabel:UITextField! {
		didSet {
			addressLabel.delegate = self
		}
	}
	
	@IBOutlet var activityMonitor:UIActivityIndicatorView! {
		didSet {
			activityMonitor.hidesWhenStopped = true
		}
	}
	
	lazy var data = NSMutableData()
	
	@IBAction func resignKeyboardTapGesture(tapGesture:UITapGestureRecognizer) {
		if addressLabel.isFirstResponder() {
			addressLabel.resignFirstResponder()
		}
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func textFieldDidEndEditing(textField: UITextField) {
		if !addressLabel.text.isEmpty {
//			validateAddress(addressLabel.text)
		}
	}
	
//	func validateAddress(address:String) {
//		
//		let htmlTag = "?address=" + address
//		
////		let addressString = "https://bee-trap.herokuapp.com/users/2/wallet.json" + htmlTag
//		let addressString = "http://172.16.1.26:3000/users/2/wallet.json"
//		let url = NSURL(string: addressString)
//		let request  = NSMutableURLRequest()
//		request.URL = url
//		request.HTTPMethod = "GET"
//		
//		activityMonitor.startAnimating()
//		
//		
//		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
//			if error == nil {
//				var err: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//				let jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error: err) as? NSDictionary
//				
//				if let jsonResult = jsonResult {
//					//Check JSON for success
//					var success = false
//					
//					
//					if success {
//						//Reset addressLabel text
//						self.addressLabel.text = "";
//					}
//				} else {
//					println("Cannot parse json.")
//					println(err)
//				}
//				
//			} else {
//				println(error)
//			}
//			
//			self.activityMonitor.stopAnimating()
//		}
//		
//		
//	}
	
}

