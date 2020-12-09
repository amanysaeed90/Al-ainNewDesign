//
//  File.swift
//  Al-Ain
//
//  Created by imac on 9/13/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
class MoreTaxonomiesViewController: UIViewController ,UISearchBarDelegate{
    @IBOutlet weak var SearchView: UIView!
   /* func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        //        filteredArray = taxonmies.filter({ (country) -> Bool in
        //            let countryText: Taxonomy = country
        //
        //            return ((countryText.name)?.rangeOfCharacter(from: "", options: NSString.CompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        //        })
        //
        // Reload the tableview.
        tableView.reloadData()
    }*/
    
    var currentPage = 0
    @IBOutlet weak var tableView: ScrollStopTableView!
    var titleNav : String?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let cellReuseIdentifier = "MenuItemCell"
    var taxonomyType:TaxonomyType = .TAG
    var taxonmies :[Taxonomy] = []
    
    
    
    var filteredArray = [Taxonomy]()
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
         //   self.setnavigationWhite_tintGray()
            
        }
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupLoadMore()
        loadTaxonomies();
        //    automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 1
        navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        navigationController?.navigationBar.layer.shadowRadius = 2
        navigationController?.navigationBar.layer.masksToBounds = false
        
        
        configureSearchController()
        becomeFirstResponder()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            self.setnavigationWhite_tintGray()}
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //        if #available(iOS 13.0, *) {
        //                                                                 let app = UIApplication.shared
        //                                                                 let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        //
        //                                                                 let statusbarView = UIView()
        //                                                                 statusbarView.backgroundColor = UIColor.white
        //                                                 self.view.addSubview(statusbarView)
        //
        //                                                                 statusbarView.translatesAutoresizingMaskIntoConstraints = false
        //                                                                 statusbarView.heightAnchor
        //                                                                   .constraint(equalToConstant: statusBarHeight).isActive = true
        //                                                                 statusbarView.widthAnchor
        //                                                                     .constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        //                                                                 statusbarView.topAnchor
        //                                                                     .constraint(equalTo: self.view.topAnchor).isActive = true
        //                                                                 statusbarView.centerXAnchor
        //                                                                     .constraint(equalTo: self.view.centerXAnchor).isActive = true
        //
        //                                                              } else {
        //                                                                    let statusBar = UIApplication.shared.value(forKeyPath:
        //                                                                 "statusBarWindow.statusBar") as? UIView
        //                                                                     statusBar?.backgroundColor = UIColor.white
        //                                                              }
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2627197802, green: 0.2627618313, blue: 0.2627065182, alpha: 1)
            , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
            ] as [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.topItem?.title = self.titleNav
        // self.navigationController?.presentTransparentNavigationBar()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2627197802, green: 0.2627618313, blue: 0.2627065182, alpha: 1)
    }
    func configureSearchController() {
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
       searchBar.placeholder = "بحث"
        searchBar.delegate = self
//        searchController.dimsBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
        extendedLayoutIncludesOpaqueBars = true
       searchBar.keyboardAppearance = .default
        
       searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
       searchBar.sizeToFit()
        searchBar.semanticContentAttribute = .forceRightToLeft
        UISearchBar.appearance().barTintColor = .white
      searchBar.showsCancelButton = false
        
        

        let textFieldInsideUISearchBar = self.searchBar.value(forKey: "searchField") as? UITextField

        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.font = Fonts.getFontNormal(fontSize: 13)
        textFieldInsideUISearchBar?.backgroundColor = UIColor.white
         textFieldInsideUISearchBar?.layer.borderWidth = 1.0
         textFieldInsideUISearchBar?.layer.borderColor = #colorLiteral(red: 0.4783889055, green: 0.478459537, blue: 0.478366673, alpha: 1)
        textFieldInsideUISearchBar?.layer.cornerRadius = 5
        textFieldInsideUISearchBar?.frame.size.height = 43
     // searchBar.frame.size.height = 100
    
            
        
        textFieldInsideUISearchBar?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            (textFieldInsideUISearchBar?.heightAnchor.constraint(equalTo: searchController.searchBar.heightAnchor,
//                                                                 multiplier: 1.0, constant: 10.0))!,
//            (textFieldInsideUISearchBar?.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 10.0))!,
//            (textFieldInsideUISearchBar?.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -10.0))!,
//            (textFieldInsideUISearchBar?.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 10.0))!,
//            (textFieldInsideUISearchBar?.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10.0))!

        ])
        textFieldInsideUISearchBar?.clipsToBounds = true
    
        SearchView = searchBar
        
        
        
    }
    override func viewDidLayoutSubviews() {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
       searchBar.endEditing(true)
       dismiss(animated: false, completion: nil)
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
       searchBar.endEditing(true)
        
    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//       filterContentForSearchText(self.searchBar.text!)
//       self.searchBar.resignFirstResponder()
//    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        //     searchController.searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        
    }
    
    
}
extension MoreTaxonomiesViewController{
    
    
    
    
    
}
