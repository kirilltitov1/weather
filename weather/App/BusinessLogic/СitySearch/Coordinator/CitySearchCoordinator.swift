//
//  CitySearchCoordinator.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import Foundation

class CitySearchCoordinator: BaseCoordinator {
	override func start() {
		let viewController = CitySearchViewController()
		
		// Coordinator initializes and injects viewModel
		let viewModel = CitySearchViewModel()
		viewController.viewModel = viewModel
		
		// Coordinator subscribes to events and notifies parentCoordinator
		
		self.navigationController.viewControllers = [viewController]
	}
}
