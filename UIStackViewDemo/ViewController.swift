//
//  ViewController.swift
//  UIStackViewDemo
//
//  Created by Bradley Smith on 2/11/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import UIKit

@objc (ViewController)
class ViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var axisControl: UISegmentedControl!
    @IBOutlet private weak var alignmentControl: UISegmentedControl!

    private let alignments: [UILayoutConstraintAxis: [UIStackViewAlignment]] = [
        .Vertical: [.Fill, .Leading, .Center, .Trailing],
        .Horizontal: [.Fill, .Top, .FirstBaseline, .Center, .Bottom, .LastBaseline]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let borderView = UIView(frame: CGRect.zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.borderColor = UIColor.blackColor().CGColor
        borderView.layer.borderWidth = 2.0
        stackView.addSubview(borderView)

        let borderViewConstraints: [NSLayoutConstraint] = [
            borderView.topAnchor.constraintEqualToAnchor(stackView.topAnchor),
            borderView.leadingAnchor.constraintEqualToAnchor(stackView.leadingAnchor),
            borderView.trailingAnchor.constraintEqualToAnchor(stackView.trailingAnchor),
            borderView.bottomAnchor.constraintEqualToAnchor(stackView.bottomAnchor)
        ]

        NSLayoutConstraint.activateConstraints(borderViewConstraints)

        stackView.spacing = 10.0
        stackView.distribution = .Fill
        axisValueChanged(axisControl)
    }

    @IBAction private func axisValueChanged(control: UISegmentedControl) {
        let axis = UILayoutConstraintAxis(rawValue: control.selectedSegmentIndex) ?? .Horizontal
        stackView.axis = axis
        configureAlignmentControlForAxis(axis)
    }

    @IBAction private func distributionValueChanged(control: UISegmentedControl) {
        self.stackView.distribution = UIStackViewDistribution(rawValue: control.selectedSegmentIndex) ?? .Fill
    }

    @IBAction private func alignmentValueChanged(control: UISegmentedControl) {
        let axis = UILayoutConstraintAxis(rawValue: axisControl.selectedSegmentIndex) ?? .Horizontal
        stackView.alignment = alignments[axis]![control.selectedSegmentIndex]
    }

    private func configureAlignmentControlForAxis(axis: UILayoutConstraintAxis) {
        alignmentControl.removeAllSegments()

        for alignment in alignments[axis]! {
            let title = titleForAlignment(alignment, axis: axis)
            let index = alignmentControl.numberOfSegments
            alignmentControl.insertSegmentWithTitle(title, atIndex: index, animated: false)
        }

        alignmentControl.selectedSegmentIndex = 0
        alignmentValueChanged(alignmentControl)
    }

    private func titleForAlignment(alignment: UIStackViewAlignment, axis: UILayoutConstraintAxis) -> String {
        switch alignment {
        case .Fill: return "Fill"
        case .Leading: return (axis == .Vertical) ? "Leading" : "Top"
        case .FirstBaseline: return "First Baseline"
        case .Center: return "Center"
        case .Trailing: return (axis == .Vertical) ? "Trailing" : "Bottom"
        case .LastBaseline: return "Last Baseline"
        }
    }
}

