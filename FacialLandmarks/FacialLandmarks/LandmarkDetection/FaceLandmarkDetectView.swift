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

    var facecontourOn = true
    var leftEyeOn = true
    var leftEyebrowOn = true
    var leftPupilOn = true
    var innerLipsOn = true
    var noseOn = true
    var outerLipsOn = true
    var rightEyeOn = true
    var rightEyebrowOn = true
    var rightPupilOn = true
    var noseCrestOn = true
    var mediaLineOn = true

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
            context.cgContext.setLineWidth(3)

            // Vision counts its Y axis from bottom up whereas UIKit counts from top down.
            // Flip the coordinates to match Vision's Y axis.
            context.cgContext.translateBy(x: 0, y: image.size.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)

            // Render vision results
            for face in observations {

                guard let fc = face.landmarks?.faceContour else { return }
                guard let le = face.landmarks?.leftEye else { return }
                guard let leb = face.landmarks?.leftEyebrow else { return }
                guard let lep = face.landmarks?.leftPupil else { return }
                guard let il = face.landmarks?.innerLips else { return }
                guard let no = face.landmarks?.nose else { return }
                guard let ol = face.landmarks?.outerLips else { return }
                guard let re = face.landmarks?.rightEye else { return }
                guard let reb = face.landmarks?.rightEyebrow else { return }
                guard let rep = face.landmarks?.rightPupil else { return }
                guard let noc = face.landmarks?.noseCrest else { return }
                guard let ml = face.landmarks?.medianLine else { return }

                var features: [VNFaceLandmarkRegion2D] = []
                if leftEyeOn { features.append(le) }
                if leftEyebrowOn { features.append(leb) }
                if leftPupilOn { features.append(lep)}
                if innerLipsOn { features.append(il)}
                if noseOn { features.append(no)}
                if outerLipsOn { features.append(ol)}
                if rightEyeOn { features.append(re)}
                if rightEyebrowOn { features.append(reb)}
                if rightPupilOn { features.append(rep)}
                if noseCrestOn { features.append(noc)}
                if mediaLineOn { features.append(ml)}
                if facecontourOn { features.append(fc)}


                // Loop over al the regions. unwrapping any that have a value and ignoring any that don't
                for case let feature in features {
                    let points = feature.pointsInImage(imageSize: image.size)
                    for (index, point) in points.enumerated() {
                        let tappingRect = CGRect(x: point.x - 35, y: point.y, width: 70, height: 70)
                        context.cgContext.addLines(between: points)
                        context.cgContext.strokePath()

                        if let im = UIImage(named: "number\(index + 1)") {
                            context.cgContext.draw(im.cgImage!, in: tappingRect)
                            }
                        }

                }
            }
        }
    }
}
