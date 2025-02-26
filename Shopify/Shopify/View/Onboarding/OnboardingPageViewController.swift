//
//  OnboardingPage1ViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 25/02/2025.
//

import UIKit
import Lottie

class OnboardingPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let onboardingData: [(animation: String, title: String, description: String)] = [
        ("Animation", "Welcome!", "Discover the best shopping experience."),
        ("Animation3", "Exclusive Deals", "Get the best offers and discounts."),
        ("Animation2", "Easy Checkout", "A seamless and fast checkout process.")
    ]
    
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            nextButton.setTitle(currentPage == onboardingData.count - 1 ? "Start" : "Next", for: .normal)
            
            skipButton.isHidden = currentPage == onboardingData.count - 1
            
            if currentPage == onboardingData.count - 1 {
                nextButton.center.x = view.center.x
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        pageControl.numberOfPages = onboardingData.count
        currentPage = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let data = onboardingData[indexPath.item]
        cell.setup(animationName: data.animation, title: data.title, description: data.description)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentPage < onboardingData.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.reloadData()
        } else {
            completeOnboarding()
        }
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        completeOnboarding()
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")

        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeTabBar") as! UITabBarController
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navigationController
        }
    }

}
