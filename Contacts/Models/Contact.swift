//
//  Contact.swift
//  Contacts
//
//  Created by Glenn Posadas on 4/4/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import Foundation
import GRDB

/**
 The contact model.
 
 Ref:
 - https://github.com/groue/GRDB.swift/blob/master/README.md#records
 - https://github.com/groue/GRDB.swift/blob/master/README.md#requests
 - https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
 */
final class Contact {
  var id: Int64?
  var firstName, lastName, mobileNumber: String?
  
  init(id: Int64?, firstName: String?, lastName: String?, mobileNumber: String?) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.mobileNumber = mobileNumber
  }
}

// MARK: - DB Requests

extension DerivableRequest where RowDecoder == Contact {
  /// A request of contacts ordered by firstName.
  ///
  /// For example:
  ///
  ///     let contacts: [Contact] = try dbWriter.read { db in
  ///         try Contact.all().orderedByName().fetchAll(db)
  ///     }
  func orderByFirstName() -> Self {
    // Sort by name in a localized case insensitive fashion
    // See https://github.com/groue/GRDB.swift/blob/master/README.md#string-comparison
    order(Contact.Columns.firstName.collating(.localizedCaseInsensitiveCompare))
  }
}

// MARK: - Hashable

extension Contact: Identifiable, Hashable {
  static func == (lhs: Contact, rhs: Contact) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
}

// MARK: - Codable

extension Contact: Codable {
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case mobileNumber = "mobile_number"
  }
}


// MARK: - Persistence

extension Contact: FetchableRecord, MutablePersistableRecord {
  // Define database columns from CodingKeys
  fileprivate enum Columns {
    static let firstName = Column(CodingKeys.firstName)
    static let lastName  = Column(CodingKeys.lastName)
    static let mobileNumber = Column(CodingKeys.mobileNumber)
  }
}
