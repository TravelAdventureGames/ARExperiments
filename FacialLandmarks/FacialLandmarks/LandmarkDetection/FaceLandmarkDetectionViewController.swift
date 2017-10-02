//
//  FaceLandmarkDetectionViewControlelr.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 01-10-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import Vision

class FaceLandmarkDetectionViewController: UIViewController {

    // MARK: Properties

    @IBOutlet var mainView: FaceLandmarkDetectView!
    var obs: [VNFaceObservation] = []
    
    private let image: UIImage

    // MARK: Initialize

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.startLoading()

        FaceDetector.processImage(image) { observations in
            DispatchQueue.main.async {
                self.mainView.stopLoading()
                if let observations = observations {
                    // Success
                    self.obs = observations
                    self.mainView.render(self.image, with: self.obs)
                } else {
                    // Error
                    self.presentErrorAlert()
                }
            }
        }
    }

    // MARK: Actions

    private func presentErrorAlert() {
        let alertController = UIAlertController()
        alertController.title = "Er ging iets fout met de gezichtsherkenning probeer het nog een keer"
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func renderAgain(_ sender: Any) {
        self.mainView.render(self.image, with: obs)
    }
    @IBAction func tryAgainButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func elChanged(_ sender: Any) {
        mainView.leftEyeOn = !mainView.leftEyeOn
    }
    @IBAction func lebChanged(_ sender: Any) {
        mainView.leftEyebrowOn = !mainView.leftEyebrowOn
    }
    @IBAction func lpCHanged(_ sender: Any) {
        mainView.leftPupilOn = !mainView.leftPupilOn
    }
    @IBAction func reChanged(_ sender: Any) {
        mainView.rightEyeOn = !mainView.rightEyeOn
    }
    @IBAction func rebChanged(_ sender: Any) {
        mainView.rightEyebrowOn = !mainView.rightEyebrowOn
    }
    @IBAction func rpChanged(_ sender: Any) {
        mainView.rightPupilOn = !mainView.rightPupilOn
    }
    @IBAction func ilChanged(_ sender: Any) {
        mainView.innerLipsOn = !mainView.innerLipsOn
    }
    @IBAction func olChanged(_ sender: Any) {
        mainView.outerLipsOn = !mainView.outerLipsOn
    }
    @IBAction func mlChanged(_ sender: Any) {
        mainView.mediaLineOn = !mainView.mediaLineOn
    }
    @IBAction func noChanged(_ sender: Any) {
        mainView.noseOn = !mainView.noseOn
    }
    @IBAction func nocChanged(_ sender: Any) {
        mainView.noseCrestOn = !mainView.noseCrestOn
    }
    @IBAction func fcChanged(_ sender: Any) {
        mainView.facecontourOn = !mainView.facecontourOn
    }
    
    

}
