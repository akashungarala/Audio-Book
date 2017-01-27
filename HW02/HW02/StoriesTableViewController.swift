//
//  StoriesTableViewController.swift
//  HW02
//
//  Created by Akash Ungarala on 7/24/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class StoriesTableViewController: UITableViewController {
    
    var selectedProgramId:Int! = 0
    let apiKey:String! = "MDI1NDE5NjQ1MDE0NjkxMTI5MDQ4ZmJjOA000"
    
    var stories = [Story]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.npr.org/query?id=\(selectedProgramId)&dateType=story&output=JSON&apiKey=\(apiKey)"
        if let sourceUrl = NSURL(string: url) {
            if let data = try? NSData(contentsOfURL: sourceUrl, options: []) {
                let json = JSON(data:data)
                let list = json["list"]
                let storiesList = list["story"]
                for storyItem in storiesList.arrayValue {
                    let story = Story()
                    if let title = storyItem["title"].dictionary {
                        guard let titleText = title["$text"]?.stringValue else {
                            continue
                        }
                        story.title = titleText
                    } else {
                        story.title = ""
                    }
                    if let smallImage = storyItem["thumbnail"].dictionary {
                        if let smallImageMedium = smallImage["medium"]?.dictionary {
                            guard let smallImageMediumText = smallImageMedium["$text"]?.stringValue else {
                                continue
                            }
                            story.image = smallImageMediumText
                        } else {
                            story.image = ""
                        }
                    } else {
                        story.image = ""
                    }
                    if let audios = storyItem["audio"].array {
                        for audio in audios {
                            if let audioformat = audio["format"].dictionary {
                                if let mp3format = audioformat["mp3"]?.array {
                                    if let param = mp3format[0].dictionary{
                                        let value = param["$text"]?.stringValue
                                        let val = value?.componentsSeparatedByString("?")
                                        story.link = val![0]
                                    } else {
                                        story.link = ""
                                    }
                                } else {
                                    story.link = ""
                                }
                            } else {
                                story.link = ""
                            }
                        }
                    } else {
                        story.link = ""
                    }
                    stories.append(story)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("storiesIdentifier", forIndexPath: indexPath)
        if stories[indexPath.row].image! != "" {
            if let imageURL:NSURL? = NSURL(string: stories[indexPath.row].image!) {
                if let url = imageURL {
                    (cell.viewWithTag(1000) as? UIImageView)?.sd_setImageWithURL(url)
                }
            }
        }
        (cell.viewWithTag(2000) as? UILabel)?.text = stories[indexPath.row].title
        if stories[indexPath.row].link != "" {
            (cell.viewWithTag(3000) as? UIButton)?.setImage(UIImage(named: "audio"), forState: .Normal)
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "audioSegue" {
            let destination = segue.destinationViewController as? AudioViewController
            destination!.selectedStory =  stories[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
}