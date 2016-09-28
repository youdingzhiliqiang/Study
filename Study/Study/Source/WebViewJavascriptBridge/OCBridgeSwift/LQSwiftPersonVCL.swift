//
//  LQSwiftPersonVCL.swift
//  Study
//
//  Created by 李强 on 16/7/26.
//  Copyright © 2016年 李强. All rights reserved.
//

import UIKit

class LQSwiftPersonVCL: LQBaseVCL,UITableViewDelegate,UITableViewDataSource {

    let screen_height = UIScreen.main.bounds.size.height
    let screen_width = UIScreen.main.bounds.size.width
    var personArray:NSMutableArray?
    
    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        setPersonArray()
        createTableView()
        self.title = "这是一个swift页面"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPersonArray() {
        personArray = NSMutableArray()
        for index in 0...10 {
            personArray?.add("Person\(index)")
        }
    }
    
    func createTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64,width: screen_width ,height: screen_height), style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (personArray?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = personArray![(indexPath as NSIndexPath).row] as? String
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var personDetail:LQPersonDetailVCL = LQPersonDetailVCL()
//        
//        personArray![indexPath.row] as? String
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
