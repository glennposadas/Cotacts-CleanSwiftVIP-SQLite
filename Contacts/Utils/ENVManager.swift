//
//  ENVManager.swift
//  Contacts
//
//  Created by Glenn Posadas on 3/26/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import Foundation

/**
 Manages the environment of the application.
 */
struct ENVManager {
  enum ENVType: String {
    /// Production / Live targetting LIVE API endpoint
    case production = ""
    /// Development env targetting DEV API endpoint
    case development = "DEV"
    /// Unit and UI Testing env targetting DEV API endpoint
    case unitUITest = "TESTING"
  }
  
  private static let production: Bool = {
    #if DEBUG
    let dic = ProcessInfo.processInfo.environment
    if let forceProduction = dic["forceProduction"] , forceProduction == "true" {
      return true
    }
    
    return false
    
    #else
    return true
    #endif
  }()
  
  /**
   Checks wheter your on testing mode or not.
   - returns: A Bool, `true` if you're on testing mode, `false` if you're not.
   */
  private static let isOnUnitTesting: Bool = {
    let enviroment = ProcessInfo.processInfo.environment
    let serviceName = enviroment["XPC_SERVICE_NAME"]
    let injectBundle = enviroment["XCInjectBundle"]
    var isRunning = (enviroment["TRAVIS"] != nil || enviroment["XCTestConfigurationFilePath"] != nil)
    
    if !isRunning {
      if let serviceName = serviceName {
        isRunning = (serviceName as NSString).pathExtension == "xctest"
      }
    }
    
    if !isRunning {
      if let injectBundle = injectBundle {
        isRunning = (injectBundle as NSString).pathExtension == "xctest"
      }
    }
    
    return isRunning
  }()
  
  // MARK: - Public
  
  static var currentEnv: ENVType {
    get {
      if self.production {
        return .production
      } else {
        // Check first if we're in unit testing
        let dic = ProcessInfo.processInfo.environment
        if dic["unitUITest"] == "true" || isOnUnitTesting {
          return .unitUITest
        }
        
        return .development
      }
    }
  }
  
  static var isDevelopment: Bool {
    return currentEnv == .development
  }
  
  static var isTesting: Bool {
    return currentEnv == .unitUITest
  }
  
  static var isProduction: Bool {
    return currentEnv == .production
  }
}


