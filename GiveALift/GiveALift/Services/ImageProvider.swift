//
//  ImageProvider.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 05.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation
import Haneke

typealias ImageDownloaded = (_ image: UIImage?) -> Void

final class ImageProvider {
    static func getImage(_ url: URL, completion: @escaping ImageDownloaded) {
        let cache = Shared.imageCache
        let fetcher = NetworkFetcher<UIImage>(URL: url)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            completion(image)
            }.onFailure { (error) in
                completion(nil)
        }
    }
}
