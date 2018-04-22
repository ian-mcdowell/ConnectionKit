//
//  Errors.swift
//  ConnectionKit
//
//  Created by Ian McDowell on 4/9/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import Foundation

public enum ServerConnectionError: LocalizedError {
	case unableToConnect, noPasswordInKeychain
	
	case notImplemented, dereference, cacheUpdate, invalidURL, invalidFilterString
	
	// Download errors
	case cantDownloadDirectory
	
	// Upload errors
	case cantUploadDirectory, cantUploadToNonDirectory, uploadError
	
	// Listing errors
	case cantListDirectory, cantListDirectoryNotADirectory
	
	// Moving errors
	case moveError
	
	// Create errors
	case createDirectoryError
	
	// Delete errors
	case deleteError
	
	public var errorDescription: String? {
		switch self {
		case .unableToConnect:
			return "Unable to connect to the account."
		case .noPasswordInKeychain:
			return "Unable to find password for account in keychain."
		case .notImplemented:
			return "This feature is not yet implemented."
		case .dereference:
			return "Unable to dereference required object."
		case .cacheUpdate:
			return "Unable to update local cache."
		case .invalidURL:
			return "URL was invalid."
		case .invalidFilterString:
			return "Filter string was invalid."
			
		case .cantDownloadDirectory:
			return "Can't download a directory. Only file downloads are supported."
			
		case .cantUploadDirectory:
			return "Can't upload a directory. Only file uploads are supported."
		case .cantUploadToNonDirectory:
			return "Can't upload to a destination unless it is a directory."
		case .uploadError:
			return "Unable to upload file."
			
		case .cantListDirectory:
			return "Can't list the contents of this directory."
		case .cantListDirectoryNotADirectory:
			return "Unable to list the contents of an item that isn't a directory."
			
		case .moveError:
			return "Unable to move item."
			
		case .createDirectoryError:
			return "Unable to create directory."
			
		case .deleteError:
			return "Unable to delete item."
		}
	}
}

