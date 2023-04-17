
import UIKit

final class RAddRecipeViewController: UIViewController {
    
    private let rAddNewRecipeView = RAddNewRecipeView()
    private var popView: RPopupView?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create recipe"
        rAddNewRecipeView.delegate = self
        rAddNewRecipeView.recipeDescriptionTextView.delegate = self
        rAddNewRecipeView.recipeNameTextView.delegate = self
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
    func didtakePhotoButtonTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
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
        picker.dismiss(animated: true)
        popView?.animateOut()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//MARK: - TextViewsDelegate
extension RAddRecipeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width,
                          height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        guard textView.contentSize.height < 130.0 else { textView.isScrollEnabled = true; return }
        
        textView.isScrollEnabled = false
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray2 {
            textView.text = nil
            textView.textColor = .label
        }
    }
}
