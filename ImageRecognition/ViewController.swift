//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Christian Lorenzo on 10/22/20.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//MARK: - Properties:
    //imagePicker controller object:
    let imagePicker = UIImagePickerController()
    
//MARK: - Outlets:
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // This could be change to .camera in case we want to use the camera image.
        imagePicker.allowsEditing = false
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageViewOutlet.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

//MARK: - Action:
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

