//
//  InfoLabel.swift
//  LightPhotoBrowser
//
//  Created by svpcadmin on 4/6/17.
//  Copyright © 2017 tamanyan. All rights reserved.
//

import UIKit

public protocol InfoLabelDelegate: class {
    func infoLabel(_ infoLabel: InfoLabel, didExpand expanded: Bool)
}

open class InfoLabel: UILabel {
    lazy var tapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
        let gesture = UITapGestureRecognizer()
        return gesture
    }()

    open var numberOfVisibleLines = 2

    open weak var delegate: InfoLabelDelegate?
    fileprivate var shortText = ""

    var fullText: String {
        didSet {
            updateText(fullText)
            configureLayout()
        }
    }

    // MARK: - Initialization

    public init(text: String, expanded: Bool = false) {
        self.fullText = text
        super.init(frame: CGRect.zero)

        numberOfLines = 0
        updateText(text)

        addGestureRecognizer(tapGestureRecognizer)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    fileprivate func updateText(_ string: String) {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: LightPhotoConfig.InfoLabel.textAttributes)

        attributedText = attributedString
    }

    // MARK: - Helper methods

    fileprivate func heightForString(_ string: String) -> CGFloat {
        return string.boundingRect(
            with: CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSFontAttributeName : font],
            context: nil).height
    }

    fileprivate func numberOfLines(_ string: String) -> Int {
        let lineHeight = "A".size(attributes: [NSFontAttributeName: font]).height
        let totalHeight = heightForString(string)

        return Int(totalHeight / lineHeight)
    }
}

// MARK: - LayoutConfigurable

extension InfoLabel: LayoutConfigurable {
    public func configureLayout() {
    }
}
