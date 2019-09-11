//
//  EditorViewManager.swift
//  BridgeExample
//
//  Created by Mauricio Cousillas on 9/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

@objc(EditorViewManager)
class EditorViewManager: RCTViewManager {
  override func view() -> UIView! {
    return EditorView()
  }

  override  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
