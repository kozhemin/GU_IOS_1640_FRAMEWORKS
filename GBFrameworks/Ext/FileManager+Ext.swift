//
//  FileManager.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 09.06.2022.
//

import UIKit

extension FileManager {
    
   static func saveImage(_ image: UIImage?) {
        guard let image = image else { return }
        do {
            let documentsDirectory = try self.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileName = "image.jpg"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if let data = image.jpegData(compressionQuality:  1),
               !self.default.fileExists(atPath: fileURL.path) {
                try data.write(to: fileURL)
                print("file saved")
            }
        } catch {
            print("error:", error)
        }
    }
}
