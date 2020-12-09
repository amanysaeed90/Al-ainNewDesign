//
//  NotificationItemCell.swift
//  Al-Ain
//
//  Created by Alex on 7/3/18.
//  Copyright © 2018 egygames. All rights reserved.
//

import UIKit

class NotificationItemCell: UITableViewCell {

    @IBOutlet weak var ArrowImage: UIImageView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescLabel: UILabel!
    @IBOutlet weak var newsTypeLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!

    var articleID: String!
    
    func configure(with notificationItems: NotificationItem) {
        if let id = notificationItems.articleId {
            articleID = "\(id)"
        }
        if let image = notificationItems.details?.fullImage{
            newsImage.kf.setImage(with: URL(string:image),options: [.transition(.fade(0.0))])
        }
        else
        {
            newsImage.image = UIImage(named: "DemoNotification")
            //DemoNotification
        }
        if let title = notificationItems.created {
           // newsTitleLabel.text = title
            let date = Date(timeIntervalSince1970: TimeInterval(title))
            newsTitleLabel.text = "\(date.timeAgoSinceNow)"

        }
        if let body = notificationItems.title {
            newsDescLabel.text = body.htmlToString
        }
        if let date = notificationItems.created {
            
           // datelabel.text = date.timeAgoSinceNow
        }
    }
}
extension String{
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
