//
//  UILabel+Valid.swift
//  Contacts
//
//  Created by Glenn Posadas on 3/29/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import UIKit

extension String {
  /// Identical to the extension of UITextField's hasValue()
  func hasValidValue() -> Bool {
      let whitespaceSet = CharacterSet.whitespaces
      
      if self == "" || self == " " {
          return false
      }
      
      if self.trimmingCharacters(in: whitespaceSet).isEmpty
          || self.trimmingCharacters(in: whitespaceSet).isEmpty {
          return false
      }
      
      return true
  }
  
  /// Checks if the input email is valid or not
  func isValidEmail() -> Bool {
      let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
      return emailPredicate.evaluate(with: self)
      
  }
}
