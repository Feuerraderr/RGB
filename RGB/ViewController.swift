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
        
        redSlider.value = 0.2
        greenSlider.value = 0.5
        blueSlider.value = 0.8
        
        setColorValue(bySlider: redSlider)
        setColorValue(bySlider: greenSlider)
        setColorValue(bySlider: blueSlider)
        
        setViewColor()
        
    }
    
    
    @IBAction func redSliderDidChange() {
        setColorValue(bySlider: redSlider)
        setViewColor()
    }
    
    @IBAction func greenSliderDidChange() {
        setColorValue(bySlider: greenSlider)
        setViewColor()
    }
    
    @IBAction func blueSliderDidChange() {
        setColorValue(bySlider: blueSlider)
        setViewColor()
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
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setColorValue(bySlider slider: UISlider) {
        switch slider {
        case redSlider:
            redValueLabel.text = String(format: "%.2f", redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        }
    }
}

