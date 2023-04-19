
import UIKit

protocol RAddRecipeViewControllerDelegate: AnyObject {
    func didSaveTapped()
}

final class RAddRecipeViewController: UIViewController {
    
    weak var delegate: RAddRecipeViewControllerDelegate?
    
    private lazy var recipeView: RAddNewRecipeView = {
        let view = RAddNewRecipeView(frame: .zero, rAddVC: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var popView: RPopupView?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create recipe"
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        setDelegates()
        setUpView()
    }
    
    private func setDelegates() {
        recipeView.delegate = self
        recipeView.recipeDescriptionTextView.delegate = self
        recipeView.recipeNameTextView.delegate = self
        popView?.delegate = self
    }
    
    private func setUpView() {
        view.addSubview(recipeView)
        NSLayoutConstraint.activate([
            recipeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recipeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recipeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func saveButtonTapped() {
        delegate?.didSaveTapped()
        
        let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
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
        recipeView.imageView.image = UIImage(systemName: "photo.artframe")
        popView?.animateOut()
    }
}

//MARK: - ImagePickerDelegate
extension RAddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            let resizedImage = originalImage.resized(to: CGSize(width: 700, height: 700))
            recipeView.imageView.image = resizedImage
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
