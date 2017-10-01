//
//  FaceLandmarkDetectView.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 01-10-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import Vision

class FaceLandmarkDetectView: UIView {

    // MARK: - Properties

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tryAgainButton: UIButton!

    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initial state
        activityIndicator.isHidden = true
        imageView.isHidden = true
        tryAgainButton.isHidden = true
    }

    // MARK: Processing

    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    // Render the original image with all the facial features that were found
    func render(_ image: UIImage, with observations: [VNFaceObservation]) {
        // Start a new rendering pass using the size of our input image
        let renderer = UIGraphicsImageRenderer(size: image.size)

        // Immediately draw the original image so that it fills the background
        imageView.isHidden = false
        tryAgainButton.isHidden = false
        imageView.image = renderer.image { context in
            image.draw(at: .zero)

            UIColor.red.set()
            context.cgContext.setLineWidth(10)

            // Vision counts its Y axis from bottom up whereas UIKit counts from top down.
            // Flip the coordinates to match Vision's Y axis.
            context.cgContext.translateBy(x: 0, y: image.size.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)

            // Render vision results
            for face in observations {

                let features = [
                    face.landmarks?.faceContour,
                    face.landmarks?.leftEye,
                    face.landmarks?.leftEyebrow,
                    face.landmarks?.leftPupil,
                    face.landmarks?.innerLips,
                    face.landmarks?.nose,
                    face.landmarks?.outerLips,
                    face.landmarks?.rightEye,
                    face.landmarks?.rightEyebrow,
                    face.landmarks?.rightPupil
                ]

                // Loop over al the regions. unwrapping any that have a value and ignoring any that don't
                for case let feature? in features {
                    let points = feature.pointsInImage(imageSize: image.size)
                    context.cgContext.addLines(between: points)
                    context.cgContext.strokePath()
                }
            }
        }
    }
}
