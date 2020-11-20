//
//  HomeView.swift
//  SearchBarCustom
//
//  Created sopra on 20/11/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func continueButtonPressed(_ sender: UIButton) {
        self.presenter.presentSearchBar()
    }
}

extension HomeView: HomeViewProtocol {}
