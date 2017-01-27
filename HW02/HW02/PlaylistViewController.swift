//
//  PlaylistViewController.swift
//  HW02
//
//  Created by Akash Ungarala on 7/24/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import Jukebox

class PlaylistViewController: UIViewController, JukeboxDelegate {
    
    var playStatus:Bool! = true
    
    @IBOutlet weak var audioTitle: UILabel!
    @IBOutlet weak var play: UIButton!
    
    @IBAction func removeClicked(sender: UIButton) {
        var count:Int! = 0
        for story in AppDelegate.playList {
            if story.link == AppDelegate.audioPlayer.currentItem?.URL.absoluteString {
                AppDelegate.playList.removeAtIndex(count)
            }
            count = count+1
        }
    }
    
    @IBAction func previousClicked(sender: UIButton) {
        AppDelegate.audioPlayer.playPrevious()
    }
    
    @IBAction func playClicked(sender: UIButton) {
        if playStatus == true {
            AppDelegate.audioPlayer.play()
            sender.setImage(UIImage(named: "pause"), forState: .Normal)
            playStatus = false
        } else if AppDelegate.audioPlayer.state == .Playing {
            AppDelegate.audioPlayer.pause()
            sender.setImage(UIImage(named: "play"), forState: .Normal)
            playStatus = true
        }
    }
    
    @IBAction func stopClicked(sender: UIButton) {
        play.setImage(UIImage(named: "play"), forState: .Normal)
        playStatus = true
        AppDelegate.audioPlayer.stop()
    }
    
    @IBAction func nextClicked(sender: UIButton) {
        AppDelegate.audioPlayer.playNext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var count:Int! = 0;
        for story in AppDelegate.playList {
            if count == 0 {
                AppDelegate.audioPlayer = Jukebox(delegate: self, items: [JukeboxItem(URL: NSURL(string: story.link)!)])
            } else {
                AppDelegate.audioPlayer.append(item: JukeboxItem(URL: NSURL(string: story.link)!), loadingAssets: true)
            }
            count = count+1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func jukeboxStateDidChange(state : Jukebox) {}
    func jukeboxPlaybackProgressDidChange(jukebox : Jukebox) {}
    func jukeboxDidLoadItem(jukebox : Jukebox, item : JukeboxItem) {}
    func jukeboxDidUpdateMetadata(jukebox : Jukebox, forItem: JukeboxItem) {}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {}
    
}