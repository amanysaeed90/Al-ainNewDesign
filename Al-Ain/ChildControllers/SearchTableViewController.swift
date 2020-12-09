

import AlgoliaSearch
import InstantSearchCore
import Alamofire
import UIKit


class SearchTableViewController: UIViewController, UISearchResultsUpdating, SearchProgressDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var NoDataView: WarningView!
    @IBOutlet weak var tableSearch: UITableView!
    var searchController: UISearchController!
    var searchProgressController: SearchProgressController!
    @IBOutlet var previousSerachDataView: SearchDataStored!

    @IBOutlet weak var searchviewbg: UIView!
    var articlesSearcher: Searcher!
    var articlesHits: [JSONObject] = []
    var originIsLocal: Bool = false
    var Searchtext = ""
    
    let placeholder = UIImage(named: "white")
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchviewbg.dropShadow()
        NoDataView.isHidden = false
        NoDataView.ImgName = "nosaerch"
        NoDataView.HeaderText = "NoSearchWords".localized()
        NoDataView.DescriptionText = ""
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTableViewController.HideSearchPreviousDataView), name: Notification.Name("HideSearchPreviousDataView"), object: nil)
        //ReturnSearchBar
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTableViewController.ReturnSearchBar), name: Notification.Name("ReturnSearchBar"), object: nil)

        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTableViewController.SelectDataFromSearchBox(notification:)), name: Notification.Name("SelectDataFromSearchBox"), object: nil)
        
        
     //   tableSearch.register(PostCell.self, forCellReuseIdentifier: "NormalPostCell")
       // tableSearch.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")

        
        tableSearch.rowHeight = UITableViewAutomaticDimension
        tableSearch.estimatedRowHeight = 130
        // Algolia Search
        let index = (UIApplication.shared.delegate as! AppDelegate).client.index(withName: "news")
        
        articlesSearcher = Searcher(index: index, resultHandler: self.handleSearchResults)
        articlesSearcher.params.hitsPerPage = 20
        articlesSearcher.params.attributesToRetrieve = ["category","title","image","created", "objectID"]
        
        // Search controller
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.semanticContentAttribute = .forceRightToLeft

        searchController.edgesForExtendedLayout = []
        edgesForExtendedLayout = []
        extendedLayoutIncludesOpaqueBars = true
    
        searchController.hidesNavigationBarDuringPresentation = false
        //definesPresentationContext = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
      //  searchController.searchBar.semanticContentAttribute = .forceLeftToRight
        // Add the search bar
      //  tableSearch.tableHeaderView = self.searchController!.searchBar
        searchController.searchBar.placeholder = " "

       
   // definesPresentationContext = true
        searchController!.searchBar.sizeToFit()
        
        // Configure search progress monitoring.
        searchProgressController = SearchProgressController(searcher: articlesSearcher)
        searchProgressController.delegate = self
       // tableSearch.tableHeaderView?.backgroundColor = UIColor.red
        //tableSearch.tableHeaderView?.tintColor = UIColor.red
       // searchController.view.backgroundColor = UIColor.black
          self.searchController!.searchBar.setTextField(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

         // self.searchController!.searchBar.searchBarStyle = .minimal
        //  self.searchController!.searchBar.searchBarStyle = .prominent
//           self.searchController!.searchBar.backgroundImage = UIImage()
//           self.searchController!.searchBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//             self.searchController!.searchBar.layer.cornerRadius = 24
//           self.searchController!.searchBar.clipsToBounds = true
        

        self.searchController!.searchBar.tintColor = #colorLiteral(red: 0.4078062773, green: 0.4078676105, blue: 0.407787025, alpha: 1)
//        for myView in self.searchController!.searchBar.subviews  {
//              for mySubView in myView.subviews  {
//                  if let textField = mySubView as? UITextField {
//                       var bounds: CGRect
//                  bounds = textField.frame
//                    bounds.size.height = 150 //(set your height)
//                      textField.bounds = bounds
//                        textField.borderStyle = UITextBorderStyle.roundedRect
//                  }
//              }
//          }
      //  self.searchController!.searchBar.frame.size.height = 150

//
//        let frame = CGRect(x: 0, y: 0, width: 100, height: 44)
//        let titleView = UIView(frame: frame)
//        searchController!.searchBar.backgroundImage = UIImage()
//        searchController!.searchBar.frame = frame
//        if #available(iOS 11.0, *) {
//            searchController!.searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        }
        for s in self.searchController!.searchBar.subviews[0].subviews {
            if s is UITextField {
                s.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                s.layer.borderWidth = 1.0
                s.layer.cornerRadius = 17
                s.layer.borderColor = #colorLiteral(red: 0.9567821622, green: 0.9569162726, blue: 0.9567398429, alpha: 1)
                s.semanticContentAttribute = .forceRightToLeft
                
                
            }
        }
       //  self.searchController!.searchBar.semanticContentAttribute = .forceLeftToRight
       
                let  menuButton = UIBarButtonItem(image:
                             #imageLiteral(resourceName: "menuIcon")
                             , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
                let leftNavBarButton = UIBarButtonItem(customView: self.searchController!.searchBar)
                self.navigationItem.rightBarButtonItems = [leftNavBarButton ]
                 let yourBackImage = UIImage(named: "Back")
                 self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
                 self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
       
        if (UserDefeualt .UserDefaultHelper.getPreviousSearchData().count > 0){
                      NotificationCenter.default.post(name: Notification.Name("ReloadPreviousSearchData"), object: nil)
                      self.previousSerachDataView.alpha = 1
                      self.searchviewbg.alpha = 1
            self.NoDataView.isHidden = true
            
        }
        if #available(iOS 13.0, *) {
            self.setnavigationWhite_tintGray()
            for subview in searchController.searchBar.subviews {
                for subview1 in subview.subviews {
                    if subview1 is UITextField {
                                   subview1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                   subview1.layer.borderWidth = 1.0
                                   subview1.layer.cornerRadius = 17
                                   subview1.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                   subview1.semanticContentAttribute = .forceRightToLeft
                                   
                                   
                               }
                    for subview2 in subview1.subviews {
                        if subview2 is UIButton {
                            let cancelButton =  subview2 as! UIButton
                            cancelButton.setTitle("Cancel".localized(), for: .normal)
                            cancelButton.setTitleColor(UIColor.darkGray, for: .normal)
                            searchController.searchBar.setShowsCancelButton(false, animated: true)
                        }
                        if subview2 is UITextField {
                                       subview2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                       subview2.layer.borderWidth = 1.0
                                       subview2.layer.cornerRadius = 17
                                       subview2.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                                       subview2.semanticContentAttribute = .forceRightToLeft
                                       
                                       
                                   }
                        
                    }

                }
            }
        }else {
        searchController.searchBar.setValue("الغاء", forKey:"_cancelButtonText")
        }
        searchController.searchBar.showsCancelButton = false
       
       // UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(10, 0)
        //searchBar.setPositionAdjustment(UIOffsetMake(10, 0), for: UISearchBarIcon.search)


    }
    @objc func openMenu(){
       //drawer()?.open(to: .right)
       }
    
    override func viewDidAppear(_ animated: Bool) {
        //SearchBar Text
        self.searchController!.searchBar.semanticContentAttribute = .forceRightToLeft

               let textFieldInsideUISearchBar = self.searchController!.searchBar.value(forKey: "searchField") as? UITextField
               textFieldInsideUISearchBar?.font = Fonts.getFont(fontSize: 13)
               textFieldInsideUISearchBar?.textColor = #colorLiteral(red: 0.2627197802, green: 0.2627618313, blue: 0.2627065182, alpha: 1)
               textFieldInsideUISearchBar?.textAlignment = .right

               let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
               textFieldInsideUISearchBarLabel?.font = Fonts.getFont(fontSize: 13)
               self.searchController!.searchBar.setCustomBackgroundColor (color: UIColor.black)
              // self.navigationItem.rightBarButtonItem = leftNavBarButton
               
               self.searchController!.searchBar.semanticContentAttribute = .forceRightToLeft
        searchController.searchBar.placeholder = "Search".localized()

        searchBar.setImage(UIImage(named: "Searchplacholder"), for: .search, state: .normal)
               UISearchBar.appearance().setImage(UIImage(named: "Searchplacholder"), for: UISearchBarIcon.search, state: UIControlState.normal)

//            super.viewDidAppear(animated)
//            for subView in self.searchController!.searchBar.subviews  {
//                for subsubView in subView.subviews  {
//                    if let textField = subsubView as? UITextField {
//                         var bounds: CGRect
//                    bounds = textField.frame
//                    bounds.size.height = 135 //(set height whatever you want)
//                        textField.bounds = bounds
//                        textField.borderStyle = UITextBorderStyle.roundedRect
//                        textField.layer.cornerRadius = 67.5
//    //                    textField.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//                        textField.backgroundColor = UIColor.red
//    //                    textField.font = UIFont.systemFontOfSize(20)
//                    }
//                }
//            }
//
//        searchBar.setImage(UIImage(named: "Searchplacholder"), for: .search, state: .normal)
//     UISearchBar.appearance().setImage(UIImage(named: "Searchplacholder"), for: UISearchBarIcon.search, state: UIControlState.normal)
       // UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(10, 0)
       // searchBar.setPositionAdjustment(UIOffsetMake(10, 0), for: UISearchBarIcon.search)

        }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.backgroundView?.backgroundColor = .white
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
     

        
         
    }
    
    
    // MARK: - Search completion handlers
    
    private func handleSearchResults(results: SearchResults?, error: Error?  , userInfo: [String: Any]) {
        guard let results = results else { return }
        if results.page == 0 {
            articlesHits = results.hits
        } else {
            articlesHits.append(contentsOf: results.hits)
        }
        
        if (results.hits.count == 0)
        {
            NoDataView.HeaderText = "NoSearchResult".localized()
            NoDataView.DescriptionText = "trySearchAgain".localized()
            NoDataView.isHidden = false

            
        }
        originIsLocal = results.content["origin"] as? String == "local"
        self.tableSearch.reloadData()
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return articlesHits.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
          return 130
      }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NoDataView.isHidden = true
       // let cell:PostCell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell", for: indexPath) as! PostCell
       // let cell:PostCell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell") as! PostCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell", for: indexPath) as! PostCell
        cell.parentViewController=self
        // Load more?
        if indexPath.row + 5 >= articlesHits.count {
            articlesSearcher.loadMore()
        }
        // Configure the cell...
        cell.configureWithData( articlesHits[indexPath.row])
   
        
        return cell
    }

    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  searchController.isActive = false
        
        UserDefeualt.UserDefaultHelper.setPreviousSearchData(searchText:Searchtext )
        APIManager.getArticleDetails(id: articlesHits[indexPath.row]["objectID"] as! String ,  suceess: { (articleRe:Article) in
                                   if articleRe != nil {                                                                     
                                    AppUtils.launchSingleArticleViewFromSearch (articleId:  self.articlesHits[indexPath.row]["objectID"] as! String ,Article: articleRe,controller: self)
                                   }else {
                                     
                                       
                                   }
                               }){ (error:Error?) in

                               }
        
        
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
      //  searchController.isActive = false

    }
    // MARK: - Search
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            return
        }
        articlesSearcher.params.query = searchController.searchBar.text
        articlesSearcher.search()
        Searchtext = searchController.searchBar.text ?? ""
        

       
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    }
    
    // MARK: - Activity indicator
    
    // MARK: - SearchProgressDelegate
    @objc func ReturnSearchBar (){
        searchController.searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.previousSerachDataView.alpha = 0
        self.searchviewbg.alpha = 0

        UserDefeualt.UserDefaultHelper.setPreviousSearchData(searchText:Searchtext )
        NotificationCenter.default.post(name: Notification.Name("ReloadPreviousSearchData"), object: nil)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       
        self.previousSerachDataView.alpha = 0
        self.searchviewbg.alpha = 0

        NotificationCenter.default.post(name: Notification.Name("ReloadPreviousSearchData"), object: nil)
        searchBar.endEditing(true)
        
    }
    
    func searchDidStart(_ searchProgressController: SearchProgressController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func searchDidStop(_ searchProgressController: SearchProgressController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

     self.previousSerachDataView.alpha = 0
     self.searchviewbg.alpha = 0
     
    }
 
    
    
  
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        UIView.animate(withDuration: 0.2, animations: {
            cell.contentView.alpha = 1.0
        })
        
    }
  

    
    
    @objc func HideSearchPreviousDataView(){
        self.previousSerachDataView.alpha = 0
        self.searchviewbg.alpha = 0

        
    }
    @objc func SelectDataFromSearchBox(notification: NSNotification){
        if let searchtext = notification.userInfo?["Textselected"] as? String {
            searchController.searchBar.text = searchtext
            //previousSerachDataView.alpha = 0
        }
        
        
    }
}

