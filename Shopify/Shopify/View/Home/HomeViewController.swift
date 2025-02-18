//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 10/02/2025.
//

import UIKit
import Kingfisher
import MyApi


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var homeCollection: UICollectionView!
    
    var viewModel: BrandsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollection.dataSource = self
        homeCollection.delegate = self
        initNib()
        compositionalLayout()
        viewModel = BrandsViewModel()
        viewModel.bindBrandsToViewController = {
            DispatchQueue.main.async {
                self.homeCollection.reloadData()
            }}
            viewModel.getBrandsFromModel()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Home"
        

    

    }
    func compositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { index, environment in

            switch index {
            case 0:
                return self.drawAdsSection()
            case 1:
                return self.drawBrandSection()
                
           
            default: return nil
            }
        }
        self.homeCollection.setCollectionViewLayout(layout, animated: true)
    }
    func initNib() {
        let brandNib = UINib(nibName: "BrandCell", bundle: nil)
        homeCollection.register(brandNib, forCellWithReuseIdentifier: "BrandCell")
        
        let AdNib = UINib(nibName: "AdsCell", bundle: nil)
        homeCollection.register(AdNib, forCellWithReuseIdentifier: "AdsCell")
        
        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
        homeCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
    }
    


    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch indexPath.section {
            case 0:
                header.headerLabel.text = "Discounts"
            case 1:
                header.headerLabel.text = "Brands"
            default: header.headerLabel.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
       return 2
   }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 5
        case 1:
            return viewModel.filteredCollections.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.section) {
        case 0:

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCell
            cell.AdImage.image = UIImage(named: "Ad")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
            let brand = viewModel.filteredCollections[indexPath.row]

cell.brandTitle.text = brand.title
    if let imageURL = brand.image, let url = URL(string: imageURL) {
                cell.brandImage.kf.setImage(with: url, placeholder: UIImage(named: "1"))
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 1:
            let storyBord = UIStoryboard(name: "Set-1", bundle: nil)
            let productVC = storyBord.instantiateViewController(withIdentifier: "ProductVC") as! ProductsViewController
            productVC.products = viewModel.filteredCollections[indexPath.row].products
            navigationController?.pushViewController(productVC, animated: true)
        default:
            return
        }
    }
    
   
////drawing
func drawAdsSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(0.8),heightDimension: .absolute(170))
        
            let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,  subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            ////
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                   let containerWidth = environment.container.contentSize.width

                   items.forEach { item in
                       let distanceFromCenter = abs(item.frame.midX - offset.x - containerWidth / 2)
            
                       let minScale: CGFloat = 0.8
                       let maxScale: CGFloat = 1.0
            
            let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                       
                       item.transform = CGAffineTransform(scaleX: scale, y: scale)
                   }
               }
    //header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
         return section
        }

        func drawBrandSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(135)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 2
            )
            
            group.interItemSpacing = .fixed(10)
               
               let section = NSCollectionLayoutSection(group: group)
               
               section.interGroupSpacing = 10
               
               section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            

            return section
        }
        
      
}
