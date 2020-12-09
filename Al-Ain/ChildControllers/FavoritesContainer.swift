//
//  FavoritesContainer.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/7/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import Pageboy
import Tabman

class FavoritesContainer: TabmanViewController {
  var childs:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
            setupTopBarColors()
              settabsTitels()
              
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func settabsTitels(){
            
//            var items:[Item] = []
//            self.dataSource = self
//            let taxonomy = Taxonomy()
//            taxonomy.type = .VIDEO
//           
//            let sectionController = self.storyboard?.instantiateViewController(withIdentifier: "SectionController") as!  SectionController
//            sectionController.setTaxonomy(taxonomy: taxonomy)
//            sectionController.launchedAsStandAlone = true
//            FromMedia = true
//            
//            let SavedVC = self.storyboard?.instantiateViewController(withIdentifier: "SavedVC") as! SavedVC
//            self.childs.insert(SavedVC,at:0)
//              
//            let FavoritesVC  = self.storyboard?.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
//            self.childs.insert(FavoritesVC,at:1)
//          
//                let item = Item(title: "المفضلة")
//                items.insert(item,at:0)
//                let item1 = Item(title: "المحفوظة")
//                items.insert(item1,at:0)
//                
//           
//            self.bar.items = items
//            
//            self.reloadPages()
            
        }
        func setupTopBarColors(){
            
          /*  self.bar.appearance = TabmanBar.Appearance({ (appearance) in
                // indicator
                appearance.indicator.bounces = false
                appearance.indicator.compresses = false
                appearance.indicator.isProgressive = false
                appearance.indicator.useRoundedCorners = true
                appearance.indicator.lineWeight = .thick
                appearance.indicator.color = #colorLiteral(red: 0.4572013617, green: 0.7127934098, blue: 0.6917369962, alpha: 1)
                
                // state
                appearance.state.selectedColor = #colorLiteral(red: 0.3058823529, green: 0.4862745098, blue: 0.4784313725, alpha: 1)
                //r  appearance.state.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
                // text
                appearance.text.font = Fonts.getFont(fontSize: 15)
                // layout
                appearance.layout.height = .explicit(value: 36)
                appearance.layout.interItemSpacing = 0.0
                appearance.layout.edgeInset = 0.0
                appearance.layout.itemVerticalPadding = 0.0
                appearance.layout.itemDistribution = .leftAligned
                appearance.layout.extendBackgroundEdgeInsets = true
                // style
                appearance.style.background = .solid(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) //.blur(style: .extraLight).solid(color: Colors.primaryColor)
                appearance.style.bottomSeparatorColor = .clear
                
                // interaction
                appearance.interaction.isScrollEnabled = true
                
                //appearance.layout.itemDistribution = TabmanBar.Appearance.Layout.ItemDistribution.leftAligned
                appearance.layout.minimumItemWidth = (UIScreen.main.bounds.width / 2)
                // appearance.layout.interItemSpacing = 5.0
                //  appearance.layout.edgeInset = 0.0
                //             self.view.layer.shadowColor = UIColor.gray.cgColor
                //             self.view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                //             self.view.layer.shadowRadius = 1.5
                //             self.view.layer.shadowOpacity = 0.3
                //             self.view.layer.masksToBounds = false
                //
            })*/
        }
        
    }

    extension FavoritesContainer: PageboyViewControllerDataSource{
        /// The number of view controllers to display.
        ///
        /// - Parameter pageboyViewController: The Page view controller.
        /// - Returns: The total number of view controllers to display.
        func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
            return  childs.count
        }
        
        func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
            return childs[index]
        }
        
        func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
            return  Page.at(index: (1))

            
        }
        
        
        
    }
