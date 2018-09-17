//
//  InputAccessoryView.swift
//  InputAccessoryView
//
//  Created by HoangLuyen on 9/17/18.
//  Copyright © 2018 HoangLuyen. All rights reserved.
//

import UIKit

protocol InputAccessoryViewDelegate: class {
    func inputAccessoryDidBeginEditing()
    func addRow(text: String)
    func inputAccessoryDidChangeSize()
    func inputAccessoryDidEndEditing()
}

class InputAccessoryView: UIView {
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var addComment: UIButton!
    
    
    weak var delegate: InputAccessoryViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .flexibleHeight
        inputTextView.delegate = self
        textViewDidChange(inputTextView)
    }
    @IBAction func commentDidTouch(_ sender: UIButton) {
        delegate?.addRow(text: inputTextView.text)
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
    }
    override var intrinsicContentSize: CGSize {
        return self.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
    
}
extension InputAccessoryView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.delegate?.inputAccessoryDidBeginEditing()
            })
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = inputTextView.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        if inputTextView.frame.size.height != size.height {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.delegate?.inputAccessoryDidChangeSize()
            })
        }
        addComment.isEnabled = textView.text != ""
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.delegate?.inputAccessoryDidEndEditing()
        })
    }
}
