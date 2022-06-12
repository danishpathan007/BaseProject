
import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var guideImageView: UIImageView!
    @IBOutlet weak var guideDescriptionLabel: UILabel!
    @IBOutlet weak var guideTitleLabel: UILabel!
    
    func setCellData(image:UIImage,title:String,cellDescription:String,boldText:String){
        guideImageView.image = image
        guideTitleLabel.text = title
        guideTitleLabel.boldSubstring(boldText)
        guideDescriptionLabel.text = cellDescription
    }
    
}
