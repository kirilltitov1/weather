//
//  AdditionalCityInfoViewModel.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import UIKit

protocol AdditionalCityInfoViewModelProtocol {
	associatedtype Input
	associatedtype Output

	func transform(input: Input) -> Output
}

class AdditionalCityInfoViewModel {
	func transform(input: Input) -> Output {
		return Output()
	}
}

extension AdditionalCityInfoViewModel: AdditionalCityInfoViewModelProtocol {
	struct Input {
		
	}
	struct Output {
		
	}
}
