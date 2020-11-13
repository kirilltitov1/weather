//
//  CitySearchViewController.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import RxSwift
import RxCocoa

class CitySearchViewController: UIViewController,
								UISearchBarDelegate {
	
	var viewModel: CitySearchViewModel!
	var citySearchView: CitySearchView!
	let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view = citySearchView

		self.citySearchView.searchBar.delegate = self
		self.setUpBindings()
    }
	func setUpBindings() {
		let input = CitySearchViewModel.Input(
			cityName: citySearchView.searchBar.rx.text
				.orEmpty
				.debounce(DispatchTimeInterval.milliseconds(500),
						  scheduler: MainScheduler.instance)
				.filter { !$0.isEmpty }
				.asObservable()
		)
		let output = CitySearchViewModel().transform(input: input)
		output.cityName
			.bind(to: citySearchView.cityName.rx.text)
			.disposed(by: disposeBag)
		output.cityTemperature
			.bind(to: citySearchView.cityTemperature.rx.text)
			.disposed(by: disposeBag)
		output.weatherIcon
			.bind(to: citySearchView.weatherIcon.rx.image)
			.disposed(by: disposeBag)
	}
}
