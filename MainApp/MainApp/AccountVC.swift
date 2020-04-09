//
//  AccountVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/03/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class AccountVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //outlets of all the elements
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    let imageDelegate = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the image view round
        imageDelegate.delegate = self
        imageOutlet.layer.cornerRadius = imageOutlet.frame.height/2
        imageOutlet.clipsToBounds = true
        
        //add and enable the tap recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadThePhoto(tapGestureRecognizer:)))
        imageOutlet.isUserInteractionEnabled = true
        imageOutlet.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    //function to upload the photp
    @objc open func uploadThePhoto(tapGestureRecognizer : UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageDelegate.allowsEditing = true
        imageDelegate.sourceType = .photoLibrary
        present(imageDelegate, animated: true, completion: nil)
    }

    //function to pick the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageChoosed = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageOutlet.contentMode = .scaleAspectFit
            imageOutlet.image = imageChoosed
        }
        dismiss(animated: true, completion: nil)
    }
    
    //dismiss the view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //action of sign In button
    @IBAction func signInButtonTapped(_ sender: Any) {
    }
    
    //action of join button
    @IBAction func joinButtonTapped(_ sender: Any) {
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           <#code#>
//       }
//
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           <#code#>
//       }
//

}
