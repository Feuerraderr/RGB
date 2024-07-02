//
//  ViewController.swift
//  RGB
//
//  Created by Владислав Резван on 02.07.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    private let minimumValue: Float = 0.0
    private let maximumValue: Float = 1.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        sliderSetup()
        
        redSlider.value = Float.random(in: 0...1)
        greenSlider.value = Float.random(in: 0...1)
        blueSlider.value = Float.random(in: 0...1)
        
        setColorValue(bySlider: redSlider)
        setColorValue(bySlider: greenSlider)
        setColorValue(bySlider: blueSlider)
        
        setViewColor()
        
    }
    
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        setViewColor()
        setColorValue(bySlider: sender)
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
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}
