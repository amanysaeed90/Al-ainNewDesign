//
//  PagerCell.swift
//  Al-Ain
//
//  Created by amany elhadary on 4/24/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import  CHIPageControl
import Localize_Swift
class PagerCell: UITableViewCell {
    var articel:[Article]?
    @IBOutlet weak var collectionView: UICollectionView!
    var peekImplementation: MSPeekCollectionViewDelegateImplementation!
    var parentViewController : HomePageViewController?
    @IBOutlet weak var PageController: CHIPageControlPuya!
    
    @IBOutlet weak var hight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        peekImplementation = MSPeekCollectionViewDelegateImplementation()
        peekImplementation.delegate = self
        collectionView.configureForPeekingDelegate()
        collectionView.delegate = peekImplementation
        collectionView.dataSource = self
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{
            PageController.set(progress: 0, animated: false)

        }
        else
        {
        PageController.set(progress: 3, animated: false)
        }
        
    }
    
      var flowLayout: UICollectionViewFlowLayout {
          return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
      }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    
}
extension PagerCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "pagercontentCell", bundle: Bundle.main), forCellWithReuseIdentifier: "pagercontentCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagercontentCell", for: indexPath) as! pagercontentCell
        cell.configureWithData(articel![indexPath.row])
       

        return cell
    }
  
    
    
}

extension PagerCell: MSPeekImplementationDelegate {
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didChangeActiveIndexTo activeIndex: Int) {
        print("Changed active index to \(activeIndex)")
        self.PageController.set(progress: activeIndex, animated: true)
    }
    
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
        AppUtils.launchSingleArticleView(articleId: articel![indexPath.row].id!, controller: RootViewController.shared!)
        
    }
}
