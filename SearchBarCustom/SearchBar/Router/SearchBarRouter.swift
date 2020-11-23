//
//  SearchBarRouter.swift
//  SearchBarCustom
//
//  Created sopra on 20/11/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SearchBarRouter {
    weak var view: SearchBarView!

    init(withView view: SearchBarView) {
        self.view = view
    }

    static func assembleModule(withinNavController: Bool = false) -> UIViewController {
        let viewController = viewControllerFromStoryboard()
        let router = SearchBarRouter(withView: viewController)
        let interactor = SearchBarInteractor()
        let presenter = SearchBarPresenter(withView: viewController, interactor: interactor, router: router)

        viewController.presenter = presenter

        if withinNavController {
            let navigationController = UINavigationController(rootViewController: viewController)
            return navigationController
        }

        return viewController
    }

    static func viewControllerFromStoryboard() -> SearchBarView {
        let storyboard = UIStoryboard(name: "SearchBarView", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SearchBarView") as? SearchBarView {
            return vc
        }
        
        return SearchBarView()
    }
}

extension SearchBarRouter: SearchBarRouterProtocol {
    func popToHome() {
        view.navigationController?.popViewController(animated: true)
    }
}
