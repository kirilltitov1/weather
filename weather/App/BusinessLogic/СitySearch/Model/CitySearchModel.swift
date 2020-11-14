//
//  CitySearchModel.swift
//  weather
//
//  Created by Kirill Titov on 14.11.2020.
//

import Alamofire

import RxSwift
import RxCocoa


class CityResponse: Codable {
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

protocol WeatherServiceProtocol {
	static func loadWeather(byStringCity city: String) -> Single<CityResponse>
	func loadWeatherIcon(byStringName name: String) -> Single<UIImage>
}

//let cacher = ResponseCacher(behavior: .cache)
//https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#cachedresponsehandler
let responseCache = NSCache<NSString, AnyObject>()
final class CitySearchModel: WeatherServiceProtocol {

	static func loadWeather(byStringCity city: String) -> Single<CityResponse> {
		let url = Constants.Path.weathermap
		let parameters: [String : String] = ["q" : city,
											 "appid" : Constants.appid,
											 "mode" : "JSON",
											 "units" : "metric"]

			return Single<CityResponse>.create { single in
				
				// response from cache
				if let responseFromCache = responseCache.object(forKey: city as NSString ) as? CityResponse {
					single(.success(responseFromCache))
					return Disposables.create()
				}

				AF.request(url, method: .get, parameters: parameters)
					.responseDecodable(of: CityResponse.self) { response in
						switch response.result {
						case let .success(success):
							// response into cache
							DispatchQueue.main.async {
								responseCache.setObject(success, forKey: city as NSString)
							}
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
