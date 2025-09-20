//
//  OutfitsTableViewCell.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import UIKit
import Kingfisher

class OutfitsTableViewCell: UITableViewCell {

    //MARK: IBOUTLETS
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonShop: UIButton!
    @IBOutlet weak var labelByBrand: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelFloralSummer: UILabel!
    @IBOutlet weak var imageViewOutfit: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewInner.addShadow()
        viewInner.backgroundColor = .white
        viewInner.addCornerRadiusWithShadow(cornerRadius: 5)
        
        viewContainer.backgroundColor = .black.withAlphaComponent(0.05)
        viewContainer.makeRounded(radius: 15)
        buttonShop.makeRounded(radius: 12.5, corners: false)
        imageViewOutfit.makeRounded(radius: 5.5, corners: false)
        buttonShop.applyGradient(colors: [.systemPink, .SHOP_BUTTON])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupData(outfit: Outfit) {
        
        self.labelFloralSummer.text = outfit.name
        self.labelByBrand.text = "📧 Email : " + (outfit.email ?? "")
        self.labelPrice.text = "🙎 Age : " + (outfit.age?.description ?? "")
        
        let imageURL = URL(string: outfit.image ?? "")
        imageViewOutfit.kf.indicatorType = .activity
        if let indicator = imageViewOutfit.kf.indicator?.view as? UIActivityIndicatorView {
            indicator.color = .red
        }
        
        self.imageViewOutfit.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.5))])
    }
}
