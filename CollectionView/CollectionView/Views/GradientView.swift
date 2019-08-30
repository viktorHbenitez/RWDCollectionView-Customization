import UIKit

class GradientView: UIView {
  
  lazy fileprivate var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor.clear.cgColor, UIColor(white: 0.0, alpha: 0.75).cgColor]
    layer.locations = [NSNumber(value: 0.0 as Float), NSNumber(value: 1.0 as Float)]
    return layer
    }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.clear  // color
    layer.addSublayer(gradientLayer) // add layer to the layers of the uiview
  }
  
  override func layoutSubviews() {
		super.layoutSubviews()
		CATransaction.begin() // init Tansaction
		CATransaction.setDisableActions(true)
		gradientLayer.frame = bounds  // size
		CATransaction.commit()
  }
  
}
