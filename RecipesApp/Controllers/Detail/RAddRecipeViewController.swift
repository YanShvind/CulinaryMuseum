
import UIKit

final class RAddRecipeViewController: UIViewController {
    
    private let rAddNewRecipeView = RAddNewRecipeView()
    private var popView: RPopupView?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create recipe"
        rAddNewRecipeView.delegate = self
        popView?.delegate = self
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rAddNewRecipeView)
        NSLayoutConstraint.activate([
            rAddNewRecipeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rAddNewRecipeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rAddNewRecipeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rAddNewRecipeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - ImageButtonTapped
extension RAddRecipeViewController: RAddNewRecipeViewDelegate {
    func didTappedImageButton() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.popView = RPopupView()
            self.popView?.delegate = self
            self.view.addSubview(self.popView!)
        }
    }
}

//MARK: - PopupButtonsTapped
extension RAddRecipeViewController: RPopupViewDelegate {
    func didChooseImageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func didDeleteButtonTapped() {
        rAddNewRecipeView.imageView.image = UIImage(systemName: "photo.artframe")
        popView?.animateOut()
    }
}

//MARK: - ImagePickerDelegate
extension RAddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            let resizedImage = originalImage.resized(to: CGSize(width: 700, height: 700))
            rAddNewRecipeView.imageView.image = resizedImage
        }
        dismiss(animated: true, completion: nil)
        popView?.animateOut()
    }
}
