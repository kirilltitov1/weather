//
//  ErrorSearchCityWeather.swift
//  weather
//
//  Created by Kirill Titov on 17.11.2020.
//

import Foundation
import Alamofire

protocol SearchCityErrorParser: Error {
	@discardableResult
	func parser(searchCityError: Error) -> Error
}

class ErrorHandler: SearchCityErrorParser {
	func parser(searchCityError: Error) -> Error {
		guard let error = searchCityError.asAFError else { return searchCityError }
		let description = "☂️⚠️ -> " + (error.errorDescription ?? "")
		switch true {
		case error.isCreateURLRequestError:
			print(description)
		case error.isResponseSerializationError:
			print(description)
		default:
			print("Unknown error")
		}
		return error
	}
}
