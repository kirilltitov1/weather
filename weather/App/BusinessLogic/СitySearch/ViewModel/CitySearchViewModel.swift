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
	var disposeBag = DisposeBag()
	func transform(input: Input) -> Output {
		let cityName = BehaviorSubject<String>(value: "City loading…")
		let cityTemperature = BehaviorSubject<String>(value: "Temperature loading…")
		let weatherStrIcon = BehaviorSubject<String>(value: "")

		input.cityName.subscribe { strCityName in
			CitySearchModel.loadWeather(byStringCity: strCityName)
				.observeOn(MainScheduler.instance)
				.subscribe(
					onSuccess: { response in
						guard let current = response.list.first else { return }
						cityName.onNext(strCityName)
						cityTemperature.onNext(String(current.main.temp))
						guard let weather = current.weather.first else { return }
						weatherStrIcon.onNext(weather.icon)
					},
					onError: { error in
						// не найден город
						cityName.onNext("...")
						cityTemperature.onNext("...")
						weatherStrIcon.onNext("...")
					}).disposed(by: self.disposeBag)
		}.disposed(by: disposeBag)

		return Output(
			cityName: cityName,
			cityTemperature: cityTemperature,
			weatherIcon: weatherStrIcon
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
		let weatherIcon: BehaviorSubject<String>
	}
}
