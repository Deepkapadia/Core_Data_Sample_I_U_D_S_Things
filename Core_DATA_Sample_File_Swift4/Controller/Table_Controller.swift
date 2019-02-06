//
//  Table_Controller.swift
//  Core_DATA_Sample_File_Swift4
//
//  Created by DeEp KapaDia on 29/01/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import CoreData

class Table_Controller: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate{


    @IBOutlet weak var searchBar: UISearchBar!
    
    //Arrat with variable for Tableview
    var EmpArr:[Emp] = []
    
    
    
    //All Delegate Function for Context Code
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.tableFooterView = UIView()
        
        
        self.FetchData()
        self.tableview.reloadData()
        
        // Do any additional setup after loading the view.
        
    }
    //TableView Reaload and Fetch Data
    override func viewWillAppear(_ animated: Bool) {
        
        self.FetchData()
        self.tableview.reloadData()
        
    }

    
    //Searchbar Data Fetch
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != ""{
            var predicate:NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "emp_name contains[c] '\(searchText)'")

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Emp")
                    fetchReq.predicate = predicate

            do{
                
                EmpArr = try context.fetch(fetchReq) as! [Emp]
                
            }catch{
                
                print(" Could not search datas ")
                
            }
            
            
        }else{
            
            FetchData()
            
        }
        tableview.reloadData()
        
    }
    
    //number of tableview rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //number of section in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return EmpArr.count
    
    }
    
    //Cell Code for Display data on Cell from cell file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurtomCell
        
        let oneRecord = EmpArr[indexPath.row]
        
        cell.ID_lbl.text = oneRecord.emp_id
        cell.name_LBL.text = oneRecord.emp_name
        cell.add_LBL.text = oneRecord.emp_add
        //cell.ImageVC_Cell.image = oneRecord.emp_image as? UIImage

        
        
        return cell
        
    }
    
    
    
    //Display Data on DidLoad & ViewWill Apear
    func FetchData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{

            EmpArr = try context.fetch(Emp.fetchRequest())
            
        }catch{
            
            print(error)
            
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
    
    //Tableview Row Editing things
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    //Delete Rows from Core data Sample to remove Data from Database & Cell 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            
            let empData = EmpArr[indexPath.row]
            context.delete(empData)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                
                EmpArr = try context.fetch(Emp.fetchRequest())
                
            }catch{
                
                print(error)
                
            }
        }
        tableView.reloadData()
    }

}
