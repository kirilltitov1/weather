//
//  CitySearchModel.swift
//  weather
//
//  Created by Kirill Titov on 14.11.2020.
//

import Alamofire

import RxSwift
import RxCocoa

struct CityResponse: Codable {
	let cod: String
	let list: [List]
	
	struct List: Codable {
		let main: Main
		let weather: [Weather]
		
		struct Main: Codable {
			let temp: Double
		}
		struct Weather: Codable {
			let icon: String
		}
	}
}

let cacher = ResponseCacher(behavior: .cache)
let responseCache = NSCache<NSString, AnyObject>()

protocol WeatherServiceProtocol {
	static func loadWeather(byStringCity city: String) -> Single<CityResponse>
	func loadWeatherIcon(byStringName name: String) -> Single<UIImage>
}

final class CitySearchModel: WeatherServiceProtocol {

	static func loadWeather(byStringCity city: String) -> Single<CityResponse> {
		let url = Constants.Path.weathermap
		let parameters: [String : String] = ["q" : city,
											 "appid" : Constants.appid,
											 "mode" : "JSON",
											 "units" : "metric"]
		
			return Single<CityResponse>.create { single in

				AF.request(url, method: .get, parameters: parameters)
					.cacheResponse(using: cacher)
					.responseDecodable(of: CityResponse.self) { response in
						switch response.result {
						case let .success(success):
							single(.success(success))
						case let .failure(error):
							print("AuthAPI.auth() \(error)")
							single(.error(error))
						}
					}
				return Disposables.create()
			}
	}
	final func loadWeatherIcon(byStringName name: String) -> Single<UIImage> {
		return Single<UIImage>.create { single in
			single(.success(UIImage()))
			return Disposables.create()
		}
	}
	
}
