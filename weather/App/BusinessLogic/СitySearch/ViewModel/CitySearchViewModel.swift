//
//  CitySearchViewModel.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import RxSwift
import RxCocoa
import Alamofire

protocol CitySearchViewModelProtocol {
	associatedtype Input
	associatedtype Output
	
	func transform(input: Input) -> Output
}

class CitySearchViewModel {
	func transform(input: Input) -> Output {
		let cityName = BehaviorSubject<String>(value: "City loading…")
		let cityTemperature = BehaviorSubject<String>(value: "Temperature loading…")
		let weatherIcon = BehaviorSubject<UIImage>(value: UIImage())

		return Output(
			cityName: cityName,
			cityTemperature: cityTemperature,
			weatherIcon: weatherIcon
		)
	}
}

extension CitySearchViewModel: CitySearchViewModelProtocol {
	struct Input {
		let cityName: Observable<String>
	}

	struct Output {
		let cityName: BehaviorSubject<String>
		let cityTemperature: BehaviorSubject<String>
		let weatherIcon: BehaviorSubject<UIImage>
	}
}
