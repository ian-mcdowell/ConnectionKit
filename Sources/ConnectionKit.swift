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
	
	public struct Connection {
		public let type: ServerConnection.Type
		public let bundleID: String
	}
	
	public static let availableConnections: [Connection] = loadAvailableConnections()
	
	private static func loadAvailableConnections() -> [Connection] {
		do {
			guard let connectionsDirectory = Bundle.mainAppBundle.privateFrameworksURL else { return [] }
			let contents = try FileManager.default.contentsOfDirectory(at: connectionsDirectory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])
			
			return contents.compactMap { bundleURL in
				guard
					let bundle = Bundle.init(url: bundleURL),
					let bundleID = bundle.bundleIdentifier,
					let principalClass = bundle.principalClass as? ServerConnection.Type
					else { return nil }
				
				return Connection.init(type: principalClass, bundleID: bundleID)
			}
		} catch {
			return []
		}
	}
}

private extension Bundle {
	static var mainAppBundle: Bundle {
		var bundle = Bundle.main
		if bundle.bundleURL.pathExtension == "appex" {
			// Peel off two directory levels - MY_APP.app/PlugIns/MY_APP_EXTENSION.appex
			let url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
			if let otherBundle = Bundle(url: url) {
				bundle = otherBundle
			}
		}
		return bundle
	}
}

