//
//  SearchCityWeatherReport.swift
//  weather
//
//  Created by Kirill Titov on 15.11.2020.
//

import Foundation
import Alamofire
import RxSwift
//import RxCocoa

protocol FetchWeatherReportProtocol {
	var errorParser: SearchCityErrorParser { get }
	func fetchCityWeatherReport(strCityName city: String) -> Single<CityWeatherReport>
}

//let cacher = ResponseCacher(behavior: .cache)
//https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#cachedresponsehandler
//URLCache
let responseCache = NSCache<NSString, AnyObject>()
class CityWeatherReportService: FetchWeatherReportProtocol {
	let errorParser: SearchCityErrorParser

	init(errorParser: SearchCityErrorParser) {
		self.errorParser = errorParser
	}
	
	func fetchCityWeatherReport(strCityName city: String) -> Single<CityWeatherReport> {
		let url = Constants.Path.weathermap
		let parameters: [String : String] = ["q" : city,
											 "appid" : Constants.appid,
											 "mode" : "JSON",
											 "units" : "metric"]
		
		return Single<CityWeatherReport>.create { single in
			
			// response from cache
			if let responseFromCache = responseCache.object(forKey: city as NSString ) as? CityWeatherReport {
				single(.success(responseFromCache))
			} else {
				AF.request(url, method: .get, parameters: parameters)
					.responseDecodable(of: CityWeatherReport.self) { response in
						switch response.result {
						case let .success(success):
							// response into cache
							DispatchQueue.main.async {
								responseCache.setObject(success, forKey: city as NSString)
								single(.success(success))
							}
						case let .failure(error):
							self.errorParser.parser(searchCityError: error)
						}
					}
			}
			return Disposables.create()
		}
	}
}
