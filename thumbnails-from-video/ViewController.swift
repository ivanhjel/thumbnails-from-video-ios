//
//  ViewController.swift
//  thumbnails-from-video
//
//  Created by Ivan Lé Hjelmeland on 30/11/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var asset: AVAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "production ID_5102663", ofType:"mov") {
            let url = URL(fileURLWithPath: path)
            let asset = AVAsset(url: url)
            let duration: CMTime = asset.duration
            let seconds = Int(duration.seconds)
            self.asset = asset
            slider.minimumValue = 0
            slider.maximumValue = Float(seconds)
            sliderValueChanged(self)
        }
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        if let url = (asset as? AVURLAsset)?.url {
            AVAsset(url: url).generateThumbnail(seconds: Double(self.slider.value)) { image in
                DispatchQueue.main.async {
                    guard let image = image else { return }
                    self.imageView.image = image
                }
            }
        }
    }
    
}
