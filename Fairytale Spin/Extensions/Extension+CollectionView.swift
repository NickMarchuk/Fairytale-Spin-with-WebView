//
//  Extension+CollectionView.swift
//  Fairytale Spin
//
//  Created by Nick M on 20.06.2022.
//

import UIKit

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView{
            return popularList.count
        }
        return regularList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularCollectionView{
            let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.popularCell, for: indexPath) as! PopularCell
            let popularItem = popularList[indexPath.row]
            popularCell.backgroundImage.image = UIImage(named: popularItem.backgroundImage)
            popularCell.character.image = UIImage(named: popularItem.character)
            popularCell.element.image =  UIImage(named: popularItem.element)
            return popularCell
        }
        
        let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.regularCell, for: indexPath) as! RegularCell
        let regularItem = regularList[indexPath.row]
        regularCell.backgroundImage.image = UIImage(named: regularItem.backgroundImageName)
        regularCell.element.image = UIImage(named: regularItem.elementName)
        return regularCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == popularCollectionView{
            selectedPack = .pack_1
        }else if collectionView == regularCollectionView{
            if indexPath.row == 0{
                selectedPack = .pack_3
            }else if indexPath.row == 1{
                selectedPack = .pack_2
            }else if indexPath.row == 2{
                selectedPack = .pack_1
            }
        }
        performSegue(withIdentifier: K.toGameTable, sender: self)
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == regularCollectionView{
            return CGSize(width: (stackViewOfCollectionView.frame.width / 2) - 5, height: regularCollectionView.frame.height)
        }else{
            return CGSize(width: stackViewOfCollectionView.frame.width, height: regularCollectionView.frame.height)
        }
    }
}
