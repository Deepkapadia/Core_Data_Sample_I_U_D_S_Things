//
//  ViewController.swift
//  Core_DATA_Sample_File_Swift4
//
//  Created by DeEp KapaDia on 29/01/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    
    //Outlet connections
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var add: UITextField!
    
    @IBOutlet weak var imageVC: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    //Core data delegete methods
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //Indet Data in to data base code
    @IBAction func InsertData(_ sender: Any) {
        
        let InsertNewData = NSEntityDescription.insertNewObject(forEntityName: "Emp", into: Context) as NSManagedObject
        
        InsertNewData.setValue(id.text, forKey: "emp_id")
        InsertNewData.setValue(name.text, forKey: "emp_name")
        InsertNewData.setValue(add.text, forKey: "emp_add")

        //let imageData = UIImagePNGRepresentation(imageVC.image!)
        
        //InsertNewData.setValue(imageData, forKey: "emp_image")
        
        
        
        do{
            
            try Context.save()
            
        }catch{
            
            print(error)
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //Select Data with ID code from Database
    @IBAction func SelectData(_ sender: Any) {
        
        let entitydis = NSEntityDescription.entity(forEntityName: "Emp", in: Context)
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Emp")
        request.entity = entitydis;
        
        let pred = NSPredicate(format: "(emp_id= %@)", id.text!)
        
        //  var err = NSError();
        
        request.predicate = pred
        
        do{
            let results = try Context.fetch(request)
            
            print(results);
            
            if results.count>0
            {
                
                let match =  results[0] as! NSManagedObject;
                
                print(match.value(forKey: "emp_name") as Any)
                print(match.value(forKey: "emp_id") as Any)
                print(match.value(forKey: "emp_add") as Any)
                
                id.text = match.value(forKey: "emp_id") as? String
                name.text = match.value(forKey: "emp_name") as? String
                add.text  = match.value(forKey: "emp_add") as? String
                //imageVC.image = match.value(forKey: "emp_image") as? UIImage
            }
            else
            {
                
                let aller = UIAlertController.init(title: "Unavailable Data", message: "No Data Available with this ID", preferredStyle: .alert)
                
                print("not fount")
                
                let Ok = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                
                aller.addAction(Ok)
                present(aller, animated: true, completion: nil)
                
            }
            // let  groceries = results as![NSManagedObject]
            // print(groceries);
            /// tableView.reloadData()
            
        }catch{
            
            fatalError("Error is retriving Gorcery items")
            
        }
        
        
        
    }
    
    
    
    //Delete Data from Database
    @IBAction func DeleteBTN(_ sender: Any) {
        
            let entitydis = NSEntityDescription.entity(forEntityName: "Emp", in: Context);
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Emp")
            request.entity = entitydis
            
            let pred = NSPredicate(format: "(emp_id= %@)", id.text!)
            
            //  var err = NSError()
            
            request.predicate = pred
            
            do{
                let results = try Context.fetch(request)
                
                print(results)
                
                if results.count>0
                {
                    let match =  results[0] as! NSManagedObject
                    
                    Context.delete(match)
                    
                    try Context.save()
                }
                else
                {
                    print("not fount")
                }
                
                // let  groceries = results as![NSManagedObject]
                // print(groceries)
                /// tableView.reloadData()
                
            }catch{
                fatalError("Error is retriving Gorcery items")
            }
        
        self.navigationController?.popViewController(animated: true)
        
        }
    
    //Update Datas with ID selection from Database
    @IBAction func UpdateBTN(_ sender: Any) {
        
        let entitydis = NSEntityDescription.entity(forEntityName: "Emp", in: Context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Emp")
        request.entity = entitydis
        
        let pred = NSPredicate(format: "(emp_id= %@)", id.text!)
        
        //  var err = NSError()
        
        request.predicate = pred
        
        do{
            let results = try Context.fetch(request)
            
            print(results)
            
            if results.count>0
            {
                
                let match =  results[0] as! NSManagedObject;
                match.setValue(id.text, forKey: "emp_id")
                match.setValue(name.text, forKey: "emp_name")
                match.setValue(add.text, forKey: "emp_add")
                //match.setValue(imageVC.image, forKey: "emp_image")
                
                try Context.save()
            }
            else
            {
                print("not fount")
            }
            // let  groceries = results as![NSManagedObject]
            // print(groceries);
            /// tableView.reloadData()
            
        }catch{
            
            fatalError("Error is retriving Gorcery items")
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func UploadIMAGE(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //let InsertNewData = NSEntityDescription.insertNewObject(forEntityName: "Emp", into: Context) as NSManagedObject

        
        let TempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageVC.image = TempImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

