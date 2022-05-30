//
//  HostingController.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class HostingController<View: ViewProtocol>: UIViewController, ViewControllerProtocol {

    var viewObject: View?
    var viewModelObject: View.ViewModelProtocol

    required init(viewModel: View.ViewModelProtocol) {
        self.viewModelObject = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize generic View and his dependency
        let viewObject = View(viewModel: viewModelObject)

        // load & insert computated body from View
        let body = viewObject.body
        view.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        body.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        body.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

        // We hold the reference to our view
        self.viewObject = viewObject
        self.setNeedsStatusBarAppearanceUpdate()
        self.viewObject?.didLoad(on: self)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.viewObject?.layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewObject?.didAppear(on: self, animated: animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewObject?.willAppear(on: self, animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewObject?.didDisappear(on: self, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewObject?.willDisappear(on: self, animated: animated)
    }

    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }

    override var debugDescription: String {
        "\(viewModelObject)"
    }
    
}
