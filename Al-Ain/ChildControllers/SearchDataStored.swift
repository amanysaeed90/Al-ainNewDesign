//
//  previousRecipeSearch.swift
//  RecipeTask
//
//  Created by mac on 10/4/18.
//  Copyright © 2018 amany. All rights reserved.
//

import UIKit
@IBDesignable 
class SearchDataStored: UIView {
     var PreviousSearchData : [String]?
    @IBOutlet var prviousSearchTable: UITableView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var contentView : UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()

        // use bounds not frame or it'll be offset
        contentView!.frame = bounds

        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }

    func loadViewFromNib() -> UIView! {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        PreviousSearchData = UserDefeualt.UserDefaultHelper.getPreviousSearchData()
        prviousSearchTable.register(UINib(nibName: "searchcell", bundle: nil), forCellReuseIdentifier: "searchcell")

        prviousSearchTable.delegate = self
        prviousSearchTable.dataSource = self
        // Register to receive notification

        NotificationCenter.default.addObserver(self, selector: #selector(SearchDataStored.Reloadtable), name: Notification.Name("ReloadPreviousSearchData"), object: nil)

        return view
    }
   @objc func Reloadtable (){
        PreviousSearchData = UserDefeualt.UserDefaultHelper.getPreviousSearchData()
        prviousSearchTable.reloadData()
        prviousSearchTable.setContentOffset(CGPoint.zero, animated: true)
    }

}
extension SearchDataStored : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let SelectDataDict:[String: String] = ["Textselected": PreviousSearchData![indexPath.row]]
        // Post a notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectDataFromSearchBox"), object: nil, userInfo: SelectDataDict)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideSearchPreviousDataView"), object: nil, userInfo: SelectDataDict)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReturnSearchBar"), object: nil, userInfo: SelectDataDict)
    UserDefeualt.UserDefaultHelper.setPreviousSearchData(searchText:self.PreviousSearchData?[indexPath.row] ?? "" )
        self.Reloadtable()

    }


}

extension SearchDataStored : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PreviousSearchData!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell") as! searchcell
        cell.textsearch = self.PreviousSearchData?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }

}
