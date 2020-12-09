//
//  MediaVC.swift
//  Al-Ain
//
//  Created by amany elhadary on 7/11/19.
//  Copyright © 2019 egygames. All rights reserved.
//
//
import UIKit
import Pageboy
var FromMedia = false
import Tabman

final class MediaVC: TabmanViewController , PageboyViewControllerDataSource, TMBarDataSource  {
    
     var childs:[UIViewController] = []
     static var  sharedMedia:MediaVC?
    var viewControllers = [UIViewController]()
    @IBOutlet weak var tabmanView: UIView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabmanView.layer.shadowColor = UIColor.black.cgColor
        tabmanView.layer.shadowOpacity = 0.3
        tabmanView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)

        tabmanView.layer.shadowOffset = CGSize.zero
        tabmanView.layer.shadowRadius = 3
        
        self.dataSource = self

        let bar = TMBar.ButtonBar()
       
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
    
        bar.indicator.overscrollBehavior = .bounce
        bar.layout.interButtonSpacing = 0
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right:0.0)
        bar.layout.alignment = .centerDistributed
        bar.buttons.customize{(button) in
            button.selectedTintColor = #colorLiteral(red: 0.3293722868, green: 0.329434514, blue: 0.3293683529, alpha: 1)
            button.tintColor = #colorLiteral(red: 0.4744554758, green: 0.4745410681, blue: 0.4744500518, alpha: 1)
            button.font =  Fonts.getFont(fontSize: 17)
        }
        addBar(bar, dataSource: self, at: .custom(view: self.tabmanView, layout: nil))
        
        
       // setupTopBarColors()
       // settabsTitels()
        MediaVC.sharedMedia = self
    }
    
    /*func settabsTitels(){
        
        var items:[Item] = []
        self.dataSource = self
        let taxonomy = Taxonomy()
        taxonomy.type = .VIDEO
       
        let sectionController = self.storyboard?.instantiateViewController(withIdentifier: "SectionController") as!  SectionController
        sectionController.setTaxonomy(taxonomy: taxonomy)
        sectionController.launchedAsStandAlone = true
        FromMedia = true
        let PhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotosVC") as! PhotosVC
        self.childs.insert(PhotoVC,at:0)
        let InfoGraphVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoGraphVC") as! InfoGraphVC
        self.childs.insert(InfoGraphVC,at:1)
        let VedioVC  = self.storyboard?.instantiateViewController(withIdentifier: "MediaTypesVC") as! MediaTypesVC
        self.childs.insert(VedioVC,at:2)
      
            let item = Item(title: "فيديو")
            items.insert(item,at:0)
            let item2 = Item(title: "انفوجراف")
            items.insert(item2,at:0)
            let item1 = Item(title: "صور")
            items.insert(item1,at:0)
         
       
        self.bar.items = items
        
        self.reloadPages()
        
    }
    func setupTopBarColors(){
        
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            // indicator
            appearance.indicator.bounces = false
            appearance.indicator.compresses = false
            appearance.indicator.isProgressive = false
            appearance.indicator.useRoundedCorners = true
            appearance.indicator.lineWeight = .thick
            appearance.indicator.color = #colorLiteral(red: 0.8667604327, green: 0.2418957055, blue: 0.3131921291, alpha: 1)
            
            // state
            appearance.state.selectedColor = #colorLiteral(red: 0.8667604327, green: 0.2418957055, blue: 0.3131921291, alpha: 1)
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
            appearance.layout.minimumItemWidth = (UIScreen.main.bounds.width / 3)
           
        })
    }*/
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        
        let homeView  = self.storyboard?.instantiateViewController(withIdentifier: "MediaTypesVC") as! MediaTypesVC
        let FeaturedVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoGraphVC") as! InfoGraphVC

        let TrendVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotosVC") as! PhotosVC
    

        viewControllers.append(TrendVC)
        viewControllers.append(FeaturedVC) // كروناFeaturedVC
        viewControllers.append(homeView)
        
        
       return  viewControllers.count
    }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        var title = ""
     
        if (index == 0)
        {
            title  =  "Photos".localized()

        }
        if (index == 1)
        {
            title  = "InfoGraph".localized()

        }
        if (index == 2)
        {
            title  = "Vedio".localized()

        }
        return TMBarItem(title: title)
    }

    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        if(taxonomiesResponse != nil) {
//            return  Page.at(index: (homeTaxonomies.count - 1))
//        }
    
//        if Localize.currentLanguage() == "en" {
//
          // return  Page.at(index: 3)
//
//        }
//        else {
//        return  Page.at(index: ( 3))
//        }
//
        return nil
        
    }
    
    
    
}


/*extension MediaVC: PageboyViewControllerDataSource{
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
        return  Page.at(index: (2))

        
    }
    
    
    
}*/
// MAK: - UITableDelegate
   
