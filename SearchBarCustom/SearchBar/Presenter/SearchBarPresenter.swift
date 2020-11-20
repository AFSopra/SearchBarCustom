//
//  SearchBarPresenter.swift
//  SearchBarCustom
//
//  Created sopra on 20/11/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SearchBarPresenter {
    var view: SearchBarViewProtocol!
    let interactor: SearchBarInteractorProtocol
    let router: SearchBarRouterProtocol

    init(withView view: SearchBarViewProtocol, interactor: SearchBarInteractorProtocol, router: SearchBarRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchBarPresenter: SearchBarPresenterProtocol {
    func popToHome() {
        router.popToHome()
    }
}
