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
	private var disposeBag = DisposeBag()
	private let fetchWeatherReportService: FetchWeatherReportProtocol
	
	var weatherForCurrentCity: [CityWeatherReport.List] = []
	
	init(
		fetchWeatherReportService: FetchWeatherReportProtocol = CityWeatherReportService()
	) {
		self.fetchWeatherReportService = fetchWeatherReportService
	}
	func transform(input: Input) -> Output {
		let cityName = BehaviorSubject<String>(value: "Input city")
		let cityTemperature = BehaviorSubject<String>(value: "")
		let weatherStrIcon = BehaviorSubject<String>(value: "")
		
		input.cityName.distinctUntilChanged().debug("cityName").subscribe { [weak self] strCityName in
			guard let self = self else { return }
			self.fetchWeatherReportService
				.fetchCityWeatherReport(byStringCity: strCityName.element ?? "")
				.debug("loadWeather")
				.observeOn(MainScheduler.instance)
				.subscribe { [weak self] weatherReport in
					guard let self = self else { return }
					self.weatherForCurrentCity = weatherReport.list
					guard let current = weatherReport.list.first else { return }
					cityName.onNext(strCityName.element ?? "")
					cityTemperature.onNext(String(current.main.temp))
					guard let weather = current.weather.first else { return }
					weatherStrIcon.onNext(weather.icon)
				} onError: { [weak self] error in
					guard let self = self else { return }
					self.weatherForCurrentCity = []
					cityName.onNext("...")
					cityTemperature.onNext("...")
					weatherStrIcon.onNext("...")
				}.disposed(by: self.disposeBag)
		}.disposed(by: disposeBag)
		
		let isLoginButtonEnabled = Observable
			.combineLatest(
				cityName.asObserver(),
				cityTemperature.asObserver()
			)
			.map { ($0 != "..." && $0 != "Input city" ) && $1 != "..." }
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
