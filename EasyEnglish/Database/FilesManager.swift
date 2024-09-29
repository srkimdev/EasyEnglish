//
//  FilesManager.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/29/24.
//

import Foundation
import UIKit

final class FilesManager {
    
    static let shared = FilesManager()
    
    private init() { }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
    
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
    
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
    
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        
        let filePath: String
    
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }

        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

        if #available(iOS 16.0, *) {
            filePath = fileURL.path()
        } else {
            filePath = fileURL.path
        }
        
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        } else {
            return UIImage(systemName: "star")
        }
    
    }
    
    func removeImageFromDocument(filename: String) {
    
        let filePath: String
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }

        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

        if #available(iOS 16.0, *) {
            filePath = fileURL.path()
        } else {
            filePath = fileURL.path
        }
        
        if FileManager.default.fileExists(atPath: filePath) {
            do {
               try FileManager.default.removeItem(atPath: filePath)
            } catch {
               print("file remove error", error)
            }
        } else {
           print("file no exist")
        }
    
    }
    
}
