//
//  CitySearchCoordinator.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import Foundation
import UIKit

class CitySearchCoordinator: BaseCoordinator {
	override func start() {
		let viewController = UIStoryboard.init(name: "SitySearch", bundle: nil).instantiateInitialViewController()
		guard let authViewController = viewController as? CitySearchViewController else { return }
		
		// Coordinator initializes and injects viewModel
		let viewModel = CitySearchViewModel()
		authViewController.viewModel = viewModel
		
		// Coordinator subscribes to events and notifies parentCoordinator
		
		self.navigationController.viewControllers = [authViewController]
	}
}
