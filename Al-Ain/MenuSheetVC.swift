//
//  MenuSheetVC.swift
//  Al-Ain
//
//  Created by Alex on 7/8/20.
//  Copyright © 2020 egygames. All rights reserved.
//

import UIKit
import Localize_Swift


class MenuSheetVC: UIViewController {
let  MneuTitles = [
           "شاهد",
           "إنفوجواف"
           ,"صور"
           ,"صفحات العين"
           ,"البلدان"
           ,"هاشتاقات"
    ,"About".localized()
    ]
       
       
    @IBOutlet weak var menuTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.dataSource = self
        menuTable.delegate = self
      //  menuTable.register(MenuSheetCell.self, forCellReuseIdentifier: "MenuSheetCell")
        // Do any additional setup after loading the view.
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
extension MenuSheetVC :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MneuTitles.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 7){
                      let cell = tableView.dequeueReusableCell(withIdentifier: "socailMediaCell", for: indexPath) as! socailMediaCell
                       //cell.title.text = MneuTitles[indexPath.row]
                       return cell
                   }
       else {
                     let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSheetCell", for: indexPath) as! MenuSheetCell
                       cell.title.text = MneuTitles[indexPath.row]
                       return cell
                   }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
extension MenuSheetVC :UITableViewDelegate {
    func openMore(_ type:TaxonomyType, title : String){
           let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
           moreTaxonomiesViewController.taxonomyType = type
           moreTaxonomiesViewController.title = title
           moreTaxonomiesViewController.titleNav = title;
       RootViewController.shared?.navigationController?.pushViewController(moreTaxonomiesViewController, animated: true)
           
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: false, completion: nil)
        if (indexPath.row == 5)
        {
              openMore(TaxonomyType.TAG, title:MenuViewController.taxonmyTitles[ indexPath.section])
            
        }
        else if (indexPath.row == 4)
        {
             openMore(TaxonomyType.COUNTRY, title:MenuViewController.taxonmyTitles[ indexPath.section])
            
        }
        else if (indexPath.row == 3)
        {
             openMore(TaxonomyType.PAGE,  title:MenuViewController.taxonmyTitles[ indexPath.section])
            
        }
        
        
//        let model = models[indexPath.row]
//        self.selectedLesson = model.id
//        self.SelectedLessonTile = model.title ?? ""
//        self.SelectedLessonDes = model.descriptionField ?? ""
//        self.performSegue(withIdentifier: "LessonsSubjects", sender: nil)

    }
}

