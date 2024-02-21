//
//  HintTextView.swift
//  xibExercise
//
//  Created by 方奎元 on 2024/2/21.
//

import UIKit

//@IBDesignable
class HintTextView: UIView {
    
//    @IBInspectable var hint: String = "" {
//        didSet {
//            hintLabel.text = text
//        }
//    }
//    
//    @IBInspectable var text: String = "" {
//        didSet {
//            textField.text = text
//        }
//    }
//    
//    @IBInspectable var placeholder: String = "" {
//        didSet {
//            textField.placeholder = text
//        }
//    }

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var underLineView: UIView!
    
    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        hintLabel.text = hint
//        textField.text = text
//        textField.placeholder = placeholder
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // load xib method1
//        let nib = UINib(nibName: "HintTextView", bundle: nil)
//        //XIB can have multiple views. So return value is an array containing the top-level objects in the nib file.
//        if let view = nib.instantiate(withOwner: self).first as? UIView {
//            addSubview(view)
//            view.frame = self.bounds
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.backgroundColor = .clear
//        }
        
//        //load xib method2
//        Bundle.main.loadNibNamed("HintTextView", owner: self)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        contentView.backgroundColor = .clear
        
        //load xib
        let bundle = Bundle(for: HintTextView.self)
        bundle.loadNibNamed("HintTextView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        backgroundColor = .systemBackground
    }
}
