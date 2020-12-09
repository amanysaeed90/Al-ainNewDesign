//
//  CustomNav.swift
//  Al-Ain
//
//  Created by amany elhadary on 8/6/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

class CustomNav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"alain-logo"),for: .any, barMetrics: .default)

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
