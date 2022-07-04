//
//  GameTableVC.swift
//  Fairytale Spin
//
//  Created by Nick M on 18.06.2022.
//

import UIKit

class GameTableVC: UIViewController {
    
    // MARK: - IBOUTLET PROPERTIES
    @IBOutlet weak var winPointsLabel: UILabel!
    @IBOutlet weak var addPointsLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var spinArrowsImageView: UIImageView!
    @IBOutlet weak var totalPointsView: UIView!
    @IBOutlet weak var gameTableView: UIView!
    
    @IBOutlet var spinSlot_1: [UIImageView]!
    @IBOutlet var spinSlot_2: [UIImageView]!
    @IBOutlet var spinSlot_3: [UIImageView]!

    var columnsSlot = [[UIImageView]]()
    
    // MARK: - CUSTOM PROPERTIES
    let delegate = UIApplication.shared.delegate as? AppDelegate
    var selectedPack:SelectedPack = .pack_1
    var itemsWon: ItemsWon?
    var spinWon = 0
    var totalPoints = 0
    var setBet = 50
    var betCondition = 1

    // MARK: - VC LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        spin()
        

    }

    // MARK: - ACTION BUTTONS
    @IBAction func pressedBackButton(_ sender: UIButton) {
        self.delegate?.orientation = .portrait
        dismiss(animated: true)
    }
    
    @IBAction func pressedSpinButton(_ sender: UIButton) {
        spinWon = 0
        winPointsLabel.text = "\(spinWon)"
        if let gradeFromLabel = Int(addPointsLabel.text ?? "0"){
            if gradeFromLabel < totalPoints{
                totalPoints -= gradeFromLabel
                spinArrowsImageView.rotate(duration: 0.5)
                spin()
            }else{
                alertWithBuyButton(title: "Not enough points", message: nil)
            }
        }
    }
    
    @IBAction func pressedMinusButton(_ sender: UIButton) {
        if setBet > 50{
            setBet -= 50
            betCondition -= 1
            addPointsLabel.text = "\(setBet)"
            UserDefaults.standard.set(betCondition, forKey: K.betCondition)
        }
    }
    
    @IBAction func pressedPlusButton(_ sender: UIButton) {
        setBet += 50
        betCondition += 1
        addPointsLabel.text = "\(setBet)"
        UserDefaults.standard.set(betCondition, forKey: K.betCondition)
    }
    
    // MARK: - UI METHODS
    fileprivate func configUI(){
        self.delegate?.orientation = .landscape
        addPointsLabel.layer.borderColor = UIColor.underLineColor?.cgColor
        addPointsLabel.layer.borderWidth = 1
        minusButton.setTitle("", for: .normal)
        plusButton.setTitle("", for: .normal)
        spinButton.setTitle("SPIN", for: .normal)
        spinButton.titleLabel?.font = UIFont(name: "roboto", size: 38)
        spinButton.titleLabel?.adjustsFontSizeToFitWidth = true
        backButton.setTitle("", for: .normal)
        totalPointsView.setGradientLeftToRigth(UIColor.totalPointsStartColor, UIColor.totalPointsEndColor, to: totalPointsView)
        winPointsLabel.text = "0"
        totalPoints = UserDefaults.standard.integer(forKey: K.totalPoints)
        totalPointsLabel.text = totalPoints.addSeparator(" ")
        betCondition = UserDefaults.standard.integer(forKey: K.betCondition)
        setBet *= betCondition
        addPointsLabel.text = "\(setBet)"
        columnsSlot = [spinSlot_1,spinSlot_2,spinSlot_3]
    }
    
    func alertWithBuyButton(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buyButton = UIAlertAction(title: "Buy", style: .default) { (alertAction) in
            print("Go to purchasing screen...")
        }
        alertController.addAction(buyButton)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func spin() {
        
        var recivedNameList = [[String]]()
        SetData.getImageNamesOfSelectedPack(selectedPack) { element in
            for (ci,columns) in columnsSlot.enumerated() {
                recivedNameList.append([])
                for item in columns {
                    let randomName = element.randomElement() ?? ""
                    recivedNameList[ci].append(randomName)
                    let randomImage = UIImage(named: randomName)
                    item.image = randomImage
                    item.alpha = 0
                    item.layer.borderWidth = 0
                    UIView.animate(withDuration: 0.6) {
                        item.alpha = 1.0
                    }
                }
            }
        }
        incomeControl(recivedNameList)
    }
    
    fileprivate func incomeControl(_ recivedNameList: [[String]]) {
        for (ci,columns) in recivedNameList.enumerated(){
            for _ in columns {
                let items = recivedNameList[ci]
                if items[0] == items[1] && items[1] == items[2] && items[2] == items[3] && items[3] == items[4]{
                    itemsWon = .five
                    wonCalculator()
                    updateImageIfWon(ci, [0,1,2,3,4])
                    break
                }else if items[0] == items[1] && items[1] == items[2] && items[2] == items[3]{
                    itemsWon = .four
                    wonCalculator()
                    updateImageIfWon(ci, [0,1,2,3])
                    break
                }else if items[0] == items[1] && items[1] == items[2]{
                    itemsWon = .three
                    wonCalculator()
                    updateImageIfWon(ci, [0,1,2])
                    break
                }else if items[0] == items[1]{
                    itemsWon = .two
                    wonCalculator()
                    updateImageIfWon(ci, [0,1])
                    break
                }else{
                    itemsWon = nil
                    wonCalculator()
                    break
                }
            }
        }
    }
    
    fileprivate func updateImageIfWon(_ ci:Int, _ indexes: [Int] ){
            for item in indexes {
                UIView.animate(withDuration: 0.5) {
                    self.columnsSlot[ci][item].layer.cornerRadius = 16
                    self.columnsSlot[ci][item].layer.borderColor = UIColor.systemGreen.cgColor
                    self.columnsSlot[ci][item].layer.borderWidth = 2
                } completion: { _ in
                    self.columnsSlot[ci][item].layer.borderWidth = 0
                    UIView.animate(withDuration: 0.5) {
                        self.columnsSlot[ci][item].layer.borderWidth = 2
                    } completion: { _ in
                        self.columnsSlot[ci][item].layer.borderWidth = 0
                    }
                }
            }
    }
    
    fileprivate func wonCalculator() {
        if itemsWon == .two{
            spinWon += ItemsWon.two.rawValue * betCondition
        }else if itemsWon == .three{
            spinWon += ItemsWon.three.rawValue * betCondition
        }else if itemsWon == .four{
            spinWon += ItemsWon.four.rawValue * betCondition
        }else if itemsWon == .five{
            spinWon += ItemsWon.five.rawValue * betCondition
        }
        totalPoints += spinWon
        winPointsLabel.text = spinWon.addSeparator(" ")
        totalPointsLabel.text = totalPoints.addSeparator(" ")
        UserDefaults.standard.set(totalPoints, forKey: K.totalPoints)
    }
    
}
