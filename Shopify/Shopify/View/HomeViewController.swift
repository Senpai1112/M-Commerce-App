//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 10/02/2025.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var homeCollection: UICollectionView!
    
    var viewModel : ViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollection.dataSource = self
        homeCollection.delegate = self
        //nibs
        let brandNib = UINib(nibName: "BrandCell", bundle: nil)
        self.homeCollection.register(brandNib, forCellWithReuseIdentifier: "BrandCell")
        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
        homeCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        ///CollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout { index, environment in
        switch index {
        case 0:
            return self.drawBrandSection()
            
       
        default: return nil
        }
    }
      
    self.homeCollection.setCollectionViewLayout(layout, animated: true)
////
        viewModel = ViewModel()
        viewModel.bindBrandsToViewController = {
            DispatchQueue.main.async {
                self.homeCollection.reloadData()
            }
        }

        viewModel.getBrandsFromModel()
    }
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch indexPath.section {
            case 0:
                header.headerLabel.text = "Brands"
            default: header.headerLabel.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func drawBrandSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(190),
            heightDimension: .absolute(272)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        // header
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]
        return section
    }



        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.finalResult.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
            let brand = viewModel.finalResult[indexPath.row]
            cell.brandTitle.text = brand.title
            if let imgURL = URL(string: brand.image?.src ?? "") {
                cell.brandImage.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
            }
            return cell
        }

       
       
    }
