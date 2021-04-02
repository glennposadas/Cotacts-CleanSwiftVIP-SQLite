//
//  UILabel+Setup.swift
//  Contacts
//
//  Created by Glenn Posadas on 3/29/21.
//  Copyright © 2021 Outliant. All rights reserved.
//

import UIKit

extension UILabel {
    /// A helper function for setting up the normal properties of the label.
    /// This means that the label has no special attributes.
    /// This uses the system font.
    /// Unused `shouldLowerFontSize`.
    /// If font param isn il, use the default system font
    func setup(
        _ text: String,
        font: UIFont? = nil,
        fontSize: CGFloat = 12.0,
        weight: UIFont.Weight = .regular,
        italic: Bool = false,
        textColor: UIColor = .darkGray,
        numberOfLines: Int = 1,
        textAlignment: NSTextAlignment = .natural,
        shouldLowerFontSize: Bool = false) {
        self.text = text
        self.setup(font: font, fontSize: fontSize, weight: weight, italic: italic, textColor: textColor, numberOfLines: numberOfLines, textAlignment: textAlignment, shouldLowerFontSize: shouldLowerFontSize)
    }
    
    /**
     Sets up the label with two different kinds of attributes in its attributed text.
     
     - Important:
         - primaryString = "Total:"
         - secondaryString = "123"
         - This means that the function will concat the secondary string into the primary string and highlights the secondary string.
         - Using the highlightedText means the highlightedText itself is in the primaryString.
     
     - parameters:
        - primaryString: the normal attributed string.
        - secondaryString: the bold or highlighted string.
        - highlightedText: this one is like the secondary string, if this is provided, then the secondaryString is ignored. This is to be used if the highlighted text is not to be concatinated at the end of the primaryString
        - highlightAllFoundHighlightedText: Bool defaults to false. This will allow the method to highlight all the equal texts found in the whole string. For instance, if you want to highlight all the existing words that are equal to "FREE", then set it to true.
     */
    func setAttributedText(
        primaryString: String,
        textColor: UIColor,
        font: UIFont,
        secondaryString: String = "",
        secondaryTextColor: UIColor? = nil,
        secondaryFont: UIFont? = nil,
        highlightedText: String? = nil,
        textAlignment: NSTextAlignment = .center,
        numberOfLines: Int = 1,
        highlightAllFoundHighlightedText: Bool = false,
        lineHeightMultiple: CGFloat = 1,
        lineSpacing: CGFloat = 1,
        shouldLowerFontSize: Bool = false) {
        
        var textToBeHighlighted = ""
        var completeString: String!
        
        self.numberOfLines = numberOfLines
        
        if let highlightedText = highlightedText {
            textToBeHighlighted = highlightedText
            completeString = primaryString
        } else {
            if secondaryString.hasValidValue() {
                textToBeHighlighted = secondaryString
                completeString = "\(primaryString) \(secondaryString)"
            } else {
                completeString = primaryString
            }
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineSpacing = lineSpacing
        
        let completeAttributedString = NSMutableAttributedString(
            string: completeString, attributes: [
                .font: font,
                .foregroundColor: textColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        let secondStringAttribute: [NSAttributedString.Key: Any] = [
            .font: secondaryFont ?? font,
            .foregroundColor: secondaryTextColor ?? textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let range = (completeString as NSString).range(of: textToBeHighlighted)
        
        completeAttributedString.addAttributes(secondStringAttribute, range: range)
        
        if highlightAllFoundHighlightedText {
            let nsRanges = completeString.nsRanges(of: textToBeHighlighted)
            for nsRange in nsRanges {
                completeAttributedString.addAttributes(secondStringAttribute, range: nsRange)
            }
        }
        
        self.attributedText = completeAttributedString
        
        if shouldLowerFontSize {
            self.lineBreakMode = .byTruncatingTail
            self.adjustsFontSizeToFitWidth = true
            self.sizeToFit()
        }
    }
        
    private func setup(
        font: UIFont? = nil,
        fontSize: CGFloat = 12.0,
        weight: UIFont.Weight = .regular,
        italic: Bool = false,
        textColor: UIColor = .darkGray,
        numberOfLines: Int = 1,
        textAlignment: NSTextAlignment = .natural,
        shouldLowerFontSize: Bool = false
    ) {
        self.font = font ?? (italic ? UIFont.italicSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize, weight: weight))
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
}

