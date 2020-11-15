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

final class CitySearchViewModel {
	var disposeBag = DisposeBag()
	var weatherForCurrentCity: [CityResponse.List] = []
	func transform(input: Input) -> Output {
		let cityName = BehaviorSubject<String>(value: "City loading…")
		let cityTemperature = BehaviorSubject<String>(value: "Temperature loading…")
		let weatherStrIcon = BehaviorSubject<String>(value: "")

		input.cityName.subscribe { strCityName in
			CitySearchModel.loadWeather(byStringCity: strCityName)
				.debug("loadWeather")
				.observeOn(MainScheduler.instance)
				.subscribe(
					onSuccess: { response in
						self.weatherForCurrentCity = response.list
						guard let current = response.list.first else { return }
						cityName.onNext(strCityName)
						cityTemperature.onNext(String(current.main.temp))
						guard let weather = current.weather.first else { return }
						weatherStrIcon.onNext(weather.icon)
					},
					onError: { error in
						// не найден город
						self.weatherForCurrentCity = []
						cityName.onNext("...")
						cityTemperature.onNext("...")
						weatherStrIcon.onNext("...")
					}).disposed(by: self.disposeBag)
		}.disposed(by: disposeBag)
		
		let isLoginButtonEnabled = Observable
			.combineLatest(
				cityName.asObserver(),
				cityTemperature.asObserver()
			)
			.map { $0 != "..." && $1 != "..." }
			.startWith(false)

		return Output(
			cityName: cityName,
			cityTemperature: cityTemperature,
			weatherIcon: weatherStrIcon,
			isButtonEnabled: isLoginButtonEnabled
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
		let isButtonEnabled: Observable<Bool>
	}
}
