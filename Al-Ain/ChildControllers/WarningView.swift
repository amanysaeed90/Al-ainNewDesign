//
//  WarningView.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/10/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

class WarningView: UIView {

   var contentView : UIView?
    
    @IBOutlet weak var tryagainbtn: UIButton!
    @IBOutlet weak var warinigImg: UIImageView!
    @IBOutlet weak var HeaderLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    var HeaderText: String? {
        didSet {
          
            HeaderLbl.text = HeaderText
        }
    }
    var DescriptionText: String? {
           didSet {
               DescriptionLbl.text = DescriptionText
           }
       }
    var ImgName: String? {
        didSet {
            warinigImg.image = UIImage(named: ImgName ?? "noInternet")
        }
    }
    
    
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

    
    
    
    @IBAction func TryagainAction(_ sender: UIButton) {
        
//        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
//        gesture.numberOfTapsRequired = 1
//        targetView?.isUserInteractionEnabled = true
//        targetView?.addGestureRecognizer(gesture)
        
    }
    
    
    func loadViewFromNib() -> UIView! {

          let bundle = Bundle(for: type(of: self))
          let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
          let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        tryagainbtn.setTitle("tryagain".localized(), for: .normal)
//          let Gif = UIImage.gifImageWithName("nonet")
//          img.image = Gif
          return view
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
