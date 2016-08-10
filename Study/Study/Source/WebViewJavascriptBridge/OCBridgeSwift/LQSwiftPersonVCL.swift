//
//  LQSwiftPersonVCL.swift
//  Study
//
//  Created by 李强 on 16/7/26.
//  Copyright © 2016年 李强. All rights reserved.
//

import UIKit

class LQSwiftPersonVCL: LQBaseVCL,UITableViewDelegate,UITableViewDataSource {

    let screen_height = UIScreen.mainScreen().bounds.size.height
    let screen_width = UIScreen.mainScreen().bounds.size.width
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
            personArray?.addObject("Person\(index)")
        }
    }
    
    func createTableView() {
        
        tableView = UITableView(frame: CGRectMake(0, 64,screen_width ,screen_height), style: UITableViewStyle.Grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (personArray?.count)!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = personArray![indexPath.row] as? String
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
