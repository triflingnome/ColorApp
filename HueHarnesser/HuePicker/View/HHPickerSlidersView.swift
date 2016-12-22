//
//  HHPickerSlidersView.swift
//  ColorApp
//
//  Created by Michael Berg on 12/12/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import UIKit

class HHPickerSlidersView: UIView {
    
    // MARK: Properties
    
    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!
    @IBOutlet private weak var alphaSlider: UISlider!
    
    @IBOutlet private weak var redValueLabel: UILabel!
    @IBOutlet private weak var greenValueLabel: UILabel!
    @IBOutlet private weak var blueValueLabel: UILabel!
    @IBOutlet private weak var alphaValueLabel: UILabel!
    
    private var delegate: HHHueUpdatedDelegate?
    
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: IBActions
    
    @IBAction func slidersValueChanged(sender: UISlider) {
        let updatedRedValue = CGFloat(floatLiteral: CGFloat.NativeType(redSlider.value)) / CGFloat(floatLiteral: 255)
        let updatedGreenValue = CGFloat(floatLiteral: CGFloat.NativeType(greenSlider.value)) / CGFloat(floatLiteral: 255)
        let updatedBlueValue = CGFloat(floatLiteral: CGFloat.NativeType(blueSlider.value)) / CGFloat(floatLiteral: 255)
        let updatedAlphaValue = CGFloat(floatLiteral: CGFloat.NativeType(alphaSlider.value)) / CGFloat(floatLiteral: 255)
        
        let colorWithUpdatedValues = UIColor(red: updatedRedValue,
                                             green: updatedGreenValue,
                                             blue: updatedBlueValue,
                                             alpha: updatedAlphaValue)

        delegate?.updated(with: colorWithUpdatedValues)

        self.updateValueLabel(for: sender)
    }
    
    // MARK: Public Methods
    
    // TODO: once there is a class with HHHueUpdatedDelegate, make this parameter non optional and update test file
    func configure(with delegate: HHHueUpdatedDelegate?, color: UIColor) {
        self.delegate = delegate

        let rgbaDictionary = color.rgbaDictionary()
        
        if let rgbaDictionary = rgbaDictionary {
            // if rgbaDictionary isn't nil, it's ok to force unwrap the contents of it
            redSlider.value = Float(rgbaDictionary["red"]!)
            greenSlider.value = Float(rgbaDictionary["green"]!)
            blueSlider.value = Float(rgbaDictionary["blue"]!)
            alphaSlider.value = Float(rgbaDictionary["alpha"]!)
            
            updateValueLabel(for: redSlider)
            updateValueLabel(for: greenSlider)
            updateValueLabel(for: blueSlider)
            updateValueLabel(for: alphaSlider)
        }
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    private func updateValueLabel(for slider: UISlider) {
        switch slider {
        case redSlider:
            redValueLabel.text = String(redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(greenSlider.value)
        case blueSlider:
            blueValueLabel.text = String(blueSlider.value)
        case alphaSlider:
            alphaValueLabel.text = String(alphaSlider.value)
        default:
            fatalError()
        }
    }

}
