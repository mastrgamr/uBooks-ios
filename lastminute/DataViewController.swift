//
//  DataViewController.swift
//  lastminute
//
//  Created by stuart on 3/1/16.
//  Copyright © 2016 lastminute. All rights reserved.
//

import UIKit
import Former

final class DataViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Label Cell"
            }.onSelected { row in
                // Do Something
        }
        let inlinePickerRow = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = "Inline Picker Cell"
            }.configure { row in
                row.pickerItems = (1...5).map {
                    InlinePickerItem(title: "Option\($0)", value: Int($0))
                }
            }.onValueChanged { item in
                // Do Something
        }
        let header = LabelViewFormer<FormLabelHeaderView>() { view in
            view.titleLabel.text = "Label Header"
        }
        let section = SectionFormer(rowFormer: labelRow, inlinePickerRow)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
    }
}
