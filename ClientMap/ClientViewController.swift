//
//  ViewController.swift
//  ClientMap
//
//  Created by yo hishuu on 2018/07/31.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var itemTable: UITableView?
    var ClientList = Array<ClientModel>()
    var countArray: Array<Int> = [4,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "訪問顧客"

        installUI()
        installNavigationItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClientList = ClientManager.find()
        itemTable?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func installUI() {
        itemTable = UITableView()
        self.view.addSubview(itemTable!)
        itemTable?.delegate = self
        itemTable?.dataSource = self
        //itemCell?.separatorStyle = UITableViewCellSeparatorStyle.none
        itemTable?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(0)
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.bottom.equalTo(0)
        })
        
        //定義したcellを登録
        itemTable!.register(UINib.init(nibName: "ClientTableViewCell", bundle: nil), forCellReuseIdentifier: "ClientCellId")
    }
    
    func installNavigationItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toClientList))
        let newButtonItem = UIBarButtonItem(title: "新規", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.NewClient))
        self.navigationItem.rightBarButtonItems = [addButtonItem,newButtonItem]
    }
    
    @objc func NewClient() {
        let model = ClientModel()
        let editView = ClientEditViewController()
        editView.Detail = model
        self.navigationController!.pushViewController(editView, animated: true)
    }
    
    @objc func toClientList(){
        let contactList = ContactListViewController()
        self.navigationController!.pushViewController(contactList, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientList.count
    }
    
    //行高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //设置列表的分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //行表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ClientTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ClientCellId", for: indexPath) as! ClientTableViewCell

        let model = ClientList[indexPath.row]
        cell.ClientName.text = model.clientName!
        cell.TelNo.text = model.telNo!
        cell.Address.text = model.address!
        if model.visited! == "1" {
            cell.isVisited.text = "済"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = ClientList[indexPath.row]
        let editView = ClientEditViewController()
        editView.Detail = model
        self.navigationController!.pushViewController(editView, animated: true)
    }
}

