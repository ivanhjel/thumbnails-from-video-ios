//
//  AVAsset+Extension.swift
//  thumbnails-from-video
//
//  Created by Ivan Lé Hjelmeland on 30/11/2021.
//

import AVKit

// https://stackoverflow.com/a/55531065/3655491

extension AVAsset {
    func generateThumbnail(seconds: Double, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: seconds, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}