extension SearchTableViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (self.articlesHits.count > 0){
        searchviewbg.alpha = 0
        previousSerachDataView.alpha = 0
        }
}
}
extension UISearchBar {
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
}
public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
     UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
     color.setFill()
     UIRectFill(rect)
     let image = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     guard let cgImage = image?.cgImage else { return nil }
     self.init(cgImage: cgImage)
} }
extension UIImage {
    static func imageFromLayer (layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContext(layer.frame.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in: currentContext)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
}

extension UISearchBar {
    func setCustomBackgroundColor (color: UIColor) {
        let backgroundLayer = CALayer()
        backgroundLayer.frame = frame
        backgroundLayer.backgroundColor = color.cgColor
        if let image = UIImage.imageFromLayer(layer: backgroundLayer) {
            self.setBackgroundImage(image, for: .any, barMetrics: .default)
        }
    }
}
extension UISearchBar {
func setCenteredPlaceHolder(){
    let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField

    //get the sizes
    let searchBarWidth = self.frame.width
    let placeholderIconWidth = textFieldInsideSearchBar?.leftView?.frame.width
    let placeHolderWidth = textFieldInsideSearchBar?.attributedPlaceholder?.size().width
    let offsetIconToPlaceholder: CGFloat = 8
    let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder

    let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon), vertical: 0)
    self.setPositionAdjustment(offset, for: .search)
}
}
