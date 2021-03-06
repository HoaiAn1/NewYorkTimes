//
//  HomeInteractor.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomePresenterProtocol?
    lazy var repository: ArticleRepositoryProtocol = ArticleRepository.shared
    var requestQueue = DispatchQueue.global()

    private let pageSize = API.Default.pageSize
    private var pageOffset: Int = 0
    
    private weak var currentRequest: Cancellable?
    
    func initialFetchArticles() {
        
        requestQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.fetch(with: 0, pageSize: self.pageSize, isInitialFetch: true)
        }
    }

    func fetchArticles() {
        
        requestQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.fetch(with: self.pageOffset, pageSize: self.pageSize, isInitialFetch: false)
        }
    }
    
    private func fetch(with pageOffset: Int, pageSize: Int, isInitialFetch: Bool) {

        currentRequest?.cancel()
        
        currentRequest = repository.fetchArticles(pageOffset: pageOffset, pageSize: pageSize, fetchStrategy: .serverOnly) { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            self.pageOffset = pageOffset + pageSize
            
            switch result {
            case .success(let articles):
                
                if isInitialFetch {
                    self.presenter?.didInitialFetchSuccess(articles)
                } else {
                    self.presenter?.didFetchSuccess(articles)
                }
                
            case .failure(let error):
                
                if let error = error as? NetworkError, error == .cancelled {
                    
                    if isInitialFetch {
                        self.presenter?.didInitialFetchSuccess([])
                    } else {
                        self.presenter?.didFetchSuccess([])
                    }
                    
                } else {
                    
                    if isInitialFetch {
                        self.presenter?.didIntialFetchError(error)
                    } else {
                        self.presenter?.didFetchError(error)
                    }
                }
            }
        }
    }
}
