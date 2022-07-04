//
//  MainVC.swift
//  Fairytale Spin
//
//  Created by Nick M on 18.06.2022.
//

import UIKit



class MainVC: UIViewController {
    
    // MARK: - IBOUTLET PROPERTIES
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var allGamesView: UIView!
    @IBOutlet weak var backgroundGamesView: UIView!
    @IBOutlet weak var backgroundCountView: UIView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var regularCollectionView: UICollectionView!
    @IBOutlet weak var stackViewOfCollectionView: UIStackView!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var allGamesButton: UIButton!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    // MARK: - CUSTOM PROPERTIES
    var popularList = Array<PopularItems>()
    var regularList = Array<RegularItems>()
    var conditionButtons: ConditionButtons = .popular
    var selectedPack:SelectedPack = .pack_1
    let underLine = UIView()
    
    // MARK: - VC LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        configLG()
        configUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configUnderline()
    }
    
    // MARK: - ACTION BUTTONS
    @IBAction func pressedPopularButton(_ sender: UIButton) {
        conditionButtons = .popular
        sender.setTitleColor(.white, for: .normal)
        allGamesButton.titleLabel?.textColor = .inactiveButtonColor
        animateUnderLine(sender)
    }
    
    @IBAction func pressedAllGamesButton(_ sender: UIButton) {
        conditionButtons = .allGames
        sender.setTitleColor(.white, for: .normal)
        popularButton.titleLabel?.textColor = .inactiveButtonColor
        animateUnderLine(sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toGameTable{
            let gameVC = segue.destination as! GameTableVC
            gameVC.selectedPack = selectedPack
        }
    }
    
    // MARK: - CONFIG METHODS
    fileprivate func configUI() {
        popularCollectionView.backgroundColor = .clear
        regularCollectionView.backgroundColor = .clear
        regularCollectionView.alpha = .zero
        backgroundGamesView.roundCorners(40, true, [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        backgroundGamesView.addSubview(underLine)
        backgroundCountView.layer.cornerRadius = 3
        allGamesButton.setTitleColor(.inactiveButtonColor, for: .normal)
        let savedPoints = UserDefaults.standard.integer(forKey: K.totalPoints)
        totalPointsLabel.text = savedPoints.addSeparator(" ")
    }
    
    fileprivate func configUnderline() {
        underLine.frame.size = CGSize(width: popularButton.frame.width * 0.5, height: 4)
        underLine.frame.origin = CGPoint(x: (popularButton.frame.maxX - (popularButton.frame.width / 2)) - underLine.frame.width / 2, y: popularButton.frame.maxY)
        underLine.backgroundColor = .underLineColor
    }
    
    fileprivate func configLG() {
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        regularCollectionView.delegate = self
        regularCollectionView.dataSource = self
        popularList = SetData.setPopularList
        regularList = SetData.setRegularItemsList
    }
    
    // MARK: - ANIMATIONS METHODS
    fileprivate func animateUnderLine(_ sender:UIView){
        UIView.animate(withDuration: 1) {
            self.underLine.frame.size = CGSize(width: sender.frame.width * 0.6, height: 4)
            if self.conditionButtons == .popular{
                self.underLine.frame.origin = CGPoint(x: (sender.frame.maxX - (sender.frame.width / 2)) - self.underLine.frame.width / 2, y: sender.frame.maxY)
                self.regularCollectionView.alpha = .zero
            }else{
                self.underLine.frame.origin = CGPoint(
                    x: self.backgroundGamesView.frame.midX + sender.frame.midX - self.underLine.frame.width / 2,
                    y: sender.frame.maxY)
                self.regularCollectionView.alpha = 1
            }
        }
        
    }
}
