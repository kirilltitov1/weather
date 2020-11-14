//
//  AdditionalCityInfoViewController.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

class AdditionalCityInfoViewController: UIViewController {
	
	let CITY_CELL_IDENTIFIER = "AdditionalCityInfo"

	var viewModel: AdditionalCityInfoViewModel!
	var weather: [CityResponse.List] = WeatherSingletone.shared.weather
	
	let disposeBag = DisposeBag()
	
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self
		
		self.regCell()
//		self.setUpBindings()
    }
	func setUpBindings() {
		let input = AdditionalCityInfoViewModel.Input(city: self.title ?? "")
		let output = viewModel.transform(input: input)
		output.weatherForCurrentCity.subscribeOn(MainScheduler.instance).subscribe { respose in
			self.weather = respose.element ?? []
			self.tableView.reloadData()
		}.disposed(by: disposeBag)
	}
}

extension AdditionalCityInfoViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weather.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CITY_CELL_IDENTIFIER, for: indexPath) as? AdditionalCityInfoTableViewCell else {
			let cell = AdditionalCityInfoTableViewCell()
			return cell
		}
		cell.setup(
			icon: weather[indexPath.row].weather.first!.icon,
			temp: weather[indexPath.row].main.temp
		)
		return cell
	}
	func regCell() {
		let nib = UINib.init(nibName: "AdditionalCityInfoTableViewCell", bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: CITY_CELL_IDENTIFIER)
	}
}
