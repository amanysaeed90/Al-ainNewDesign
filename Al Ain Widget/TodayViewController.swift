//
//  TodayViewController.swift
//  Al Ain Widget
//
//  Created by amany elhadary on 1/21/19.
//  Copyright © 2019 egygames. All rights reserved.
//





import UIKit
import NotificationCenter
import Foundation


class TodayViewController: UIViewController, NCWidgetProviding {
    


    @IBOutlet weak var widgetTable: UITableView!
    var items : [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded

        // Do any additional setup after loading the view from its nib.
    }
    
    func performUpdate() {
        let jsonObject: [Any]  = [
            [
                "id": "13466",
                "name": "سياسة"
             
            ]
        ]
        var taxonomy:Taxonomy = Taxonomy(id: "13466", name: "سياسة",color:"#f63ea1",logo:"https://cdn.al-ain.com/sections/politics.jpg", type: .SECTION)
        taxonomy.setValue("13466", forKey: "id")
        taxonomy.name = "سياسة"
        
        APIManager.getArticles(taxonomy: taxonomy, page: 0, suceess: { (articles:[Article]) in
            self.items = articles
            self.widgetTable.reloadData()
        } ){ (error:Error?) in
           
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        performUpdate()
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
       
        completionHandler(NCUpdateResult.newData)
    }
    // widget hight expand when press more
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 300)
        }
    }
    
}
extension TodayViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* So far empty, but we could implement this function so that we open the App and jump to the detail, when clicked */
    }
    
}
