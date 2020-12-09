//
//  AlltaxForFavoritesContanier.swift
//  Al-Ain
//
//  Created by al-ain nine on 9/1/20.
//  Copyright © 2020 egygames. All rights reserved.
//

import UIKit

class AlltaxForFavoritesContanier: UIViewController {
    @IBOutlet weak var segmentedtabs: UISegmentedControl!
     @IBOutlet weak var containerview: UIView!
    
    private lazy var Sections: MoreTaxonomiesViewController = {
        let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
        moreTaxonomiesViewController.taxonomyType = TaxonomyType.COUNTRY
        moreTaxonomiesViewController.title = "البلدان"
        moreTaxonomiesViewController.titleNav = "البلدان"
         // Instantiate View Controller
         // Add View Controller as Child View Controller
         self.add(asChildViewController: moreTaxonomiesViewController)
         return moreTaxonomiesViewController
         }()
         
         private lazy var Pages: MoreTaxonomiesViewController = {
             // Load Storyboard
            
            let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
            moreTaxonomiesViewController.taxonomyType = TaxonomyType.COUNTRY
            moreTaxonomiesViewController.title = "البلدان"
            moreTaxonomiesViewController.titleNav = "البلدان"
             // Instantiate View Controller
             
             // Add View Controller as Child View Controller
             self.add(asChildViewController: moreTaxonomiesViewController)
             
             return moreTaxonomiesViewController
         }()
      
    private lazy var Hashtags: MoreTaxonomiesViewController = {
             // Load Storyboard
        let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
        moreTaxonomiesViewController.taxonomyType = TaxonomyType.COUNTRY
        moreTaxonomiesViewController.title = "البلدان"
        moreTaxonomiesViewController.titleNav = "البلدان"
         // Instantiate View Controller
         // Add View Controller as Child View Controller
         self.add(asChildViewController: moreTaxonomiesViewController)
        return moreTaxonomiesViewController
        

         }()
         
         private lazy var Countries: MoreTaxonomiesViewController = {
             // Load Storyboard
            let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
            moreTaxonomiesViewController.taxonomyType = TaxonomyType.COUNTRY
            moreTaxonomiesViewController.title = "البلدان"
            moreTaxonomiesViewController.titleNav = "البلدان"
             // Instantiate View Controller
             // Add View Controller as Child View Controller
             self.add(asChildViewController: moreTaxonomiesViewController)
            return moreTaxonomiesViewController
            
         }()
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    private func setupSegmentedControl() {
           
    // Configure Segmented Control
          let font = Fonts.getFontNormal(fontSize: 13)
          segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.213373214, green: 0.2447268963, blue: 0.4772051573, alpha: 1)],for: .normal)
          segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],for: .selected)
          segmentedtabs.layer.borderWidth = 1.0
          segmentedtabs.layer.cornerRadius = 5.0
          segmentedtabs.layer.borderColor = #colorLiteral(red: 0.213373214, green: 0.2447268963, blue: 0.4772051573, alpha: 1).cgColor
          segmentedtabs.layer.masksToBounds = true

               segmentedtabs.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
               // Select First Segment
               segmentedtabs.selectedSegmentIndex = 3
           
         
       }
       
       @objc func selectionDidChange(_ sender: UISegmentedControl) {
           updateView()
       }
      
       private func add(asChildViewController viewController: UIViewController) {
           // Configure Child View

         viewController.view.frame = CGRect(x: 0, y: 0, width: self.containerview.frame.size.width, height: self.containerview.frame.size.height)

           // Add Child View Controller
           addChildViewController(viewController)
           
           // Add Child View as Subview
           self.containerview.addSubview(viewController.view)
           
     
           // Notify Child View Controller
           viewController.didMove(toParentViewController: self)
       }
       
       private func remove(asChildViewController viewController: UIViewController) {
           // Notify Child View Controller
           viewController.willMove(toParentViewController: nil)
           
           // Remove Child View From Superview
           viewController.view.removeFromSuperview()
           
           // Notify Child View Controller
           viewController.removeFromParentViewController()
       }
       
       private func updateView() {
           if segmentedtabs.selectedSegmentIndex == 0 {
              remove(asChildViewController: Sections)
               add(asChildViewController: Pages)
           } else if segmentedtabs.selectedSegmentIndex == 1 {

              remove(asChildViewController: Pages)
               add(asChildViewController: Sections)
           }
        else if segmentedtabs.selectedSegmentIndex == 2 {

           remove(asChildViewController: Pages)
            add(asChildViewController: Sections)
        }
        else if segmentedtabs.selectedSegmentIndex == 3 {

           remove(asChildViewController: Pages)
            add(asChildViewController: Sections)
        }
       }
       private func setupView() {
            updateView()
           setupSegmentedControl()
          
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
