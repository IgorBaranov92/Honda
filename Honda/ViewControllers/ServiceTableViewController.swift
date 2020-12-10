import UIKit
import CoreData

class ServiceTableViewController: UITableViewController , NSFetchedResultsControllerDelegate  {

    // MARK: - ViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        calculateService()
    }
    
    // MARK: - FetchedResultsControllers
    lazy var fetchedResultsController : NSFetchedResultsController<Operation>? = {
        let request:NSFetchRequest<Operation> = NSFetchRequest(entityName: "Operation")
        request.sortDescriptors = [NSSortDescriptor(key:"mileage",ascending:false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        try? aFetchedResultsController.performFetch()
        return aFetchedResultsController
    }()
    
    lazy var mileageFetchedResultsController : NSFetchedResultsController<Mileage>? = {
        let request : NSFetchRequest<Mileage> = NSFetchRequest(entityName: "Mileage")
        request.sortDescriptors = [NSSortDescriptor(key:"mileage",ascending:false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try? aFetchedResultsController.performFetch()
        return aFetchedResultsController
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
        default:break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections![0].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "service",for:indexPath)
        if let myCell = cell as? ServiceTableViewCell {
            if let object = fetchedResultsController?.object(at: indexPath) {
                myCell.operationLabel.text = object.type
                myCell.mileageLabel.text = String(object.mileage)
                myCell.infoLabeL.text = String(object.price) + " " + object.info!
            }
        }
        return cell
    }
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {[weak self]  (action,indexPath)  in
            let alert = UIAlertController(title: "Подтверждение", message: "Вы действительно хотите удалить данный узел?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Да", style: .default){(action) in
                if let object = self?.fetchedResultsController?.object(at: indexPath) {
                    AppDelegate.viewContext.delete(object)
                    try? AppDelegate.viewContext.save()
                    tableView.reloadData()
                    self?.calculateService()
                }
            }
            let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self?.present(alert, animated: true)
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    private func calculateService() {
        UserDefaults.standard.set(nil, forKey: "Operations")
        var operations = [String]()
        var alreadyChecked = [String]()
        if fetchedResultsController?.sections![0].numberOfObjects != 0 {
            if let count = fetchedResultsController?.sections![0].numberOfObjects {
                for index in 0..<count {
                    if let type = fetchedResultsController?.object(at: IndexPath(row: index, section: 0)).type, let mileage = fetchedResultsController?.object(at: IndexPath(row: index, section: 0)).mileage {
                        if !operations.contains(type) {
                            if let interval = ServiceList.intervals[type], let lastMileage = mileageFetchedResultsController?.object(at: IndexPath(row: 0, section: 0)).mileage {
                                    if (Int(lastMileage) >= Int(mileage) + interval) && !alreadyChecked.contains(type) {
                                        operations.append(type)
                                    } else {
                                       alreadyChecked.append(type)
                                }
                            }
                        }
                    }
                }
            }
        }
        if operations.count >= 1 {
            UserDefaults.standard.set(operations, forKey: "Operations")
            tabBarController?.tabBar.items?[1].badgeValue = "\(operations.count)"
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = nil
        }
    }
}
