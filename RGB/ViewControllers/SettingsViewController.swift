//
//  SettingsViewController.swift
//  RGB
//
//  Created by Владислав Резван on 02.07.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setupBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class SettingsViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    weak var delegate: SettingsViewControllerDelegate?
    var startViewBackgroundViewColor: UIColor!
    
    private let minimumValue: Float = 0.0
    private let maximumValue: Float = 1.0
    
    private var components: [Float: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        sliderSetup()
        getComponents()

        setColorValue(bySlider: redSlider)
        setColorValue(bySlider: greenSlider)
        setColorValue(bySlider: blueSlider)
        
        setViewColor()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        
        setToolbar(for: redTextField)
        setToolbar(for: greenTextField)
        setToolbar(for: blueTextField)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        setViewColor()
        setColorValue(bySlider: sender)
    }
    
    @IBAction func doneButtonDidTapped() {
        delegate?.setupBackgroundColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat()
        )
        
        dismiss(animated: true)
    }
    

    
    
    
    private func sliderSetup() {
        redSlider.minimumValue = minimumValue
        redSlider.maximumValue = maximumValue
        redSlider.minimumTrackTintColor = .systemRed
        
        greenSlider.minimumValue = minimumValue
        greenSlider.maximumValue = maximumValue
        greenSlider.minimumTrackTintColor = .systemGreen
        
        blueSlider.minimumValue = minimumValue
        blueSlider.maximumValue = maximumValue
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setViewColor() {
        colorView.backgroundColor = .init(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func setColorValue(bySlider slider: UISlider) {
        switch slider {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = redValueLabel.text
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = greenValueLabel.text
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = blueValueLabel.text
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func getComponents() {
        for (slider, component) in zip([redSlider, greenSlider, blueSlider], startViewBackgroundViewColor.cgColor.components ?? []) {
            slider?.value = Float(component)
        }
    }
    
    private func setToolbar(for textField: UITextField) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let toolbarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let returnAction = UIAction { action in
            textField.resignFirstResponder()
        }
        let returnButton = UIBarButtonItem(title: "Return", primaryAction: returnAction)
        
        toolbar.items = [toolbarSpace, returnButton]
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }
    
    private func showAlert(_ textField: UITextField) {
        let alert = UIAlertController(
            title: "Warning",
            message: "Enter number from 0 to 1!",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = ""
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}

extension String {
    func makeFloat() -> Float {
        guard let float = Float(self) else { return 0}
        return float
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.makeFloat() > 1 {
                showAlert(textField)
                return false
            } else {
                textField.text = String(format: "%.2f", text.makeFloat())
                return true
            }
        } else {
            textField.text = "0.00"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTextField:
            guard let text = redTextField.text else { return }
            redSlider.setValue(text.makeFloat(), animated: true)
            redValueLabel.text = redTextField.text
        case greenTextField:
            guard let text = greenTextField.text else { return }
            greenSlider.setValue(text.makeFloat(), animated: true)
            greenValueLabel.text = greenTextField.text
        default:
            guard let text = blueTextField.text else { return }
            blueSlider.setValue(text.makeFloat(), animated: true)
            blueValueLabel.text = blueTextField.text
        }
        setViewColor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
