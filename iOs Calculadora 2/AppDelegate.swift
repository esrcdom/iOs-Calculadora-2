//
//  AppDelegate.swift
//  iOs Calculadora 2
//
//  Created by Marcelo Dominguez on 27/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //var WINDOW es el contenedor principal de todo el conjunto, toda la app
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // llamo a SetupView
        setupView()
        
        return true
    }

    // MARK:  - Private Methods
    private func setupView(){
                       // el frame es el tamaño que vamos a querer en la pantalla
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
