//
//  SplashScreen.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//


import UIKit

class SplashViewController : BaseViewController {
    
    
    // MARK: - Properties
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
            
        
            guard let viewController = Storyboard.main.viewController else { return }
        self.navigationController?.show(viewController, sender: nil)

        }
    }
       
    // MARK: - Setup
    
    
    // MARK: - Actions
    
    
    //MARK: - Methods
    
}
