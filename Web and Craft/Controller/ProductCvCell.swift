

import UIKit

class ProductCvCell: UICollectionViewCell {
    
    var favouriteAction : (() -> ())?
   
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var actualPrice: UILabel!
    
    @IBOutlet weak var offerPrice: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    @IBOutlet weak var offerImg: UIImageView!
    
    @IBOutlet weak var offerLbl: UILabel!
    
    @IBOutlet weak var expresso: UIImageView!
    
    
    @IBOutlet weak var fvrtImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowRadius = 5.0
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOpacity = 0.3
        
        self.fvrtImg.image = UIImage(named: "unmarked")
    }
        
    
    @IBAction func favouriteClick(_ sender: Any) {
        favouriteAction?()
        
    }
}
