//
//  CitySearchViewModel.swift
//  weather
//
//  Created by Kirill Titov on 13.11.2020.
//

import RxSwift
import RxCocoa

protocol CitySearchViewModelProtocol {
	associatedtype Input
	associatedtype Output
	
	func transform(input: Input) -> Output
}

class CitySearchViewModel {
	func transform(input: Input) -> Output {
		return Output()
	}
}

extension CitySearchViewModel: CitySearchViewModelProtocol {
	struct Input {
		
	}

	struct Output {
		
	}
}
