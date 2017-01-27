//
//  ProgramsTableViewController.swift
//  HW02
//
//  Created by Akash Ungarala on 7/24/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ProgramsTableViewController: UITableViewController {
    
    var programs = [Program]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.npr.org/list?id=3004&output=JSON"
        if let sourceUrl = NSURL(string: url) {
            if let data = try? NSData(contentsOfURL: sourceUrl, options: []) {
                let json = JSON(data:data)
                let items = json["item"]
                for item in items.arrayValue {
                    let program = Program()
                    program.id = Int(item["id"].stringValue)
                    if let itemTitle = item["title"].dictionary {
                        guard let title = itemTitle["$text"]?.stringValue else {
                            continue
                        }
                        program.title = title
                    }
                    programs.append(program)
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
        return programs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("programsIdentifier", forIndexPath: indexPath)
        (cell.viewWithTag(1) as? UILabel)?.text = programs[indexPath.row].title
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "storiesSegue" {
            if let destination = segue.destinationViewController as? StoriesTableViewController  {
                destination.selectedProgramId = programs[self.tableView.indexPathForSelectedRow!.row].id!
            }
        }
    }
    
}