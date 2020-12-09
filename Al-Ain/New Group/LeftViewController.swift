//
//  LeftViewController.swift
//  Drawer_Example
//

import UIKit
import DrawerMenu
import LUExpandableTableView

class LeftViewController: UIViewController {
    private let cellReuseIdentifier = "MenuMyCell"
    private let sectionHeaderReuseIdentifier = "MySectionHeader"
    private var selectedWidth: CGFloat = 230
    
    @IBOutlet var expandableTableView: LUExpandableTableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("left menu viewWillAppear")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       // expandableTableView.frame = view.bounds
       // expandableTableView.frame.origin.y += 20
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("left menu viewWillDisappear\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandableTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        expandableTableView.register(UINib(nibName: "MyExpandableTableViewSectionHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
        
        expandableTableView.expandableTableViewDataSource = self
        expandableTableView.expandableTableViewDelegate = self
    }
    
    func getController(row: Int) -> UIViewController {
        
//        if row == 0 { return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! }
      //  return UIViewController()
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    
    }
    
    func getWidth(row: Int) -> CGFloat {
        
        if row == 0 { return 200 }
        if row == 1 { return 240 }
        if row == 2 { return 280 }
        if row == 3 { return 320 }
        return view.frame.width * 0.8
    }
    
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = expandableTableView(tableView, cellForRowAt: indexPath)
//
//        cell.accessoryType = .none
//        if indexPath.section == 1 {
//            cell.accessoryType = getWidth(row: indexPath.row) == selectedWidth ? .checkmark : .none
//        }
//        return cell
//    }
//
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.section == 0 {
//            drawer()?.replace(center: getController(row: indexPath.row))
//        }
//        if indexPath.section == 1 {
//            let width = getWidth(row: indexPath.row)
//            selectedWidth = width
//            drawer()?.leftMenuWidth = width
//        }
//        tableView.reloadData()
//    }
}

// MARK: - LUExpandableTableViewDataSource

extension LeftViewController: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return 2
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MenuTableViewCell else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        cell.label.text = "Cell at row \(indexPath.row) section \(indexPath.section)"
        
        return cell
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? MyExpandableTableViewSectionHeader else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }
        
        sectionHeader.label.text = "Section \(section)"
        
        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension LeftViewController: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 50
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 69
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        print("Did select section header at section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        print("Will display section header for section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func expandableTableView(_ expandableTableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
