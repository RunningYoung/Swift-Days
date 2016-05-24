//
//  ViewController.swift
//  Project7-days7
//
//  Created by xcl on 16/3/25.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.addNewPerson))
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return people.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PersonCell
        let  person = people[indexPath.item]
        
        cell.name.text = person.name
        let  path = getDocunmentsDirectory().stringByAppendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path)
        cell.imageView.layer.borderColor = UIColor(red: 0,green: 0, blue: 0, alpha: 0.3).CGColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        ac.addAction(UIAlertAction(title: "Cancel",style: .Cancel, handler: nil))
            
            ac.addAction(UIAlertAction(title: "OK",style: .Default){[unowned self, ac] _ in
                let newName = ac.textFields![0]
                person.name = newName.text!
                self.collectionView.reloadData()
        })
        presentViewController(ac, animated: true, completion: nil)
        
        
    }
    func addNewPerson(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        print("=============" , info)
        var newImage: UIImage
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            newImage = possibleImage
        } else {
            return
        }
        let imageName = NSUUID().UUIDString
        let imagePath = getDocunmentsDirectory().stringByAppendingPathComponent(imageName)
        if  let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            jpegData.writeToFile(imagePath, atomically: true)
        }
        let person = Person(name: "Unknow",image: imageName)
        people.append(person)
        collectionView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func getDocunmentsDirectory() -> NSString {
        let  paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let document = paths[0]
        return document
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

