import UIKit

final class TextViewDelegate: NSObject, UITextViewDelegate {
    
    let updatedText = Observable<String>()
    
    func textViewDidChange(_ textView: UITextView) {
        updatedText.value = textView.text
    }
}
