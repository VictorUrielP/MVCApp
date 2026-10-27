//
//  SceneDelegate.swift
//  MVCApp
//
//  Created by Jorge Benavides on 27/10/22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: PokemonsViewControllerComposer.make())
        window?.makeKeyAndVisible()
    }
}
