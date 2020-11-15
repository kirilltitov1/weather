//
//  CitySearchModel.swift
//  weather
//
//  Created by Kirill Titov on 14.11.2020.
//

import Alamofire

import RxSwift
import RxCocoa

class CityWeatherReport: Codable {
	let cod: String
	let list: [List]
	
	class List: Codable {
		let main: Main
		let weather: [Weather]
		
		class Main: Codable {
			let temp: Double
		}
		class Weather: Codable {
			let icon: String
		}
	}
}
