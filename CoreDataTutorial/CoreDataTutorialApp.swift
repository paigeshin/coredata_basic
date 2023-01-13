//
//  CoreDataTutorialApp.swift
//  CoreDataTutorial
//
//  Created by paige shin on 2023/01/12.
//

import SwiftUI

@main
struct CoreDataTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
