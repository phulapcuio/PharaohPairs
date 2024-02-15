//
//  ProfileVC.swift
//  Egypt
import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    private let postService = PostService.shared
    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.homeButtons.addTarget(self, action: #selector(goButtonTappedHome), for: .touchUpInside)
        contentView.profileBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        contentView.infoButtons.addTarget(self, action: #selector(goButtonTappedInfo), for: .touchUpInside)
        contentView.setupButtons.addTarget(self, action: #selector(goButtonTappedSetup), for: .touchUpInside)
    }
    
    @objc func goButtonTappedHome() {
        navigationController?.popViewController(animated: true)
        updateName()
    }
    
    @objc func goButtonTappedInfo() {
        let infoVC = InfoVC()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @objc func goButtonTappedSetup() {
        let setupVC = SetupVC()
        navigationController?.pushViewController(setupVC, animated: true)
    }

    private func updateName() {
        if UserMemory.shared.userName != nil {
            PostService.shared.updateUserName(userName: UserMemory.shared.userName!) { result in
                switch result {
                case .success(let response):
                    print("Успешно обновлено:", response)
                case .failure(let error):
                    print("Ошибка при обновлении имени пользователя:", error)
                }
            }
        }
    }

    @objc func goTakePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "Pick Photo", message: nil, preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "Camera", style: .default) { _ in
                self.imagePicker.sourceType = .camera
            }
            let action2 = UIAlertAction(title: "photo library", style: .default) { _ in
                self.imagePicker.sourceType = .photoLibrary
            }
            let cancel = UIAlertAction(title: "cancel", style: .cancel)
            present(imagePicker, animated: true, completion: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(cancel)
            present(alert, animated: true)
        } else {
            print("Камера недоступна")
        }
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocal(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id  = UserMemory.shared.userID {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
            try? data.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImageFromLocal() -> UIImage? {
        guard let id = UserMemory.shared.userID else { return nil }
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            contentView.profileBtn.setImage(image, for: .normal)
            saveImageToLocal(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
  

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: UINavigationControllerDelegate {
    
}
