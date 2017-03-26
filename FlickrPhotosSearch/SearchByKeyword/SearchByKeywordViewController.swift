//
//  SearchByKeywordViewController.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
import DZNEmptyDataSet

class SearchByKeywordViewController: BaseViewController ,UISearchBarDelegate ,SearchByKeywordPresenterViewProtocol,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : SearchByKeywordViewPresenterProtocol?
    var photos : [Photo] = []
    var progressView : MBProgressHUD?
    //    var isNetworkValiable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getingCachedPhotos()
    }
    
    //MARK:UISearchBarDelegate
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        photos = []
        tableView.reloadData()
        if presenter != nil {
            presenter?.searchingWithKeyword(keyword: searchBar.text!)
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let searchByUserViewController = segue.destination as! SearchByUserViewController
            let presenter  = SearchByUserPresenter(view: searchByUserViewController)
            searchByUserViewController.ownerID = photos[selectedRow].ownerID
            searchByUserViewController.presenter = presenter
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let segueIdentifier = identifier {
            if segueIdentifier == "userPhotos" {
                let isNetworkValiable = NetworkUtil.getNetworkStatus()
                
                //if network not avaliable , don't navigate to searchByUserViewController
                if isNetworkValiable == false {
                    DispatchQueue.main.async{
                        
                        self.alert(message: "OfflineMessage".localized, title: "ConnectionError".localized)
                    }
                    return false
                }else{
                    return true
                    
                }
            }
        }
        return true
    }
    
    
    
    //MARK: SearchByKeywordPresenterViewProtocol
    
    func showSearchResult(photoArray : [Photo]){
        DispatchQueue.main.async  {
            
            self.photos.append(contentsOf: photoArray)
            self.tableView.reloadData()
        }
    }
    
    func showErrorMsg(msg : String){
        DispatchQueue.main.async  {
            self.alert(message: msg)
        }
    }
    
    func showProgressBar(){
        progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
        
    }
    
    func hideProgressBar(){
        self.progressView!.hide(animated: false)
        
    }
    
    //MARK: - UITableView Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let photo = photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PhotoTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = photo.title
        
        
        
        if photo.image != nil{
            cell.photoImageView.image = UIImage(data: photo.image as! Data , scale:1)
            
        }else{
            
            let isNetworkValiable = NetworkUtil.getNetworkStatus()
            if isNetworkValiable == true { // the photos are from core date
                
                cell.photoImageView.sd_setShowActivityIndicatorView(true)
                cell.photoImageView.sd_setIndicatorStyle(.gray)
                cell.photoImageView.sd_setImage(with: URL(string: photo.getPhotoThumbnailURL()))
                
                if indexPath.row == photos.count - 1 { // last cell -> load the next page
                    presenter?.loadingMorePhotos()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

//MARK: - DZNEmptyDataSet Source/Delegate

extension SearchByKeywordViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "NoPhotos".localized)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "SearchingForPhotos".localized)
    }
}
