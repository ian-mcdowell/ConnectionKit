//
//  ServerConnection.swift
//  ConnectionKit
//
//  Created by Ian McDowell on 4/9/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import Foundation

/// Connection to a server, protocol to be implemented by various classes (SMB, SSH, S3, etc)
public protocol ServerConnection {
	
	/// Creates a new connection for the account.
	init(address: String, port: Int16, username: String, password: String) throws
	
	/// Name of the connection type
	static var displayName: String { get }
	
	/// Default port for connecting to the server
	static var defaultPort: Int { get }
	
	/// Finds the contents of the directory.
	///
	/// - Parameters:
	///   - directory: The directory (path relative to the root of the server)
	///   - completion: A callback to be called on completion
	func contents(ofDirectory directory: RemotePath, _ completion: @escaping (Result<[RemoteItem]>) -> Void)
	
	/// Downloads the given file to the destination URL.
	///
	/// - Parameters:
	///   - file: The file to download
	///   - destination: The destination.
	///   - completion: A callback to be called on completion
	@discardableResult
	func download(file: RemotePath, to destination: URL, _ completion: @escaping (Error?) -> Void) -> Progress
	
	/// Uploads the file at the local URL to the destination folder
	///
	/// - Parameters:
	///   - file: A local URL pointing to the file to upload
	///   - destination: The folder to place the file in. If nil, the root folder will be used.
	///   - completion: A callback to be called on completion
	func upload(file: URL, renameTo newName: String?, to destination: RemotePath, _ completion: @escaping (Result<RemoteFile>) -> Void)
	
	/// Move a remote file / folder
	///
	/// - Parameters:
	///   - file: The item to move
	///   - destination: The remote path to place the item into. If none provided, the root folder will be used
	///   - completion: A callback to be called on completion
	func move(item: RemotePath, to destination: RemotePath, _ completion: @escaping (Error?) -> Void)
	
	/// Rename a remote file / folder
	///
	/// - Parameters:
	///   - file: The item to move
	///   - destination: The remote path to place the item into
	///   - completion: A callback to be called on completion
	func rename(item: RemotePath, to newName: String, _ completion: @escaping (Error?) -> Void)
	
	/// Creates a directory in the given folder
	///
	/// - Parameters:
	///   - directory: A folder to create the directory in. If none provided, the root folder will be used
	///   - name: The name of the directory
	///   - completion: A callback to be called on completion
	func createDirectory(in directory: RemotePath, named name: String, _ completion: @escaping (Result<RemoteFolder>) -> Void)
	
	/// Deletes the file/folder
	///
	/// - Parameters:
	///   - item: The item to delete
	///   - completion: A callback to be called on completion
	func delete(item: RemotePath, _ completion: @escaping (Error?) -> Void)
}

/// Default implementations of above methods/properties, which are optional overrides
public extension ServerConnection {
	/// Can the user choose another port?
	static var allowsCustomPort: Bool { return false }
	
	/// mdns service type, i.e. "_smb._tcp"
	static var bonjourServiceType: String? { return nil }
	
	/// Override the display name for the "Username" field when creating an account
	static var customUsernameDisplayName: String? { return nil }
	
	/// Override the display name for the "Password" field when creating an account
	static var customPasswordDisplayName: String? { return nil }
	
	/// Override the display name for the "Hostname" field when creating an account
	static var customHostnameDisplayName: String? { return nil }
	
	/// If not nil, only these hostnames will be possible to connect to.
	static var possibleHostnames: [(name: String, value: String)]? { return nil }
}
