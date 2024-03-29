//
//  DocumentViewController.swift
//  iCloud text editor
//
//  Created by Ahmed Adel on 9/7/19.
//  Copyright © 2019 Ahmed Adel. All rights reserved.
//

import UIKit
import Sourceful

class DocumentViewController: UIViewController,SyntaxTextViewDelegate {
    
    @IBOutlet weak var textView: SyntaxTextView!
    var document: Document?
    
    let lexer = SwiftLexer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.theme = DefaultSourceCodeTheme()
        textView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.title = self.document?.fileURL.deletingPathExtension().lastPathComponent
                self.textView.text = self.document?.text ?? ""
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @objc func dismissDocumentViewController() {
        document?.text = textView.text
        document?.updateChangeCount(.done)
        
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @objc func shareTapped(sender:UIBarButtonItem)
    {
        guard let url = document?.fileURL else {return}
            let ac = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            ac.popoverPresentationController?.barButtonItem = sender
            present(ac,animated: true)
    }
    
    func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
}
