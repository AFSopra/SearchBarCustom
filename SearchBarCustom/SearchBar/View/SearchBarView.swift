//
//  SearchBarView.swift
//  SearchBarCustom
//
//  Created sopra on 20/11/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchBarView: UIViewController {
    var presenter: SearchBarPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchBarView: SearchBarViewProtocol {}
