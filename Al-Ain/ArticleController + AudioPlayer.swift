//
//  ArticleController + AudioPlayer.swift
//  Al-Ain
//
//  Created by imac on 11/13/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import PureLayout

extension ArticleController{
    
    func showAudioPlayer(){
        closeAudioPlayer!.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
        closeAudioPlayer!.setTitle(String.fontAwesomeIcon(name: .close), for: .normal)
   
        
        self.audioPlayer.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.audioPlayer.alpha = 1
        }, completion:  nil)
        
        

    }
    func setupAudioPlayer(){
        if player != nil {
            player?.play()
            return
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
       
        let url = URL(string: article.audioUrl!)
         player = AVPlayer(url: url!)
        let av = AVPlayerViewController()
        av.contentOverlayView?.backgroundColor = UIColor.black
    
        av.player = player
        self.addChildViewController(av)
        self.audioPlayer.addSubview(av.view)
        av.didMove(toParentViewController: self)
        av.view.autoPinEdge(toSuperviewEdge: .leading)
        av.view.autoPinEdge(toSuperviewEdge: .trailing)
        av.view.autoPinEdge(toSuperviewEdge: .bottom)
        let topConstriaint = av.view.autoPinEdge(toSuperviewEdge: .top)
        topConstriaint.constant = closeAudioPlayer.frame.size.height + 20
        player!.play()
        
    }
    @IBAction func closePlayer(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.audioPlayer.alpha = 0
        }, completion:  {
            (value: Bool) in
            self.audioPlayer.isHidden = true
        })
        player?.pause()
    }
    
}
