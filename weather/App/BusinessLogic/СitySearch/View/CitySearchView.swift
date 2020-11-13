//
//  CitySearchView.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit

class CitySearchView: UIView {

	@IBOutlet weak var additionalInfo: UIButton!
	@IBOutlet weak var cityName: UILabel!
	@IBOutlet weak var cityTemperature: UILabel!
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
