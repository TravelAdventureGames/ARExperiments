//
//  GetPhotoViewController.swift
//  FacialLandmarks
//
//  Created by Kaira Diagne on 01-10-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

class GetPhotoViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        takePhotoButton.isHidden = !UIImagePickerController.isSourceTypeAvailable(.camera)
        choosePhotoButton.isHidden = !UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }

    // MARK: - IBActions

    @IBAction func takePhotoButtonClick(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    @IBAction func choosePhotoButtonClick(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

extension GetPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to deliver the original image.
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true) {
            let landMarkViewController = FaceLandmarkDetectionViewController(image: originalImage)
            self.navigationController?.pushViewController(landMarkViewController, animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
