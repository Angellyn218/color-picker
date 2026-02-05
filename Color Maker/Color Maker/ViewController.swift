//
//  ViewController.swift
//  Color Maker
//
//  Created by Angel Lyn Cervantes
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet var MainColorView: UIView!
    
    @IBOutlet var ControlView: UIStackView!
    
    // Red
    @IBOutlet weak var RedDisplay: UITextField!
    
    @IBOutlet weak var RedSlider: UISlider!
    
    @IBOutlet weak var RedSwitch: UISwitch!
    
    // Green
    @IBOutlet weak var GreenDisplay: UITextField!
    
    @IBOutlet weak var GreenSlider: UISlider!
    
    @IBOutlet weak var GreenSwitch: UISwitch!
    
    // Blue
    @IBOutlet weak var BlueDisplay: UITextField!
    
    @IBOutlet weak var BlueSlider: UISlider!
    
    @IBOutlet weak var BlueSwitch: UISwitch!
    
    
    // Others
    @IBOutlet weak var HexColor: UILabel!
    
    @IBOutlet weak var ColorView: UIButton!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    
    // Constraints
    // Portrait
    @IBOutlet var ControlHeightPortrait: NSLayoutConstraint!
    
    @IBOutlet var ColorSafeTrailingPortrait: NSLayoutConstraint!
    
    @IBOutlet var ColorSafeBottomPortrait: NSLayoutConstraint!
    
    @IBOutlet var ColorBottomControlTopPortrait: NSLayoutConstraint!
    
    @IBOutlet var ControlSafeLeadingPortrait: NSLayoutConstraint!
   
    
    // Landscape
    @IBOutlet var ColorSafeBottomLandscape: NSLayoutConstraint!
    
    @IBOutlet var ColorTrailingControlLeadingLandscape: NSLayoutConstraint!
    
    @IBOutlet var ColorWidthLandscape: NSLayoutConstraint!
        
    @IBOutlet var ControlWidthLandscape: NSLayoutConstraint!
    
    @IBOutlet var ControlSafeTopLandscape: NSLayoutConstraint!
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RedDisplay.delegate = self
        GreenDisplay.delegate = self
        BlueDisplay.delegate = self
        
        loadConfiguration()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if size.width > size.height {
            print("Landscape mode")
            let screenHeight = size.height
            
            // Portrait = false
            ControlHeightPortrait.isActive = false
            ColorSafeTrailingPortrait.isActive = false
            ColorBottomControlTopPortrait.isActive = false
            ControlSafeLeadingPortrait.isActive = false
            
            // Landscape = true
            ColorSafeBottomLandscape.isActive = true
            ColorTrailingControlLeadingLandscape.isActive = true
            ColorWidthLandscape.isActive = true
            ControlWidthLandscape.isActive = true
            ControlSafeTopLandscape.isActive = true
            
            ControlView.spacing = (screenHeight - 209.5) / 7
        } else {
            print("Portrait mode")
            // Portrait = true
            ControlHeightPortrait.isActive = true
            ColorSafeTrailingPortrait.isActive = true
            ColorBottomControlTopPortrait.isActive = true
            ControlSafeLeadingPortrait.isActive = true
            
            // Landscape = false
            ColorSafeBottomLandscape.isActive = false
            ColorTrailingControlLeadingLandscape.isActive = false
            ColorWidthLandscape.isActive = false
            ControlWidthLandscape.isActive = false
            ControlSafeTopLandscape.isActive = false
            
            ControlView.spacing = 1
        }
    }

    @IBAction func ResetAll(_ sender: Any) {
        ColorView.backgroundColor = UIColor.black
        HexColor.text = "#000000"
        RedSlider.value = 0
        RedSwitch.setOn(false, animated: false)
        RedDisplay.text = "0"
        GreenSlider.value = 0
        GreenSwitch.setOn(false, animated: false)
        GreenDisplay.text = "0"
        BlueSlider.value = 0
        BlueSwitch.setOn(false, animated: false)
        BlueDisplay.text = "0"
        
        saveChanges()
    }
    
    
    @IBAction func SetColorView(_ sender: Any) {
        updateColorView()
    }
    
    
    @IBAction func SetDisplay(_ sender: UISlider) {
        if RedSlider.value == 0 {
            RedSwitch.setOn(false, animated: false)
        } else {
            RedSwitch.setOn(true, animated: false)
            RedDisplay.text = String(format: "%.2f", RedSlider.value)
        }
        
        if GreenSlider.value == 0 {
            GreenSwitch.setOn(false, animated: false)
        } else {
            GreenSwitch.setOn(true, animated: false)
            GreenDisplay.text = String(format: "%.2f", GreenSlider.value)
        }
        
        if BlueSlider.value == 0 {
            BlueSwitch.setOn(false, animated: false)
        } else {
            BlueSwitch.setOn(true, animated: false)
            BlueDisplay.text = String(format: "%.2f", BlueSlider.value)
        }
        
        saveChanges()
        
    }
    
    
    @IBAction func ResetColor(_ sender: UISwitch) {
        updateColorView()
        saveChanges()
        
    }
    
    func saveChanges() {
        let defaults = UserDefaults.standard
        
        // Save slider values
        defaults.set(RedSlider.value, forKey: "RedSliderValue")
        defaults.set(GreenSlider.value, forKey: "GreenSliderValue")
        defaults.set(BlueSlider.value, forKey: "BlueSliderValue")
        
        // Save switch states
        defaults.set(RedSwitch.isOn, forKey: "RedSwitchState")
        defaults.set(GreenSwitch.isOn, forKey: "GreenSwitchState")
        defaults.set(BlueSwitch.isOn, forKey: "BlueSwitchState")
        
        // Update displays
        RedDisplay.text = String(format: "%.2f", RedSlider.value)
        GreenDisplay.text = String(format: "%.2f", GreenSlider.value)
        BlueDisplay.text = String(format: "%.2f", BlueSlider.value)
        
    }

    
    func loadConfiguration() {
        let defaults = UserDefaults.standard
        
        // Load values for sliders
        RedSlider.value = defaults.float(forKey: "RedSliderValue")
        GreenSlider.value = defaults.float(forKey: "GreenSliderValue")
        BlueSlider.value = defaults.float(forKey: "BlueSliderValue")
        
        // Load switch states
        RedSwitch.isOn = defaults.bool(forKey: "RedSwitchState")
        GreenSwitch.isOn = defaults.bool(forKey: "GreenSwitchState")
        BlueSwitch.isOn = defaults.bool(forKey: "BlueSwitchState")
        
        // Update displays
        RedDisplay.text = String(format: "%.2f", RedSlider.value)
        GreenDisplay.text = String(format: "%.2f", GreenSlider.value)
        BlueDisplay.text = String(format: "%.2f", BlueSlider.value)
        
        // Call any additional UI updates
        SetDisplay(RedSlider)
        updateColorView()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text), value >= 0.0, value <= 1.0 {
            switch textField {
            case RedDisplay:
                RedSlider.value = value
                RedSwitch.setOn(value > 0, animated: false)
            case GreenDisplay:
                GreenSlider.value = value
                GreenSwitch.setOn(value > 0, animated: false)
            case BlueDisplay:
                BlueSlider.value = value
                BlueSwitch.setOn(value > 0, animated: false)
            default:
                break
            }
            updateColorView()
            saveChanges()
        } else {
            // Reset invalid input
            resetTextField(textField)
        }
    }
    
    func updateColorView() {
        var red = CGFloat(RedSlider.value);
        if !RedSwitch.isOn {
            red = 0
        }
        
        var green =  CGFloat(GreenSlider.value)
        if !GreenSwitch.isOn {
            green = 0
        }
        
        var blue = CGFloat(BlueSlider.value)
        if !BlueSwitch.isOn {
            blue = 0
        }
        
        ColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        
        HexColor.text = String(format: "#%02X%02X%02X", r, g, b)
    }
        
    func resetTextField(_ textField: UITextField) {
        switch textField {
        case RedDisplay:
            textField.text = String(format: "%.2f", RedSlider.value)
        case GreenDisplay:
            textField.text = String(format: "%.2f", GreenSlider.value)
        case BlueDisplay:
            textField.text = String(format: "%.2f", BlueSlider.value)
        default:
            break
        }
    }
    
}
