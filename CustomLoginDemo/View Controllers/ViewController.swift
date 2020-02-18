//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by user163072 on 1/8/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    //Override
    override func viewWillAppear(_ animated: Bool) {
        //Setup Video in Background
        setUpVideo()
    }
    
    func setUpElements(){
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }

    func setUpVideo(){
        
        //Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "csidrone_03", ofType: "mp4")
        
        guard bundlePath != nil else{
            return
        }
        //Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //Create the video player item
        let item = AVPlayerItem(url: url)
        
        //Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        //videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }
}

