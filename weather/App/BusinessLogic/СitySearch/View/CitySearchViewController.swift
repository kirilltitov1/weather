//
//  CitySearchViewController.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import RxSwift
import RxCocoa

class CitySearchViewController: UIViewController, UISearchBarDelegate {
	
	var viewModel: CitySearchViewModel!
	let disposeBag = DisposeBag()

	@IBOutlet weak var cityName: UILabel!
	@IBOutlet weak var cityTemperature: UILabel!
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var searchBar: UISearchBar!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.searchBar.delegate = self
		self.setUpBindings()
    }
	func setUpBindings() {
		let input = CitySearchViewModel.Input(
			cityName: searchBar.rx.text
				.orEmpty
				.debounce(DispatchTimeInterval.milliseconds(500),
						  scheduler: MainScheduler.instance)
				.filter { !$0.isEmpty }
				.asObservable()
		)
		let output = CitySearchViewModel().transform(input: input)
		output.cityName
			.bind(to: cityName.rx.text)
			.disposed(by: disposeBag)
		output.cityTemperature
			.bind(to: cityTemperature.rx.text)
			.disposed(by: disposeBag)
		output.weatherIcon
			.bind(to: weatherIcon.rx.image)
			.disposed(by: disposeBag)
	}
}
