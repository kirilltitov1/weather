//
//  BaseCoordinator.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit

protocol Coordinator: AnyObject {
	var navigationController: UINavigationController { get set }
	var parentCoordinator: Coordinator? { get set }

	func start()
	func start(window: UIWindow)
	func start(coordinator: Coordinator)
	func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {

	var childCoordinators: [Coordinator] = []
	var parentCoordinator: Coordinator?
	var navigationController = UINavigationController()

	func start(window: UIWindow) {
		fatalError("'start(window)' method must be implemented")
	}

	func start() {
		fatalError("'start()' must be implemented")
	}

	func start(coordinator: Coordinator) {
		self.childCoordinators.append(coordinator)
		coordinator.parentCoordinator = self
		coordinator.start()
	}

	func didFinish(coordinator: Coordinator) {
		if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
			self.childCoordinators.remove(at: index)
		}
	}
}
