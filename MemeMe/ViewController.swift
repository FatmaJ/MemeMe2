//
//  ViewController.swift
//  MemeMe
//
//  Created by fatema on 21/09/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UITextFieldDelegate {

  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var album: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    
    
   
    
      override func viewDidLoad() {
        super.viewDidLoad()
        setuptextFieldStyle(topTextField, text: "TOP" )
        setuptextFieldStyle(bottomTextField, text: "BOTTOM")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        if imageView.image == nil {
            shareButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
        
        }
         subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func setuptextFieldStyle(_ textField: UITextField ,text:String) {
        textField.defaultTextAttributes = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth : -4
        ]
        textField.textAlignment = .center
        textField.delegate = self
        textField.text = text
    }
    //keyboard
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing{
             view.frame.origin.y = -getKeyboardHeight(notification)
        }
    
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
    return true
        
    }
    func textFieldDidBeginEditing(_ textField:UITextField){
        let text = textField.text ?? ""
        if (textField == topTextField && text == "TOP") {
            textField.text = ""
            
        }else if (textField == bottomTextField && text == "BOTTOM") {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField : UITextField){
        let isEmpty = textField.text?.isEmpty ?? false
        if isEmpty && textField == topTextField {
            topTextField.text = "TOP"
        }else
            if isEmpty && textField == bottomTextField {
            bottomTextField.text = "BOTTOM"
        }
    }
    
    // image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info [.originalImage] as? UIImage
        updateImageView(image: image)
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
    func updateImageView (image:UIImage?){
        imageView.image = image
        shareButton.isEnabled = (image != nil)
    }
    
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = (sender.tag == 0) ? .camera : .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }

   
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        updateImageView(image:nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, completed,items, error)in
            if completed {
                self.save()
            }
        }
         present(activityViewController , animated:true, completion:nil)
    }
    func generateMemedImage() -> UIImage{
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.drawHierarchy(in: imageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
    
    
    func save(){
        
    let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        dismiss(animated: true, completion: nil)
    }


}
