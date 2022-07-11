//
//  SMTextField.swift
//  SmartVCApp
//
//  Created by Sandeep on 01/03/21.
//

import UIKit
@objc public protocol SKFlaotingTextFieldDelegate: UITextFieldDelegate {
    /// it is a delegte method to write a handler for tap on right view, or on the textField if it is set as droppable
    @objc optional func didTapOnRightView(textField: SKFloatingTextField)
    @objc optional func textFieldDidEndEditing(textField : SKFloatingTextField)
    @objc optional func textFieldDidChangeSelection(textField: SKFloatingTextField)
    @objc optional func textFieldDidBeginEditing(textField: SKFloatingTextField)
}
public class SKFloatingTextField : UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bottomErrorLabel: UILabel!
    private var rightViewButton : UIButton!
    private var rightViewTapAction : ( (UIButton) -> Void )?
    private var bottomBorderLayer : CALayer!
    /**
     *Member Variables
     **/
    /// isValidInput : make it true if the text field content is valid according to the user input validation else  take it false to work better with error label
    public var isValidInput : Bool = false
    // MARK: - TextField
    public var delegate: SKFlaotingTextFieldDelegate?
    public var textAlignment : NSTextAlignment = .left {
        didSet {
            self.textField.textAlignment = self.textAlignment
        }
    }
    public var keyBoardType : UIKeyboardType? {
        get {
            return self.textField.keyboardType
        }
        set {
            self.textField.keyboardType = newValue!
        }
    }
    public var isSecureTextInput: Bool {
        get {
            return self.textField.isSecureTextEntry
        } set {
            self.textField.isSecureTextEntry = newValue
        }
    }
    public var borderColor : UIColor  =  .gray {
        didSet {
            self.textField.layer.borderColor = borderColor.cgColor
        }
    }
    // border color while editing the text in the text Field
    public var activeBorderColor : UIColor?
    // background color of the textField
    public var bgColor : UIColor? {
        didSet {
            self.backgroundColor = self.bgColor
            self.contentView.backgroundColor = self.bgColor
            self.textField.backgroundColor = self.bgColor
            self.bottomErrorLabel.backgroundColor = self.bgColor
            self.titleLabel.backgroundColor = self.bgColor
            self.titleView.backgroundColor = self.bgColor
        }
    }
    public var borderWidth : CGFloat = 1 {
        didSet {
            self.textField.layer.borderWidth = self.borderWidth
        }
    }
    public var cornerRadius : CGFloat? {
        didSet {
            self.textField.layer.cornerRadius = self.cornerRadius ?? 0
        }
    }
    // MARK: - textField text
    public var text: String? {
        get {
            return textField.text
        }set {
            textField.text = newValue
        }
    }
    public var textColor : UIColor? {
        get {
            return textField.textColor
        }set {
            textField.textColor = newValue
        }
    }
    public var textFont : UIFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            self.textField.font = textFont
        }
    }
    // MARK: - placeholder
    public var placeholder: String? {
        get {
            return textField.placeholder
        } set {
            textField.attributedPlaceholder = NSAttributedString(string: newValue!, attributes: [NSAttributedString.Key.foregroundColor : placholderColor, NSAttributedString.Key.font : placeholderFont])
        }
    }
    public var placholderColor : UIColor = .gray {
        didSet {
            let text = self.textField.placeholder
            textField.attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: [NSAttributedString.Key.foregroundColor : placholderColor, NSAttributedString.Key.font : placeholderFont])
        }
    }
    public var placeholderFont : UIFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            let text = self.textField.placeholder
            textField.attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: [NSAttributedString.Key.foregroundColor : placholderColor, NSAttributedString.Key.font : placeholderFont])
        }
    }
    // MARK: - Floating Text Label
    public var floatingLabelText : String? {
        get {
            return self.titleLabel.text
        } set {
            self.titleLabel.text = newValue
        }
    }
    public var floatingLabelColor : UIColor? {
        get {
            return self.titleLabel.textColor
        } set {
            self.titleLabel.textColor = newValue
        }
    }
    public var floatingLabelFont : UIFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            self.titleLabel.font = self.floatingLabelFont
        }
    }
    public func showFloatingTitle() {
        self.titleView.isHidden = false
    }
    public func hideFloatingTitle() {
        self.titleView.isHidden = true
    }
    // MARK: - Error Label
    public var errorLabelText : String? {
        get {
            return self.bottomErrorLabel.text
        } set {
            self.bottomErrorLabel.text = newValue
            if newValue?.count ?? 0 > 0 {
                self.textField.layer.borderColor = self.errorLabelColor.cgColor
                self.titleLabel.textColor = self.errorLabelColor
                self.bottomErrorLabel.isHidden = false
            } else {
                self.textField.layer.borderColor = self.borderColor.cgColor
                self.titleLabel.textColor = self.floatingLabelColor
                self.bottomErrorLabel.isHidden = true
            }
        }
    }
    public var errorLabelColor : UIColor {
        get {
            return self.bottomErrorLabel.textColor
        } set {
            self.bottomErrorLabel.textColor = newValue
        }
    }
    public var errorLabelFont : UIFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            self.bottomErrorLabel.font = self.errorLabelFont
        }
    }
    public func showError() {
        self.bottomErrorLabel.isHidden = false
    }
    public func hideError() {
        self.bottomErrorLabel.isHidden = true
    }
    // MARK: - right view
    public var rightView:UIView? {
        get {
            return self.textField.rightView
        }
        set {
            self.textField.rightView = newValue
        }
    }
    /// Set right side image like password secure / non secure button view with its action
    public func setRightView(image : UIImage, tintColor : UIColor,action: ( (UIButton) -> Void )?) {
        self.rightViewTapAction = action
        self.rightViewButton = UIButton(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
        rightViewButton.setImage(image, for: .normal)
        rightViewButton.tintColor = tintColor
        let iconContainerView: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        iconContainerView.addSubview(rightViewButton)
        self.textField.rightView = iconContainerView
        self.textField.rightViewMode = .always
        rightViewButton.addTarget(self, action: #selector(didtapOnRightView), for: .touchUpInside)
    }
    public func changeRightViewImage(image : UIImage, tintColor : UIColor) {
        self.rightViewButton.setImage(image, for: .normal)
        self.rightViewButton.tintColor = tintColor
    }
    @objc private func didtapOnRightView() {
        guard let rightview = self.textField.rightView?.subviews.first as? UIButton else { return }
        rightViewTapAction?(rightview)
        self.delegate?.didTapOnRightView?(textField: self)
    }
    // MARK: - left view
    /// Set left side image in the textField
    public func setLeftImage(image : UIImage,tintColor : UIColor) {
        let iconView = UIImageView(frame:CGRect(x: 0, y: 10, width: 12, height: 11))
        iconView.image = image
        iconView.tintColor = tintColor
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 15, height: 30))
        iconContainerView.addSubview(iconView)
        self.textField.leftView = iconContainerView
        self.textField.leftViewMode = .always
    }
    //MARK: - Initializer
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
         commoninit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         commoninit()
    }
    private func commoninit(){
        Bundle(identifier: "org.cocoapods.SKFloatingTextField")?.loadNibNamed("SKFloatingTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.textField.placeholder = nil
        self.titleView.isHidden = true
        self.bottomErrorLabel.isHidden = true
        self.textField.layer.borderColor = self.borderColor.cgColor
        self.borderWidth = 1
        self.floatingLabelFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.textFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.errorLabelFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.titleLabel.textAlignment = .left
        self.floatingLabelColor = .gray
        self.textColor = .black
        self.bottomErrorLabel.textAlignment = .left
        self.isSecureTextInput = false
        self.setLeftImage(image: UIImage(), tintColor: .lightGray)
        self.bgColor = .white
        self.activeBorderColor = self.borderColor
        // text field editing action
        self.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        self.textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        self.textField.tintColor = .black
    }
    // MARK: - Designs
    /**
     Member Methods
     ***/
    /// Setting some common text Field UI Designs
    /// Circular corner radius
    public func setCircularTFUI() {
        self.cornerRadius = self.textField.layer.frame.size.height/2
    }
    /// having only bottom border
    public func setOnlyBottomBorderTFUI() {
        self.bottomBorderLayer = CALayer()
        bottomBorderLayer.frame = CGRect(x: 0.0, y: self.textField.frame.size.height - 1, width: self.textField.frame.size.width, height: 1.0)
        bottomBorderLayer.backgroundColor = self.borderColor.cgColor
        self.textField.borderStyle = .none
        self.textField.layer.borderWidth = 0
        self.textField.layer.masksToBounds = true
        self.textField.layer.addSublayer(bottomBorderLayer)
    }
    public func updateBottomBorderColor() {
        self.bottomBorderLayer.backgroundColor = self.borderColor.cgColor
    }
    /// Round Text field
    public func setRoundTFUI() {
        self.cornerRadius = 5
    }
    /// Rectangular text field
    public func setRectTFUI() {
        self.cornerRadius = 0
    }
    /// set droppable if you have to put action on tap gesture on the entire textField the acton will be performed using didtaponRightView delegate method
    public func setDroppable() {
        self.textField.isSecureTextEntry = false
        self.textField.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didtapOnRightView))
        self.addGestureRecognizer(tap)
    }
}
extension SKFloatingTextField {
    @objc fileprivate func textFieldDidEndEditing() {
        if self.textField.text == "" {
            self.placeholder = self.floatingLabelText
            self.hideFloatingTitle()
        } else if self.isValidInput {
            self.errorLabelText = ""
        }
        if self.activeBorderColor != nil {
            self.textField.layer.borderColor = self.borderColor.cgColor
        }
        self.delegate?.textFieldDidEndEditing?(textField: self)
    }
    @objc fileprivate func textFieldDidBeginEditing() {
        self.showFloatingTitle()
        self.placeholder = ""
        if let color = self.activeBorderColor {
            self.textField.layer.borderColor = color.cgColor
        }
        self.delegate?.textFieldDidBeginEditing?(textField: self)
    }
    @objc fileprivate func textFieldDidChangeSelection() {
        self.placeholder = ""
        self.showFloatingTitle()
        self.errorLabelText = ""
        if let color = self.activeBorderColor {
            self.textField.layer.borderColor = color.cgColor
        }
        self.delegate?.textFieldDidChangeSelection?(textField: self)
    }
}
