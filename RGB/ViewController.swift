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
        
        redValueLabel.text = redSlider.value.formatted()
        greenValueLabel.text = greenSlider.value.formatted()
        blueValueLabel.text = blueSlider.value.formatted()
        
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
}

