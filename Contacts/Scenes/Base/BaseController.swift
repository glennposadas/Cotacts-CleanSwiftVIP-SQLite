//
//  BaseController.swift
//  FDFullscreenPopGestureDemo
//
//  Created by Glenn Posadas on 3/7/21.
//  Copyright © 2021 forkingdog. All rights reserved.
//

import CocoaLumberjack
import UIKit

@objc protocol ViewConfigurable: class { }

extension ViewConfigurable {
  /// Called by `BaseController` from `viewDidLoad`.
  /// Do all the view setup here including data.
  func setupView() { }
  /// Called by `BaseController` from `viewDidLoad`.
  /// Perform all the constraints configuration here.
  func setupLayout() { }
}

typealias ViewControllerWillAppearInjectBlock = ((_ viewController: BaseController, _ animated: Bool) -> Void)

/**
 The base controller that implements `FBFullscreenPopGesture` features.
 */
class BaseController: UIViewController, ViewConfigurable {
  
  // MARK: - Properties
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    if let navCon = self.navigationController as? BaseNavigationController {
      return navCon.statusBarStyle
    }
    
    return .lightContent
  }
  
  /// Whether the interactive pop gesture is disabled when contained in a navigation
  /// stack.
  var interactivePopDisabled: Bool = false
  
  /// Indicate this view controller prefers its navigation bar hidden or not,
  /// checked when view controller based navigation bar's appearance is enabled.
  /// Default to NO, bars are more likely to show.
  ///
  /// Two ways to toggle the visibility of the navBar.
  ///   - override this property.
  ///   - set this property before super.viewWillAppear in the subclass.
  var prefersNavigationBarHidden = true
  
  /// Max allowed initial distance to left edge when you begin the interactive pop
  /// gesture. 0 by default, which means it will ignore this limit.
  var interactivePopMaxAllowedInitialDistanceToLeftEdge: CGFloat!
  
  var willAppearInjectBlock: ViewControllerWillAppearInjectBlock?
  
  // MARK: - Overrides
  // MARK: Functions
  
  deinit {
    DDLogInfo("Deinit contoller: \(self)")
  }
  
  override func loadView() {
    super.loadView()
    
    DDLogInfo("loadView contoller: \(self)")
    setupView()
    setupLayout()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    DDLogInfo("viewWillLayoutSubviews contoller: \(self)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DDLogInfo("viewDidLoad contoller: \(self)")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DDLogInfo("viewWillAppear contoller: \(self)")
    
    setStatusBarAppearance(
      statusBarShouldBeHidden: true,
      statusBarAnimationStyle: .fade,
      statusBarStyle: .lightContent
    )
    
    if let willAppearInjectBlock = self.willAppearInjectBlock {
      willAppearInjectBlock(self, animated)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    DDLogInfo("viewDidAppear contoller: \(self)")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    DDLogInfo("viewWillDisappear contoller: \(self)")
    
    DispatchQueue.main.async {
      if let topVC = self.navigationController?.viewControllers.last as? BaseController {
        if !topVC.prefersNavigationBarHidden {
          self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
      }
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    DDLogInfo("viewDidDisappear contoller: \(self)")
  }
  
  // MARK: - ViewConfigurable
  
  func setupView() {
    view.backgroundColor = .white
  }
  
  func setupLayout() {
    
  }
}
