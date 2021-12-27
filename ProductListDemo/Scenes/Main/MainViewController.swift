//
//  MainViewController.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit
import Reusable
import SDWebImage
import RxSwift
import RxCocoa
import MGArchitecture

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productListButton: UIButton!
    
    // MARK: - Properties

    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        title = "Main"
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(
            load: Driver.just(()),
            toProductlistTrigger: productListButton.rx.tap.asDriver()
            
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
