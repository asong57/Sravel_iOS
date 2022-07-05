//
//  AppDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/07/04.
//

import Foundation

final class AppDIContainer {
    // MARK: - DIContainers of scenes
      func makeLoginDIContainer() -> LoginDIContainer {
          return LoginDIContainer()
      }
}
