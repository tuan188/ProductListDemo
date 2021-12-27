//
//  MainViewModel.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

// MARK: - ViewModel
extension MainViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
        let toProductlistTrigger: Driver<Void>
    }
    
    struct Output {
        
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.toProductlistTrigger
            .drive(onNext: {   // subcrible
                self.navigator.toProductList()
            })
            .disposed(by: disposeBag)

        return output
    }
}
