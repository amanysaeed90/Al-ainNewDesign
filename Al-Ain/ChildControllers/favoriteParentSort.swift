//
//  favoriteParentSort.swift
//  Al-Ain
//
//  Created by al-ain nine on 9/1/20.
//  Copyright © 2020 egygames. All rights reserved.
//

import UIKit
import FittedSheets

class favoriteParentSort: UIViewController {
    @IBOutlet weak var segmentedtabs: UISegmentedControl!
    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var editfavoriteSectionsBtn: RoundedCornerButton!
    var edit = 0
    
    private lazy var favoriteBytimeVController: FavoritesVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var favoriteBySectinVController: SavedVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SavedVC") as! SavedVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func setupView() {
        updateView()
        setupSegmentedControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.segmentedtabs.selectedSegmentIndex = UISegmentedControlNoSegment

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        editfavoriteSectionsBtn.setTitle("chosesection".localized(), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    private func setupSegmentedControl() {
        
        // Configure Segmented Control
        let font = Fonts.getFont(fontSize: 12)
        segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)],for: .normal)
        segmentedtabs.setTitleTextAttributes([NSAttributedStringKey.font: font,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],for: .selected)
        segmentedtabs.layer.borderWidth = 1.0
        segmentedtabs.layer.cornerRadius = 5.0
        segmentedtabs.layer.borderColor = #colorLiteral(red: 0.4979951382, green: 0.4980683923, blue: 0.4979720712, alpha: 1).cgColor
        segmentedtabs.layer.masksToBounds = true
        
        segmentedtabs.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedtabs.selectedSegmentIndex = 0
        // Select First Segment
       
        
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
            remove(asChildViewController: favoriteBySectinVController)
            add(asChildViewController: favoriteBytimeVController)
        } else {
            remove(asChildViewController: favoriteBytimeVController)
            add(asChildViewController: favoriteBySectinVController)
        }
    }
   
    @IBAction func editfavoriteSectionsAction(_ sender: Any) {

        self.segmentedtabs.selectedSegmentIndex = 0
        let sectionController = self.storyboard?.instantiateViewController(withIdentifier: "SectionsVC") as!  SectionsVC
       // self.present(sectionController, animated: true, completion: nil)
        self.navigationController?.pushViewController(sectionController, animated:true)
        
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
