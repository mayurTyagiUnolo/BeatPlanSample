//
//  DatePickerDialog.swift
//  senseStaff
//
//  Created by Apple on 14/02/20.
//  Copyright © 2020 SmartSense. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    static let buttonTapped = #selector(DatePickerDialog.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerDialog.deviceOrientationDidChange)
}

open class DatePickerDialog: UIView {
    public typealias DatePickerCallback = ( Date? ) -> Void

    // MARK: - Constants
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 4
    private let kDoneButtonTag: Int = 1
	private let kDefaultMargin: CGFloat = 8
    private let kDefaultButtonHeight: CGFloat = 50

    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    open var datePicker: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!

    // MARK: - Variables
    private var defaultDate: Date?
    private var datePickerMode: UIDatePicker.Mode?
    private var callback: DatePickerCallback?
    var showCancelButton: Bool = false
    var locale: Locale?

    private var textColor: UIColor!
    private var buttonColor: UIColor!
    private var font: UIFont!

    // MARK: - Dialog initialization
    @objc public init(textColor: UIColor = UIColor.black,
                buttonColor: UIColor = UIColor.black,
                font: UIFont = .boldSystemFont(ofSize: 15),
                locale: Locale? = nil,
                showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.textColor = UIColor.black
        self.buttonColor = UIColor.blue
		self.font = UIFont(name: "AvenirNext-Bold", size: 16)
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }

    @objc required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        dialogView = createContainerView()

        dialogView?.layer.shouldRasterize = true
        dialogView?.layer.rasterizationScale = UIScreen.main.scale

        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        dialogView?.layer.opacity = 0.5
        dialogView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)

        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        if let dialogView = dialogView {
            addSubview(dialogView)
        }
    }

    /// Handle device orientation changes
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.frame = UIScreen.main.bounds
        let dialogSize = CGSize(width: 300, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)
        dialogView.frame = CGRect(
            x: (UIScreen.main.bounds.size.width - dialogSize.width) / 2,
            y: (UIScreen.main.bounds.size.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height + 50
        )
    }

    /// Create the dialog view, and animate opening the dialog
    open func show(
        _ title: String,
        doneButtonTitle: String = "Done",
        cancelButtonTitle: String = "Cancel",
        defaultDate: Date = Date(),
        minimumDate: Date? = nil, maximumDate: Date? = nil,
        datePickerMode: UIDatePicker.Mode = .dateAndTime,
        callback: @escaping DatePickerCallback
    ) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton { self.cancelButton.setTitle(cancelButtonTitle, for: .normal) }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        self.datePicker.datePickerMode = self.datePickerMode ?? UIDatePicker.Mode.date
        self.datePicker.date = self.defaultDate ?? Date()
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        self.datePicker.maximumDate = maximumDate
        self.datePicker.minimumDate = minimumDate
        
        if let locale = self.locale { self.datePicker.locale = locale }

        /* Add dialog to main window */
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        window?.endEditing(true)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deviceOrientationDidChange),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )

        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView?.layer.opacity = 1
                self.dialogView?.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        )
    }

    /// Dialog close animation then cleaning and removing the view from the parent
    private func close() {
        let currentTransform = self.dialogView.layer.transform

        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)

        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.transform = transform
                self.dialogView.layer.opacity = 0
            }
        ) { _ in
            for v in self.subviews {
                v.removeFromSuperview()
            }

            self.removeFromSuperview()
            self.setupView()
        }
    }

    /// Creates the container view here: create the dialog, then add the custom content and buttons
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: 300, height: 230 + 2*kDefaultButtonHeight + 2*kDefaultButtonSpacerHeight)

        // For the black background
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        // This is the dialog's container; we attach the custom content and the buttons to this one
        let container = UIView(frame: CGRect(
            x: (screenSize.width - dialogSize.width) / 2,
            y: (screenSize.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        ))

        let cornerRadius = kCornerRadius

        container.layer.cornerRadius = cornerRadius
		container.layer.backgroundColor = UIColor.white.cgColor

        //Title
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = self.textColor
        self.titleLabel.font = self.font.withSize(17)
        container.addSubview(self.titleLabel)

        self.datePicker = configuredDatePicker()
        container.addSubview(self.datePicker)

        // Add the buttons
        addButtonsToView(container: container)

        return container
    }

    fileprivate func configuredDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.setValue(self.textColor, forKeyPath: "textColor")
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = 300
        datePicker.frame.size.height = 216
        return datePicker
    }

    /// Add buttons to container
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width - 2*kDefaultMargin

        var leftButtonFrame = CGRect(
            x: kDefaultMargin,
            y: container.bounds.size.height - 2*kDefaultButtonHeight + 2*kDefaultMargin,
            width: buttonWidth,
            height: kDefaultButtonHeight - 2*kDefaultMargin
        )
        var rightButtonFrame = CGRect(
            x: kDefaultMargin,
            y: container.bounds.size.height - kDefaultButtonHeight + kDefaultMargin,
            width: buttonWidth,
            height: kDefaultButtonHeight - 2*kDefaultMargin
        )
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - kDefaultButtonHeight,
                width: buttonWidth,
                height: kDefaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection != .leftToRight

        if showCancelButton {
            self.cancelButton = UIButton(type: .custom) as UIButton
            self.cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            self.cancelButton.setTitleColor(.link, for: .normal)
            self.cancelButton.setTitleColor(.link, for: .highlighted)
            self.cancelButton.titleLabel?.font = self.font.withSize(16)
            self.cancelButton.layer.cornerRadius = kCornerRadius
            self.cancelButton.layer.borderWidth = 1
            self.cancelButton.layer.borderColor = UIColor.link.cgColor
            self.cancelButton.backgroundColor = .white
            self.cancelButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }

        self.doneButton = UIButton(type: .custom) as UIButton
        self.doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.doneButton.tag = kDoneButtonTag
        self.doneButton.setTitleColor(.white, for: .normal)
        self.doneButton.setTitleColor(.white, for: .highlighted)
        self.doneButton.backgroundColor = .link
        self.doneButton.titleLabel?.font = self.font.withSize(16)
        self.doneButton.layer.cornerRadius = kCornerRadius
        self.doneButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        container.addSubview(self.doneButton)
    }

    @objc func buttonTapped(sender: UIButton) {
        if sender.tag == kDoneButtonTag {
            self.callback?(self.datePicker.date)
        } else {
            self.callback?(nil)
        }

        close()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
