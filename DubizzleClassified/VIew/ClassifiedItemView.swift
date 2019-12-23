//
//  ClassifiedItemView.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/21/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit

class ClassifiedItemView: UIView {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shimmerview : ShimmerView!
    @IBOutlet weak var shimmerImageContainerview : UIView!
    
    private let cornerRadius: CGFloat = 4.0
    private let shadowOpacity: Float = 0.10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    private func setUpView() {
        let bundle = Bundle(for: ClassifiedItemView.self)
        let nib = UINib(nibName: "ClassifiedItemView", bundle: bundle)
        guard let first = nib.instantiate(withOwner: self, options: nil).first as? UIView else{
            return
        }
        self.frame = first.frame
        self.addSubview(first)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = cornerRadius
        thumbnailImage.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        setUpUI()
    }
    
    public func configureUI(name: String, price: String, thumbnail: String, time: String) {
        self.nameLabel.text = name
        self.priceLabel.text = price
        self.priceLabel.attributedText = formatAttributedStringForAmount(amountString: price)
        self.timeLabel.text = time
        resetView(hide: false)
        
        if let imageURL = URL(string: thumbnail) {
            self.thumbnailImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "item_placeholder"))
        }
    }
    
    func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        }
        else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
    
    public func shimmerView(show: Bool) {
        resetView(hide: true)
        shimmerImageContainerview.isHidden = !show
        if show {
            shimmerview.startAnimation()
        } else {
            shimmerview.stopAnimation()
        }
    }
    
    func resetView(hide: Bool) {
        thumbnailImage.isHidden = hide
        nameLabel.isHidden = hide
        priceLabel.isHidden = hide
        timeLabel.isHidden = hide
    }
    
    private func formatAttributedStringForAmount(amountString: String) -> NSMutableAttributedString {
        
        var formattedAmountString = NSMutableAttributedString()
        
        if amountString.components(separatedBy: " ").count > 1 {
            formattedAmountString = NSMutableAttributedString(string: (amountString.components(separatedBy: " ").first ?? "") + " ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)])
        }
        
        formattedAmountString.append(NSMutableAttributedString(string: amountString.components(separatedBy: " ").last ?? "", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18.0)]))
        
        return formattedAmountString
    }
}
