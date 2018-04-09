//
//  ConnectionKit.swift
//  ConnectionKit
//
//  Created by Ian McDowell on 4/9/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import Foundation

/// Loads the set of connections embedded within the app, and exposes them to the app.
public class ConnectionManager {

    private struct Constants {
        static let ConnectionsPath = "Connections"
    }

    public static let availableConnections: [ServerConnection.Type] = loadAvailableConnections()

    private static func loadAvailableConnections() -> [ServerConnection.Type] {
        do {
            let connectionsDirectory = Bundle.main.bundleURL.appendingPathComponent(Constants.ConnectionsPath)
            let contents = try FileManager.default.contentsOfDirectory(at: connectionsDirectory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])

            return contents.compactMap { bundleURL in
                guard
                    let bundle = Bundle.init(url: bundleURL),
                    let principalClass = bundle.principalClass
                else { return nil }

                return principalClass as? ServerConnection.Type
            }
        } catch {
            return []
        }
    }
}

