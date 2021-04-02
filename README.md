# Contacts - iOS

**Contacts** is yet another contact sample app made to learn better the clean swift architecture.

---

## Tech Stacks


The project was built using **Xcode 12.3**, **Swift 5.3.2**. 
iOS deployment target: **iOS 14.1**.
Persistence of data is handled using `SQLite` RDBMS powered by `GRDB` layer. 

All UI are made programmatically powered by `SnapKit`.

Dependencies are managed by (Cocoapods](https://cocoapods.org/).

[Clean-swift VIP](http://clean-swift.com/) is the architectural pattern used together with [Combine](https://developer.apple.com/documentation/combine).

**Unit Testing** is powered by `Quick` and `Nimble`.
**UI Tests** use Apple's vanilla `XCUITest` test framework.
  
## Dependencies

- CocoaLumberjack/Swift - https://github.com/CocoaLumberjack/CocoaLumberjack
- Firebase - https://github.com/firebase/firebase-ios-sdk
- GRDB - https://github.com/groue/GRDB.swift
- Kingfisher - https://github.com/onevcat/Kingfisher
- Moya - https://github.com/Moya/Moya
- SwiftDate - https://github.com/malcommac/SwiftDate

 ### Dependencies for Test Targets
 
 - Quick - https://github.com/Quick/Quick
 - Nimble - https://github.com/Quick/Nimble
