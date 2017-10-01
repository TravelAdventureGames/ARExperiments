//
//  FaceLandmarkDetectionViewControlelr.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 01-10-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

class FaceLandmarkDetectionViewController: UIViewController {

    // MARK: Properties

    @IBOutlet var mainView: FaceLandmarkDetectView!
    
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
                    self.mainView.render(self.image, with: observations)
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

    @IBAction func tryAgainButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
