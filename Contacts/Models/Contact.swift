//
//  Contact.swift
//  Contacts
//
//  Created by Glenn Posadas on 4/4/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import Foundation

class Contact: Codable {
  var id: Int?
  var firstName, lastName, mobileNumber: String?
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case mobileNumber = "mobile_number"
  }
  
  init(id: Int?, firstName: String?, lastName: String?, mobileNumber: String?) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.mobileNumber = mobileNumber
  }
}

