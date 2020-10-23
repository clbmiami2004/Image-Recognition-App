//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Christian Lorenzo on 10/22/20.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//MARK: - Properties:
    //imagePicker controller object:
    let imagePicker = UIImagePickerController()
    
//MARK: - Outlets:
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera // This could be change to .library in case we want to use the camera image.
        imagePicker.allowsEditing = false
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //This image is pciked by the user:
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageViewOutlet.image = userPickedImage
            
            //The same image the user picked will get converted into a CIImage
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("UIImage could not be converted into a CIImage")
            }
            
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //Processing images from the imagePickerController:
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: MLModel(contentsOf: MobileNetV2.urlOfModelInThisBundle)) else {
            fatalError("Loading CoreML Model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }

//MARK: - Action:
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

