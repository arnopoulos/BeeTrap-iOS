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
	
	lazy var data = NSMutableData()

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		textField.text = "";
		return true
	}

	func textFieldDidEndEditing(textField: UITextField) {
		startValidation(addressLabel.text)
	}
	
	func startValidation(address:String) {
		
		let htmlTag = "?address=" + address
		
		let addressString = "https://bee-trap.herokuapp.com/users/2/wallet.json" + htmlTag
//		let addressString = "http://www.arnopoulos.io/test"
		println(addressString)
		let url = NSURL(string: addressString)
		let request  = NSMutableURLRequest()
		request.URL = url
		request.HTTPMethod = "GET"
		
		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
			if error == nil {
				var err: AutoreleasingUnsafeMutablePointer<NSError?> = nil
				let jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error: err) as? NSDictionary
				
				if let jsonResult = jsonResult {
					println(jsonResult)
				} else {
					println("Cannot parse json.")
					println(err)
				}
				
			} else {
				println(error)
			}
		}
		
		
	}
	
}

