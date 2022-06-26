import UIKit

final class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let updatedText = Observable<String>()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatedText.value = textField.text
    }
}
