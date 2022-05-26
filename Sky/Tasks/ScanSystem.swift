//
//  ScanSystem.swift
//  Sky (iOS)
//
//  Created by Allison Mcentire on 5/26/22.
//

import Foundation

actor ScanSystem {
  let name: String
  let service: ScanTransport?
  
  init(name: String, service: ScanTransport? = nil) {
    self.name = name
    self.service = service
  }
  
  // counts the current system's pending tasks
  private(set) var count = 0

  func commit() {
    count += 1
  }

  func run(_ task: ScanTask) async throws -> String {
    defer { count -= 1 }
    if let service = service {
      return try await service.send(task: task, to: name)
    } else {
      return try await task.run()
    }

  }

}
