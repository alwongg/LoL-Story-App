//
//  ImageCoreData.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ImageStorage

class ImageStorage {
    
    // MARK: - Properties
    
    let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Image Methods
    
    func imageURL(forKey key: String) -> URL {
        
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectory.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let imageURLs = imageURL(forKey: key)
        if let jpegData = UIImageJPEGRepresentation(image, 0.5) {
            let completeImageURL = try? jpegData.write(to: imageURLs, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let validImage = cache.object(forKey: key as NSString) {
            return validImage
        } else {
            let invalidImageUrl = imageURL(forKey: key)
            
            guard let localImage = UIImage(contentsOfFile: invalidImageUrl.path)
                else {return nil}
            
            cache.setObject(localImage, forKey: key as NSString)
            return localImage
        }
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let deleteURL = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: deleteURL)
        } catch {
            print(error)
        }
    }
    
}
