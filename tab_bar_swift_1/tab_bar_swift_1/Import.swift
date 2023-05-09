//
//  Import.swift
//  tab_bar_swift_1
//
//  Created by huy on 09/05/2023.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices

class Import: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        
        // Display file picker to select a file
        let filePicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
               filePicker.delegate = self
               present(filePicker, animated: true)
    }
    
}

extension Import: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let sourceURL = urls.first else { return }

        
        //vvdvdvddvdvdvdvd22523563
        let navVC = self.navigationController?.tabBarController?.viewControllers?[0] as! UINavigationController

        guard let filesVC = navVC.viewControllers[0] as? Files else {
            return
        }
        filesVC.view.backgroundColor = .red
        //vbdbvbvfbvfbbffhbvfhbv
        
        
        let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = sourceURL.lastPathComponent

        do {
            let newName = try filesVC.copyFileToDocumentsFolder(sourceURL: sourceURL, destinationURL: destinationURL, fileName: fileName)
            filesVC.links.append((name: newName, date: "", type: sourceURL.pathExtension, url: destinationURL.appendingPathComponent(newName)))
            filesVC.saveLinks()

            if let tableView = filesVC.tableView {
                tableView.reloadData()
            } else {
                print("Error: Table view is nil")
            }
        } catch {
            print("Error copying file: \(error.localizedDescription)")
        }
    }
}
