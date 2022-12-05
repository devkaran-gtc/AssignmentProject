//
//  FloatingLabelInput.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/2/22.
//

import UIKit

class FloatingLabelInput: UITextField {
    
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero) // Label
    var floatingLabelHeight: CGFloat = 10 // Default height
    @IBInspectable
    var _placeholder: String? // we cannot override 'placeholder'
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor(red: 77/255, green: 217/255, blue: 105/255, alpha: 1) {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var activeBorderColor: UIColor = UIColor(red: 77/255, green: 217/255, blue: 105/255, alpha: 1)
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder // Use our custom placeholder if none is set
        placeholder = self._placeholder // make sure the placeholder is shown
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.layer.borderColor = CGColor(red: 77/255, green: 217/255, blue: 105/255, alpha: 1)
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
            self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)
          
      //      self.floatingLabel.bottomAnchor.constraint(equalTo:
      //      self.topAnchor, constant: -10).isActive = true // Place our label 10pts above the text field
            // Remove the placeholder
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
               self.subviews.forEach{ $0.removeFromSuperview() }
               self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
            self.layer.borderColor = CGColor(red: 29/255, green: 29/255, blue: 32/255, alpha: 1)
        }
        
    }
}
