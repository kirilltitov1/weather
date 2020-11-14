//
//  AdditionalCityInfoCoordinator.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit

final class AdditionalCityInfoCoordinator: BaseCoordinator {
	var title: String?
	var currentCity: [CityResponse.List]?
	override func start() {
		let viewController = UIStoryboard.init(name: "AdditionalCityInfo", bundle: nil).instantiateInitialViewController()
		guard let additionalCityInfoViewController = viewController as? AdditionalCityInfoViewController else { return }
		
		// Coordinator initializes and injects viewModel
		let viewModel = AdditionalCityInfoViewModel()
		additionalCityInfoViewController.viewModel = viewModel
//		additionalCityInfoViewController.weather = currentCity ?? []
		additionalCityInfoViewController.title = title
		
		// Coordinator subscribes to events and notifies parentCoordinator
		self.navigationController.setNavigationBarHidden(false, animated: true)
		self.navigationController.viewControllers.append(additionalCityInfoViewController)
	}
}
