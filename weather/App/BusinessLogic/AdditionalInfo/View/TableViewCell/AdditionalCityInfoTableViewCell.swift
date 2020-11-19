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
	@IBOutlet weak var dt: UILabel!
	@IBOutlet weak var humidity: UILabel!
	@IBOutlet weak var pressure: UILabel!
	@IBOutlet weak var feelsLike: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func setup(currentWeather: CityWeatherReport.List) {
		self.icon.loadImageUsingUrlString(urlString: Constants.Path.weathermapIcon + (currentWeather.weather.first?.icon ?? "") + "@2x.png")
		self.dt.text = self.convertDate(numberOfSecondsFrom1970: currentWeather.dt)
		self.temp.text = "temp " + String(Int(currentWeather.main.temp)) + " ℃"
		self.feelsLike.text = "feels like " + String(Int(currentWeather.main.feels_like)) + " ℃"
		self.humidity.text = "humidity " + String(currentWeather.main.humidity)
		self.pressure.text = "pressure " + String(currentWeather.main.pressure)
	}
	
	private func convertDate(numberOfSecondsFrom1970: Int) -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(numberOfSecondsFrom1970))
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM HH:mm"
		dateFormatter.timeZone = .none
		return dateFormatter.string(from: date)
	}
}
