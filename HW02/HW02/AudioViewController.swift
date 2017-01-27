//
//  AudioViewController.swift
//  HW02
//
//  Created by Akash Ungarala on 7/24/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import Jukebox

class AudioViewController: UIViewController, JukeboxDelegate {
    
    var playStatus:Bool! = true
    var selectedStory:Story!
    
    @IBOutlet weak var audioTitle: UILabel!
    @IBOutlet weak var play: UIButton!
    
    @IBAction func addClicked(sender: UIButton) {
        if let link = selectedStory.link {
            AppDelegate.playList.append(selectedStory)
            AppDelegate.audioPlayer.append(item: JukeboxItem(URL: NSURL(string: link)!), loadingAssets: true)
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let story = selectedStory where selectedStory != nil {
            audioTitle.text = story.title
            AppDelegate.audioPlayer = Jukebox(delegate: self, items: [JukeboxItem(URL: NSURL(string: story.link!)!)])
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