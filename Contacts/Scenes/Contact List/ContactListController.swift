//
//  ContactListController.swift
//  Contacts
//
//  Created by Glenn Posadas on 3/26/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import UIKit

protocol ContactListDisplayLogic: class {
  
}

final class ContactListController: BaseController {
  
  var interactor: ContactListBusinessLogic?
  var router: (ContactListRoutingLogic & ContactListDataPassing)?
  
  override var prefersNavigationBarHidden: Bool {
    get {
      return false
    } set {
      super.prefersNavigationBarHidden = false
    }
  }
  
  // MARK: - Views
  
  private var tableView: UITableView!
  private var barButton_Add: UIBarButtonItem!
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Delay.delay(5) {
      self.navigationController?.pushViewController(ContactViewerController(), animated: true)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setStatusBarAppearance(
      statusBarShouldBeHidden: false,
      statusBarAnimationStyle: .fade,
      statusBarStyle: .lightContent
    )
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = ContactListInteractor()
    let presenter = ContactListPresenter()
    let worker = ContactListWorker()
    let router = ContactListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: - ViewConfigurable
  
  override func setupView() {
    super.setupView()
    
    title = "Contacts"
    
  }
  
  override func setupLayout() {
    super.setupLayout()
    
  }
}

extension ContactListController: ContactListDisplayLogic {
  
}
