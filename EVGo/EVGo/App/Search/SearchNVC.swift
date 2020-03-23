//
//  SearchNVC.swift
//  EVGo
//
//  Created by Hoof on 3/23/20.
//  Copyright © 2020 Retinal Media. All rights reserved.
//

import UIKit

internal class SearchNVC: UINavigationController {

    private(set) var context: SearchContext?


    init(context: SearchContext, rootViewController: UIViewController) {
        self.context = context
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        let msg = String(describing: type(of: self)) + " cannot be used with a nib file"
        fatalError(msg)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
