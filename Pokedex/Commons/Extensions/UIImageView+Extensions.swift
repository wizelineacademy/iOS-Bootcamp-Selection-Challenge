//
//  UIImageView+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit
import Combine

extension UIImageView {

    func setImage(with url: URL,
                  session: URLSession = .shared,
                  cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData,
                  timeoutInterval: TimeInterval = 10,
                  completion: ((URLSessionDataTask?) -> Void)? = nil) {
        session.getAllTasks { tasks in
            guard let currentTask = tasks.first(where: { $0.currentRequest?.url == url }) else {
                return self.addDownloadTask(url: url,
                                            session: session,
                                            cachePolicy: cachePolicy,
                                            timeoutInterval: timeoutInterval,
                                            completion: completion)
            }
            completion?(currentTask as? URLSessionDataTask)
        }
    }

    private func addDownloadTask(url: URL,
                                 session: URLSession = .shared,
                                 cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData,
                                 timeoutInterval: TimeInterval = 10,
                                 completion: ((URLSessionDataTask?) -> Void)? = nil) {
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        let task = session.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
        completion?(task)
    }

}
