//
//  SegmentedFavortiteContainer.swift
//  Al-Ain
//
//  Created by al-ain nine on 9/1/20.
//  Copyright © 2020 egygames. All rights reserved.
//

import UIKit

class SegmentedFavortiteContainer: UIViewController {
    
    @IBOutlet weak var segmentedtabs: UISegmentedControl!
    
    @IBOutlet weak var containerview: UIView!
    
    private lazy var favoriteParentSortVController: favoriteParentSort = {
           // Load Storyboard
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           
           // Instantiate View Controller
           var viewController = storyboard.instantiateViewController(withIdentifier: "favoriteParentSort") as! favoriteParentSort
           
           // Add View Controller as Child View Controller
           self.add(asChildViewController: viewController)
           
           return viewController
       }()
       
       private lazy var SavedVController: SavedVC = {
           // Load Storyboard
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           
           // Instantiate View Controller
           var viewController = storyboard.instantiateViewController(withIdentifier: "SavedVC") as! SavedVC
           
           // Add View Controller as Child View Controller
           self.add(asChildViewController: viewController)
           
           return viewController
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           //setupView()
        if #available(iOS 13.0, *) {
                   self.setnavigationWhite_tintGray()
               } else {
                   // Fallback on earlier versions
               }

    }
    private func setupSegmentedControl() {
        
 // Configure Segmented Control
        let font = Fonts.getFont(fontSize: 12)
       segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.213373214, green: 0.2447268963, blue: 0.4772051573, alpha: 1)],for: .normal)
       segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],for: .selected)
        segmentedtabs.layer.borderWidth = 1.0
       segmentedtabs.layer.cornerRadius = 5.0
       segmentedtabs.layer.borderColor = #colorLiteral(red: 0.213373214, green: 0.2447268963, blue: 0.4772051573, alpha: 1).cgColor
       segmentedtabs.layer.masksToBounds = true
        segmentedtabs.setTitle("FavoriteSections".localized(), forSegmentAt: 0)
        segmentedtabs.setTitle("SavedNews".localized(), forSegmentAt: 1)

            segmentedtabs.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
            // Select First Segment
           // segmentedtabs.selectedSegmentIndex = 1
        
      
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
           remove(asChildViewController: SavedVController)
            add(asChildViewController: favoriteParentSortVController)
        } else {
           remove(asChildViewController: favoriteParentSortVController)
            add(asChildViewController: SavedVController)
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
