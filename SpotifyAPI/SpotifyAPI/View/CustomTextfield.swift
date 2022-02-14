//
//  CustomTextfield.swift
//  Meusic
//
//  Created by Angel Zambrano on 1/11/22.
//

import UIKit

//
class CustomTextfield: UITextField {
    let padding: CGFloat
    let height: CGFloat
    
    init(padding: CGFloat, height: CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        
        self.backgroundColor = .red
    }
    
    
    
    
    
    
    
    
    // adding padding to the textfield
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
    
    // required initalizert
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UITextField {
    /// adds the underline to the bottom of the textfield.
    func addUnderLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 8, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 45/255, green: 78/255, blue: 136/255, alpha: 1).cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
    }
}


extension UITextField {
    
    func addrightImage() {
        let img = UIImage(named: "icons8-eye-50")
        
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 0 , height: 0))
        leftImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 20, height: 20))
        leftImageView.image = img
        self.rightView = leftImageView
        self.rightViewMode = .always
        
        
        let gesture  = UITapGestureRecognizer(target: self, action: #selector(handlePan))
        leftImageView.isUserInteractionEnabled = true
        self.rightView?.addGestureRecognizer(gesture)
    }
    
    
    // deals with the imageIcon inside of the textfield being pressed
    // i could embed this inside of the textfield later on
    @objc func handlePan(gesture: UITapGestureRecognizer) {
        
        let tappedImage = gesture.view as! UIImageView
        
        self.isSecureTextEntry = (self.isSecureTextEntry) ? false :  true
        

        tappedImage.image = (self.isSecureTextEntry) ? UIImage(named: "icons8-hide-50") : UIImage(named: "icons8-eye-50")
        
    }
}
