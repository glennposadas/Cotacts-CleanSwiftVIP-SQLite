//
//  BaseTableCell.swift
//  Contacts
//
//  Created by Glenn Posadas on 4/4/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
  
  // MARK: - Properties
    
  static var identifier: String! {
    get {
      return "\(self.typeName(self))"
    }
  }
  
  // MARK: Views
  
  lazy var view_Container: UIView = {
    let view = UIView.new(backgroundColor: .white)
    return view
  }()
  
  // MARK: - Functions
  
  private static func typeName(_ some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
  }
  
  // MARK: Overrides
  
  override func prepareForReuse() {
    super.prepareForReuse()

  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.separatorInset = UIEdgeInsets(top: 0, left: 15000, bottom: 0, right: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

