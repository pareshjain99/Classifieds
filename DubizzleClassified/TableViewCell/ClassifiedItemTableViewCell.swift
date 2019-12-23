//
//  ClassifiedItemTableViewCell.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit

class ClassifiedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var classifiedItemView : ClassifiedItemView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configureUI(name: String, price: String, thumbnail: String, time: String) {
        classifiedItemView.configureUI(name: name,
                                       price: price,
                                       thumbnail: thumbnail,
                                       time: time)
    }
    
    public func shimmerView(show: Bool){
        classifiedItemView.shimmerView(show: show)
    }
}
