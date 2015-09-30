//
//  ViewController.swift
//  GoatLamp
//
//  Created by Michael Recachinas on 9/12/15.
//  Copyright (c) 2015 Michael Recachinas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var editBtn: UIButton!
    var editEnabled: Bool = false

    @IBOutlet weak var topNextBtn: UIButton!
    @IBOutlet weak var topPrevBtn: UIButton!
    @IBOutlet weak var midNextBtn: UIButton!
    @IBOutlet weak var midPrevBtn: UIButton!
    @IBOutlet weak var botNextBtn: UIButton!
    @IBOutlet weak var botPrevBtn: UIButton!
    
    var topImageArray: [UIImage]!
    var midImageArray: [UIImage]!
    var botImageArray: [UIImage]!
    
    var topIdx: Int = 0
    var midIdx: Int = 0
    var botIdx: Int = 0
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var midImageView: UIImageView!
    @IBOutlet weak var botImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideEditBtns()
        
        let img1: UIImage = UIImage(named: "top1")!
        let img2: UIImage = UIImage(named: "top2")!
        let img3: UIImage = UIImage(named: "top3")!
        
        topImageArray = [img1, img2, img3]
        midImageArray = [img1, img2, img3]
        botImageArray = [img1, img2, img3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func hideEditBtns() {
        topNextBtn.hidden = true
        topPrevBtn.hidden = true
        midNextBtn.hidden = true
        midPrevBtn.hidden = true
        botNextBtn.hidden = true
        botPrevBtn.hidden = true
    }
    
    func showEditBtns() {
        topNextBtn.hidden = false
        topPrevBtn.hidden = false
        midNextBtn.hidden = false
        midPrevBtn.hidden = false
        botNextBtn.hidden = false
        botPrevBtn.hidden = false
    }
    
    @IBAction func enableEdit(sender: UIButton) {
        if editEnabled {
            hideEditBtns()
            editBtn.setTitle("Edit", forState: UIControlState.Normal)
        } else {
            showEditBtns()
            editBtn.setTitle("Done", forState: UIControlState.Normal)
        }
        editEnabled = !editEnabled
    }
    
    @IBAction func nextAction(sender: UIButton) {
        switch(sender) {
            case topNextBtn:
                topIdx = (topIdx + 1) % topImageArray.count
                updateImage(topIdx, imageView: topImageView, imageArray: topImageArray)
                break
            case midNextBtn:
                midIdx = (midIdx + 1) % midImageArray.count
                updateImage(midIdx, imageView: midImageView, imageArray: midImageArray)
                break
            case botNextBtn:
                botIdx = (botIdx + 1) % botImageArray.count
                updateImage(botIdx, imageView: botImageView, imageArray: botImageArray)
                break
            default:
                break
        }
    }

    @IBAction func prevAction(sender: UIButton) {
        switch(sender) {
            case topPrevBtn:
                topIdx = (topIdx - 1) % topImageArray.count
                updateImage(topIdx, imageView: topImageView, imageArray: topImageArray)
                break
            case midPrevBtn:
                midIdx = (midIdx - 1) % midImageArray.count
                updateImage(midIdx, imageView: midImageView, imageArray: midImageArray)
                break
            case botPrevBtn:
                botIdx = (botIdx - 1) % botImageArray.count
                updateImage(botIdx, imageView: botImageView, imageArray: botImageArray)
                break
            default:
                break
        }
    }
    
    func updateImage(idx: Int, imageView: UIImageView, imageArray: [UIImage]) {
        imageView.image = imageArray[idx]
    }
    
    @IBAction func toggleTorch(sender: UIButton) {
        print("toggleTorch")
        let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        // check if the device has torch
        if let avD = avDevice {
            if  avD.hasTorch {
                do {
                    // lock your device for configuration
                    try avD.lockForConfiguration()
                } catch _ {
                }
                // check if your torchMode is on or off. If on turns it off otherwise turns it on
                avD.torchMode = avDevice.torchActive ? AVCaptureTorchMode.Off : AVCaptureTorchMode.On
                do {
                    // sets the torch intensity to 100%
                    try avD.setTorchModeOnWithLevel(1.0)
                } catch _ {
                }
                // unlock your device
                avD.unlockForConfiguration()
            }
        } else {
            print("avDevice is nil")
        }
    }
}

