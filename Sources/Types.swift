//
//  Types.swift
//  ConnectionKit
//
//  Created by Ian McDowell on 4/9/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import Foundation

public struct ServerConnectionProperties {
	
	public struct PossibleHostname {
		public let name: String
		public let value: String
		
		public init(name: String, value: String) {
			self.name = name; self.value = value
		}
	}
	
	/// Name of the connection type
	public let displayName: String

	/// Default port for connecting to the server
	public let defaultPort: Int

	/// Can the user choose another port?
	public let allowsCustomPort: Bool

	/// mdns service type, i.e. "_smb._tcp"
	public let bonjourServiceType: String?

	/// Override the display name for the "Username" field when creating an account
	public let customUsernameDisplayName: String?

	/// Override the display name for the "Password" field when creating an account
	public let customPasswordDisplayName: String?

	/// Override the display name for the "Hostname" field when creating an account
	public let customHostnameDisplayName: String?

	/// If not nil, only these hostnames will be possible to connect to.
	public let possibleHostnames: [PossibleHostname]?
	
	public init(
		displayName: String,
		defaultPort: Int,
		allowsCustomPort: Bool = false,
		bonjourServiceType: String? = nil,
		customUsernameDisplayName: String? = nil,
		customPasswordDisplayName: String? = nil,
		customHostnameDisplayName: String? = nil,
		possibleHostnames: [PossibleHostname]? = nil
	) {
		self.displayName = displayName
		self.defaultPort = defaultPort
		self.allowsCustomPort = allowsCustomPort
		self.bonjourServiceType = bonjourServiceType
		self.customUsernameDisplayName = customUsernameDisplayName
		self.customPasswordDisplayName = customPasswordDisplayName
		self.customHostnameDisplayName = customHostnameDisplayName
		self.possibleHostnames = possibleHostnames
	}
}

public typealias RemotePath = String
public extension RemotePath {
	var isRoot: Bool { return self.isEmpty || self == "/" }
}

public enum RemoteItemType {
	case file, folder
}

public protocol RemoteItem {
	var name: String { get }
}
public struct RemoteItemMetadata: Equatable {
	public let size: UInt64
	public let lastModified: Date?
	public let created: Date?
	
	public init(size: UInt64, lastModified: Date?, created: Date?) {
		self.size = size; self.lastModified = lastModified; self.created = created
	}
}
public struct RemoteFolder: RemoteItem {
	public let name: String
	public let metadata: RemoteItemMetadata
	
	public init(name: String, metadata: RemoteItemMetadata) {
		self.name = name.hasSuffix("/") ? String(name.dropLast()) : name
		self.metadata = metadata
		
		assert(!self.name.contains("/"))
	}
}
public struct RemoteFile: RemoteItem {
	public let name: String
	public let metadata: RemoteItemMetadata
	
	public init(name: String, metadata: RemoteItemMetadata) {
		self.name = name.hasSuffix("/") ? String(name.dropLast()) : name
		self.metadata = metadata
		
		assert(!self.name.contains("/"))
	}
}

/// Similar to a Swift Optional value, except contains an error instead of none.
public enum Result<Wrapped> {
	
	case value(Wrapped)
	case error(Error)
	
	public var value: Wrapped? {
		switch self {
		case .value(let value):
			return value
		default:
			return nil
		}
	}
	
	public var error: Error? {
		switch self {
		case .error(let error):
			return error
		default:
			return nil
		}
	}
}

