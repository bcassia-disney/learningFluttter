//
//  FlutterChannelManager.swift
//  Runner
//
//  Created by Andrea Bizzotto on 18/04/2018.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import UIKit
import Flutter

class ImagePickerController: UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var handler: ((_ image: String?) -> Void)?

    convenience init(sourceType: UIImagePickerController.SourceType, handler: @escaping (_ image: String?) -> Void) {
        self.init()
        self.sourceType = sourceType
        self.handler = handler
    }
}

class FlutterChannelManager: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let channel: FlutterMethodChannel
    unowned let flutterViewController: FlutterViewController

    var handler: ((_ image: String?) -> Void)?

    init(flutterViewController: FlutterViewController) {

        self.flutterViewController = flutterViewController
        channel = FlutterMethodChannel(name: "com.cassia/imagePicker", binaryMessenger: flutterViewController
        .binaryMessenger)
    }

    func setup() {
        channel.setMethodCallHandler { (call, result) in
            switch call.method {
                case "pickImage":
                    let sourceType: UIImagePickerController.SourceType = "camera" == (call.arguments as? String) ? .camera : .photoLibrary

                    let imagePickerVC = ImagePickerController(sourceType: sourceType, handler: result)
                    self.handler = result
                    imagePickerVC.delegate = self
                    self.flutterViewController.present(imagePickerVC, animated: true, completion: nil)

                default:
                    break
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        handler?(nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            handler?(image.jpegData(compressionQuality: 1)?.base64EncodedString())
        }
        picker.dismiss(animated: true, completion: nil)
    }
}