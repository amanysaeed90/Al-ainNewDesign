//
//  hashtagCell.swift
//  Al-Ain
//
//  Created by al-ain nine on 11/27/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

class hashtagCell: UITableViewCell {

    @IBOutlet weak var collectionViewHashtags: UICollectionView!
    @IBOutlet weak var CollectionViewHeightConstraint: NSLayoutConstraint!
    var collectionViewObserver: NSKeyValueObservation?
    var items : [String]?
    var taxonomies:[Taxonomy] = []
    var VC:ArticleController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

            addObserver()


    }
    override func layoutSubviews() {
          super.layoutSubviews()

          layoutIfNeeded()

            
    }
    
    func addObserver() {
          collectionViewObserver = collectionViewHashtags.observe(\.contentSize, changeHandler: { [weak self] (collectionViewHashtags, change) in
               self?.collectionViewHashtags.invalidateIntrinsicContentSize()
               self?.CollectionViewHeightConstraint.constant = collectionViewHashtags.contentSize.height
               self?.layoutIfNeeded()

            
           })
       }
      deinit {
         collectionViewObserver = nil
        
        
      }
    func collectioviewConfigration(){
        let layout = LeftAlignedCollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 0
        
               layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        self.collectionViewHashtags.dataSource = self
        self.collectionViewHashtags.delegate = self
               self.collectionViewHashtags.collectionViewLayout = layout
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.right
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.right
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}

extension hashtagCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // スタンプが押された時の処理を書く
        print(self.taxonomies[indexPath.row])
        
        AppUtils.launchSectionViewController(taxonomy:self.taxonomies[indexPath.row], controller: VC!)
        
        
    }

}

extension hashtagCell: UICollectionViewDelegateFlowLayout {

   
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

   
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = Fonts.getFontSelected(fontSize: 15)
        label.text = " # \(self.items?[indexPath.row] ?? "") "
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 30, height: 40)
    }
    
}


extension hashtagCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell

        
        print(self.items?[indexPath.row])
        cell.label?.text = " # \(self.items?[indexPath.row] ?? "") "
      //  cell.contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        cell.layer.masksToBounds   = true
        cell.layer.cornerRadius    = 14
        return cell
    }
}
