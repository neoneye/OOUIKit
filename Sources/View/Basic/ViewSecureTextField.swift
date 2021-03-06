//
//  ViewSecureTextField.swift
//  OOSwift
//
//  Created by Karsten Litsche on 01.09.17.
//
//

import UIKit
import OOBase

public final class ViewSecureTextField: OOView {
    
    // MARK: init

    init(value: OOWritableString, placeholder: OOString, isLast: Bool, optDelegate: UITextFieldDelegate?) {
        self.optDelegate = optDelegate
        self.initialValue = value
        self.editTarget = VrTextFieldTarget(editAction: { text in DoWritableStringSet(text, to: value) })
        self.placeholder = placeholder
        self.isLast = isLast
    }
    
    // MARK: protocol OOView
    
    private var _ui: UITextField?
    public var ui: UIView {
        if _ui == nil { _ui = createView() }
        return _ui!
    }
    
    public func setNeedsRefresh() {
        if _ui != nil { update(view: _ui!) }
        _ui?.setNeedsLayout()
    }
    
    // MARK: private
    
    private let optDelegate: UITextFieldDelegate?
    private let initialValue: OOString
    private let editTarget: VrTextFieldTarget
    private let placeholder: OOString
    private let isLast: Bool
    
    private func createView() -> UITextField {
        let view = UITextField()
        view.isSecureTextEntry = true
        view.text = initialValue.value
        view.placeholder = placeholder.value
        view.clearButtonMode = .always
        view.addTarget(editTarget, action: #selector(VrTextFieldTarget.textDidChanged(_:)), for: .editingChanged)
        view.returnKeyType = isLast ? .done : .next
        if let delegate = optDelegate { view.delegate = delegate }
        update(view: view)
        return view
    }
    
    private func update(view: UITextField) {
        // empty
    }
    
}

// convenience initializer
public extension ViewSecureTextField {
    
    public convenience init(value: OOWritableString, placeholder: String = "", isLast: Bool = true) {
        self.init(value: value, placeholder: StringConst(placeholder), isLast: isLast)
    }
    
    public convenience init(value: OOWritableString, placeholder: OOString, isLast: Bool = true) {
        self.init(value: value, placeholder: placeholder, isLast: isLast, optDelegate: nil)
    }
    
    public convenience init(value: OOWritableString, placeholder: String = "", isLast: Bool = true, delegate: UITextFieldDelegate) {
        self.init(value: value, placeholder: StringConst(placeholder), isLast: isLast, delegate: delegate)
    }
    
    public convenience init(value: OOWritableString, placeholder: OOString, isLast: Bool = true, delegate: UITextFieldDelegate) {
        self.init(value: value, placeholder: placeholder, isLast: isLast, optDelegate: delegate)
    }
    
}

/** Helper for encapsulate the target handling and objc compatibility. */
fileprivate final class VrTextFieldTarget: NSObject {
    
    // MARK: - initialization
    
    init(editAction: @escaping (String) -> OOExecutable) {
        self.editAction = editAction
    }
    
    // MARK: - configuration / api
    
    @objc func textDidChanged(_ sender: UITextField) {
        editAction(sender.text!).execute()
    }
    
    // MARK: - private

    private let editAction: (String) -> OOExecutable
    
}
