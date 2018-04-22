//
//  Types.swift
//  ConnectionKit
//
//  Created by Ian McDowell on 4/9/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import Foundation

public typealias RemotePath = String
public extension RemotePath {
	var isRoot: Bool { return self.isEmpty || self == "/" }
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

