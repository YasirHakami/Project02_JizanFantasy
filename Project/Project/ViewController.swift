//
//  ViewController.swift
//  Project
//
//  Created by Yasir Hakami on 02/11/2021.
//

import UIKit


// global Class for our Heros / Boss
class Hero {
    var name:String
    var lifePoint:Int
    var defense:Int
    var poewrDamage:Int
    var weaponDamage:Int
    var specialCapacity:Int
    init(name:String, lifePoint:Int, defense: Int, poewrDamage:Int,weaponDamage:Int, specialCapacity:Int ) {
        self.name = name
        self.lifePoint = lifePoint
        self.defense = defense
        self.poewrDamage = poewrDamage
        self.weaponDamage = weaponDamage
        self.specialCapacity = specialCapacity
    }
    func ActionDescration(){ // declear for the round
        print("The \(name) take the action :and he is defense: \(defense) & life point \(lifePoint) !")
    }
    func SC(){ // call for Special Capacity
        print("The \(name) get \(specialCapacity) ")
    }
}


class ViewController: UIViewController {
    @IBOutlet weak var duringGame: UITextView!
    @IBOutlet weak var diceNumber: UILabel!
    @IBOutlet weak var lpBoss: UILabel!
    @IBOutlet weak var lpdfBoss: UILabel!
    @IBOutlet weak var lpPdBoss: UILabel!
    @IBOutlet weak var lpWdBoss: UILabel!
    @IBOutlet weak var lpScBoss: UILabel!
    
    
    @IBOutlet weak var lpHero: UILabel!
    @IBOutlet weak var lpDf: UILabel!
    @IBOutlet weak var lpPd: UILabel!
    @IBOutlet weak var lpWd: UILabel!
    @IBOutlet weak var sc: UILabel!
    @IBOutlet weak var heroName: UILabel!
    
    var player1 :Hero? // include ( Boss1 ,Boss2)
    
    // Our Chracters
    var player2 = Hero(name: "HERO", lifePoint: 0, defense: 0, poewrDamage: 0, weaponDamage: 0, specialCapacity: 0)
    var boss1 = Hero(name: "Boss1", lifePoint: 250, defense: 30, poewrDamage: 20, weaponDamage: 45, specialCapacity: 110)
    var boss2 = Hero(name: "Boss2", lifePoint: 170, defense: 25, poewrDamage: 15, weaponDamage: 30, specialCapacity: 75)
    
    var turn = 0 // Round Counter
    var winner = false
    
    @IBOutlet weak var uiRoll: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // random for Boss
        let player = Int.random(in: 0...1)
        
        if player == 0 {
            player1 = boss1
        } else {
            player1 = boss2
        }
    }
    
    @IBAction func roll(_ sender: Any) {
        turn += 1
        if winner {
            duringGame.text += ("Game End !")
        } else {
            duringGame.text += ("“This is the turn N°\(turn)“")
            logicTheGame()
            duringGame.text += ("“This is the end of turn N°\(turn)“")
        }
        let range = NSMakeRange(duringGame.text.count - 1, 0)
            duringGame.scrollRangeToVisible(range)
    }
    
    
    // Roll Dice i make it inside spreat funcation
    func roll() -> Int {
        var dice : Int
        dice = Int.random(in: 0...20)
        diceNumber.text = "Rolling .. \(dice)"
        return dice
        
    }
    
    // the Scenario
    func logicTheGame(){
        
        player2.lifePoint = Int(lpHero.text!)!
        player2.weaponDamage = Int(lpWd.text!)!
        player2.poewrDamage = Int(lpPd.text!)!
        player2.defense = Int(lpDf.text!)!
        
        
        
        switch roll() {
        case 0...4: // Hero
            player2.ActionDescration()
            player1?.lifePoint -= player2.poewrDamage
            player1?.lifePoint += player1?.defense ?? 0
            duringGame.text += ("the lifepoint of Hero : \(player2.lifePoint)")
            Dead()
            
        case 5...9: // Boss
            player1?.ActionDescration()
            player2.lifePoint -= player1?.poewrDamage ?? 0
            player2.lifePoint += player2.defense
            duringGame.text += ("the lifepoint of \( player1?.name ?? "Boss") : \(player1!.lifePoint)")
            Dead()
           
        case 10...14:
            player2.ActionDescration()
            player1?.lifePoint -= player2.weaponDamage
            player1?.lifePoint += player1?.defense ?? 0
            duringGame.text += ("the lifepoint of Hero : \(player2.lifePoint )")
            Dead()
            
        case 15...19:
            boss2.ActionDescration()
            player2.lifePoint -= player1?.weaponDamage ?? 0
            player2.lifePoint += player2.defense
            duringGame.text += ("the lifepoint of \(player1?.name ?? "Boss") : \(player1?.lifePoint ??  0) ")
            Dead()
            
        case 20:
            player2.SC()
            if sc.text == "+ 5 LP & + 10 WD" {
                player2.weaponDamage += 10
                player2.lifePoint += 5
            } else if sc.text == "+ 35 LP  & + 10 PD" {
                player2.poewrDamage += 10
                player2.lifePoint += 35
            } else {
                player2.weaponDamage += 35
                player2.lifePoint += 5
            }
            
            duringGame.text += ("the lifepoint of Hero : \(player2.lifePoint)")
            Dead()
            player1?.SC()
            boss2.lifePoint += 5
            boss2.poewrDamage += 35
            boss1.lifePoint += 5
            boss1.poewrDamage += 22
            duringGame.text += ("the lifepoint of \(player1?.name ?? "Boss") : \(player1?.lifePoint ??  0)")
            Dead()
            print ("get \(player1?.lifePoint ??  170) , \(player1?.lifePoint ??  170)")
            
        default:
            print("Error")
        }
        if player2.lifePoint <= 0 {
            uiRoll.isEnabled = false
        } else if player1!.lifePoint <= 0 {
            uiRoll.isEnabled = false
        }
        
        // Boss Player1
        lpBoss.text = "\(player1?.lifePoint ?? 170)"
        lpdfBoss.text = "\(player1?.defense ?? 25)"
        lpPdBoss.text = "\(player1?.poewrDamage ?? 15)"
        lpWdBoss.text = "\(player1?.weaponDamage ?? 30)"
        lpScBoss.text = "\(player1?.specialCapacity ?? 35) S.C For Boss"
        
        
        // Hero Player2
        lpHero.text = "\(player2.lifePoint)"
        lpDf.text = "\(player2.defense)"
        lpPd.text = "\(player2.poewrDamage)"
        lpWd.text = "\(player2.weaponDamage)"
        
    }
    
    
    // To Find The Winner if Other Player = 0
    func Dead(){
        if player2.lifePoint < 0{
            player2.lifePoint = 0
        } else if player1!.lifePoint < 0 {
            player1!.lifePoint = 0
        }
    }
    
    
    @IBAction func unwindToRoot(segue: UIStoryboardSegue){
    }
}//end the class


