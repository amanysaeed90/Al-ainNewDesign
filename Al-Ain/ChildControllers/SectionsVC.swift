//
//  SectionsVC.swift
//  Al-Ain
//
//  Created by amany elhadary on 7/11/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class SectionsVC: UIViewController {
    var hidingNavBarManager: HidingNavigationBarManager?
    let width = Int( UIScreen.main.bounds.width)
    let height = Int( UIScreen.main.bounds.height)
    var taxonmies :TaxonomyResponse?
    @IBOutlet weak var NetEror: WarningView!

    func getTaxonmies(){
        // setSegmentedAsPagger()
        self.NetEror.isHidden = true

        // SwiftOverlays.showBlockingWaitOverlayWithText("جار التحميل")
      //  if Reachability.isConnectedToNetwork() == true {
            
            APIManager.getTaxonimies(suceess: { (response:TaxonomyResponse) in
                self.taxonmies =  response
                self.removeSpinner()
                self.collectionView.reloadData()
               
                
            }) { (error:Error?) in
                if let tx = self.taxonmies {

                if (self.taxonmies?.sections.count == 0){
                 self.NetEror.isHidden = false
                }
                }
                else
                {
                    self.NetEror.isHidden = false

                }
            }
     //   }
        /*else
        {
           
                       self.removeSpinner()
            
                       //Realm
                    if let tx = self.taxonmies {
            if (self.taxonmies?.sections.count == 0){
                           self.NetEror.isHidden = false
                       }
            }
            else
                    {
                        self.NetEror.isHidden = false

            }
            
            
        }
        */
        
    }
    @objc func retryGetData (){
           self.showSpinner(onView: self.view)
           self.getTaxonmies()
           
       }
    override func viewWillAppear(_ animated: Bool) {
        
      
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            self.setnavigationWhite()
        } else {
            // Fallback on earlier versions
        }

        hidingNavBarManager?.viewWillAppear(animated)
        if let tx = self.taxonmies {
        if (self.taxonmies?.sections.count == 0){
                   self.showSpinner(onView: self.view)
                    self.getTaxonmies()
               }
               else {
                   if Reachability.isConnectedToNetwork() == true {
                       self.getTaxonmies()
                   }
            
               }
        }
        else
        {
                self.getTaxonmies()
            
        }
      
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidingNavBarManager?.viewDidLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       hidingNavBarManager?.viewWillDisappear(animated)

    }
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        return true
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: self.view)
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "خطآ بالاتصال بالشبكة"
        NetEror.DescriptionText = "جهازك غير متصل بالإنترنت ، يرجى التأكد من أن اتصالك يعمل."
        NetEror.tryagainbtn.isHidden = false
        NetEror.tryagainbtn.addTarget(self, action: #selector(retryGetData), for: .touchUpInside)
        
        self.collectionView.register(UINib(nibName:"SectionNameCell" , bundle: nil), forCellWithReuseIdentifier:"SectionNameCell" )
        collectionView.delegate = self
        collectionView.dataSource = self
  
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SectionsVC : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let section = self.taxonmies?.sections[indexPath.row]
        FromTypeSection = false
        AppUtils.launchSectionViewController( taxonomy:section , controller:self  )
    }
    
    
}
extension SectionsVC : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taxonmies?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionNameCell", for: indexPath) as? SectionNameCell else {
            fatalError("Expected SectionNameCell type for reuseIdentifier SectionNameCell. Check the configuration in Main.storyboard.")
        }
        let section = self.taxonmies?.sections[indexPath.row]
        let id = section?.id
        
        var tempsection = Taxonomy()
        cell.configureCell(Section: section ?? tempsection)
      
        
        
        return cell
    }
}
extension SectionsVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let xx = ( Double(width) * 0.50 ) - 25
        return CGSize(width: Int( xx) , height: Int( xx) )
     
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0 , right: 15)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
    
    
}
