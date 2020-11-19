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

class ErrorHandler: SearchCityErrorParser, showAlert {
	func parser(searchCityError: Error) -> Error {
		guard let error = searchCityError.asAFError else { return searchCityError }
		let description = "☂️⚠️ -> " + (error.errorDescription ?? "")
		switch true {
		case error.isResponseSerializationError:
			showAlert(message: "Incorrect city")
			print(description)
		case error.isSessionTaskError:
			showAlert(message: "No conection")
			print(description)
		case error.isCreateURLRequestError:
			print(description)
		case error.isInvalidURLError:
			print(description)
		case error.isCreateUploadableError:
			print(description)
//		case
		default:
			print(description)
		}
		return error
	}
}
