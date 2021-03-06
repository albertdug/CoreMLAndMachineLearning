//
//  ViewController.swift
//  CarML
//
//  Created by Albert Duran on 14/3/18.
//  Copyright © 2018 Albert Duran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var kmsLabel: UILabel!
    @IBOutlet weak var kmsSlider: UISlider!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    let cars = Cars()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackView.setCustomSpacing(25, after: self.modelSegmentedControl)
        self.stackView.setCustomSpacing(25, after: self.extrasSwitch)
        self.stackView.setCustomSpacing(25, after: self.kmsSlider)
        self.stackView.setCustomSpacing(50, after: statusSegmentedControl)
        
        self.calculatedValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculatedValue() {
        
        //formatear el valor del slider
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.maximumFractionDigits = 0
        let formatedKms = formater.string(for: self.kmsSlider.value) ?? "0"
        self.kmsLabel.text = "Kilometraje: \(formatedKms) kms"
        
        //Hacer el calculo del valor del auto
        
        if let prediction = try? cars.prediction(modelo: Double(self.modelSegmentedControl.selectedSegmentIndex), extras: self.extrasSwitch.isOn ? Double(1.0) : Double(0.0), kilometraje: Double(self.kmsSlider.value), estado: Double(self.statusSegmentedControl.selectedSegmentIndex)) {
            
            let clampValue =  max(500, prediction.price)
            
            formater.numberStyle = .currency
            
            self.priceLabel.text = formater.string(for: clampValue)
            
        } else {
            self.priceLabel.text = "Error"
        }
    }
    
    
}

