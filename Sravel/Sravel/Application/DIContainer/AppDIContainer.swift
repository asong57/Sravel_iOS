//
//  AppDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/06/18.
//

import Foundation

final class AppDIContainer {
    // MARK: - DIContainers of scenes
      func makeLoginDIContainer() -> LoginDIContainer {
          return LoginDIContainer()
      }
}
