//
//  Loader.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/20/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import SwiftyGif

class Loader: UIView {

     var contentView : UIView?
        
        @IBOutlet weak var warinigImg: UIImageView!
    
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

          func loadViewFromNib() -> UIView! {

              let bundle = Bundle(for: type(of: self))
              let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
              let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

            do {
                
                let gif = try UIImage(gifName: "LoaderGif2")
                             warinigImg.setGifImage(gif)
                         } catch {
                             print(error)
                         }
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
