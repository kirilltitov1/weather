//
//  AdditionalCityInfoViewModel.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

protocol AdditionalCityInfoViewModelProtocol {
	associatedtype Input
	associatedtype Output

	func transform(input: Input) -> Output
}

final class AdditionalCityInfoViewModel {
//	var weatherForCurrentCity: [CityResponse.List] = []
	let disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let weatherForCurrentCity = BehaviorSubject<[CityResponse.List]>(value: [])
		CitySearchModel.loadWeather(byStringCity: input.city)
			.subscribeOn(MainScheduler.instance)
			.subscribe { response in
				weatherForCurrentCity.onNext(response.list)
			}.disposed(by: disposeBag)
		return Output(weatherForCurrentCity: weatherForCurrentCity)
	}
}

extension AdditionalCityInfoViewModel: AdditionalCityInfoViewModelProtocol {
	struct Input {
		let city: String
	}
	struct Output {
		let weatherForCurrentCity: BehaviorSubject<[CityResponse.List]>
	}
}
