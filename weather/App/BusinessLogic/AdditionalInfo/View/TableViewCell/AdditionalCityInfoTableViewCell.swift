//
//  AdditionalCityInfoTableViewCell.swift
//  weather
//
//  Created by Kirill Titov on 14.11.2020.
//

import UIKit

class AdditionalCityInfoTableViewCell: UITableViewCell {

	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var temp: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func setup(icon: String, temp: Double) {
		self.icon.loadImageUsingUrlString(urlString: Constants.Path.weathermapIcon + icon + ".png")
		self.temp.text = "temp = "+String(temp)+"Cº"
	}
}
