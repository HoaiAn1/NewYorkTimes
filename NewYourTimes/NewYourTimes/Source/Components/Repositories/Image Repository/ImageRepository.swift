//
//  ImageRepository.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ImageRepositoryProtocol {
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void)
}



class ProxyRefType<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}



class ImageRepository: ImageRepositoryProtocol {
    
    private let localDataSource: ImageLocalDataSourceProtocol
    private let remoteDataSource: ImageRemoteDataSourceProtocol
    
    static let shared = ImageRepository()
    
    private init(local: ImageLocalDataSourceProtocol = ImageLocalDataSource(),
         remote: ImageRemoteDataSourceProtocol = ImageRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
    }
    
    private var cachedImages = NSCache<NSURL, UIImage>()
    private let dataAccessQueue = DispatchQueue(label: "ImageRepositoryDataAccessQueue")
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        
        dataAccessQueue.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            if let image = self.cachedImages.object(forKey: url as NSURL) {
                completion(image)
                
            } else {
                
                if let image = self.localDataSource.image(for: url) {
                    self.cachedImages.setObject(image, forKey: url as NSURL)
                    completion(image)
                    
                } else {
                    
                    self.remoteDataSource.image(for: url, completion: { [weak self] (result) in
                        
                        if let image = try? result.get() {
                            
                            self?.dataAccessQueue.sync { [weak self] in
                                self?.cachedImages.setObject(image, forKey: url as NSURL)
                            }
                            
                            self?.localDataSource.saveImage(image, for: url)
                            
                            completion(image)
                            
                        } else {
                            completion(nil)
                        }
                    })
                }
            }
        }
    }
}
