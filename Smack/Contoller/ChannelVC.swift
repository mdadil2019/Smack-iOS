//
//  ChannelVC.swift
//  Smack
//
//  Created by mugish on 26/09/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var loginProfileView: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataChanged), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        if(AuthService.instance.isLoggedIn){
            MessageService.instance.findAllChannel { (success) in
                debugPrint(MessageService.instance.channels.count)
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true,completion: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile,animated: true,completion: nil)
            
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
        
    }
    
    //this method will be called everytime when there will be boradcast of NOTIF_USER_REGISTRATION_DONE
    @objc func userDataChanged(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            loginProfileView.image = UIImage(named: UserDataService.instance.avatarName)
            loginProfileView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            loginProfileView.image = UIImage(named: "menuProfileIcon")
            loginProfileView.backgroundColor = UIColor.clear
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell",for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.ConfigureCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
        
        
    }
}
