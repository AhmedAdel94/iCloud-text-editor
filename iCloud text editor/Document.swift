//
//  Document.swift
//  iCloud text editor
//
//  Created by Ahmed Adel on 9/7/19.
//  Copyright © 2019 Ahmed Adel. All rights reserved.
//

import UIKit

enum FileError:Error{
    case invalidData
}

class Document: UIDocument {
    var text = ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data(text.utf8)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let contents = contents as? Data else{
            throw FileError.invalidData
        }
        
        text = String(decoding: contents, as: UTF8.self)
    }
}

