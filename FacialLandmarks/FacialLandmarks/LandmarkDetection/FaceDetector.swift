//
//  FaceDetector.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 01-10-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import Vision

class FaceDetector {

    static func processImage(_ image: UIImage, completion: @escaping ([VNFaceObservation]?) -> Void) {
        // Convert the UIImageOrientation to its corresponding CGImagePropertyOrientation
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }

        // Create a facelandmark detection request
        let faceLandmarkRequest = VNDetectFaceLandmarksRequest { request, error in

            guard error == nil else {
                print("Error detecting facial landmarks, reason: \(error!.localizedDescription)")
                completion(nil)
                return
            }

            // For now only handle the case when there is one face
            guard let observations = request.results as? [VNFaceObservation] else {
                print("Error request has no results")
                completion(nil)
                return
            }

            completion(observations)
        }

        // Exectute the request on a background thread to prevent blocking the main queue
        DispatchQueue.global(qos: .userInitiated).async {
            let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)

            do {
                try imageRequestHandler.perform([faceLandmarkRequest])
            } catch {
                completion(nil)
                print("Error executing face detection landmark, reason: \(error.localizedDescription)")
            }
        }
    }
}
