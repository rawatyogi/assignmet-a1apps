//
//  OutfitsVC.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

/*
 Note that there is intentional delay while scrolling just to demonstrate pagination
 */

import UIKit

class OutfitsVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelSummer: UILabel!
    @IBOutlet weak var labelWardrobesCount: UILabel!
    @IBOutlet weak var outfitsTableView: UITableView!
    
    //MARK: PROPERTIES
    let pageSize = 10
    var currentPage = 0
    var isLoading = false
    var displayedOutfits: [Outfit] = []
    let viewModel = OutfitViewModel(repo: RepositoryFactory.makeOutfitRepository())
    
    //MARK: VIEW LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOutfits()
        setupTableView()
        setupUIComponents()
    }
    
    //MARK: SETUP UI COMPONENTS
    func setupUIComponents() {
        labelSummer.textColor = .white
        labelWardrobesCount.textColor = .white
        viewHeader.applyGradient(colors: [.purple, .systemPink])
    }
    
    //MARK: TABLE SETUP
    func setupTableView() {
        outfitsTableView.delegate = self
        outfitsTableView.dataSource = self
        outfitsTableView.registerCell(identifier: OutfitsTableViewCell.self)
    }
    
    //MARK: FETCH OUTFITS
    func fetchOutfits() {
        
        Task { [weak self] in
            
            guard let self = self else { return}
            
            AppLoader.shared.showLoader()
            let result = await viewModel.fetchOutfits()
            AppLoader.shared.stopLoader()
            
            switch result {
                
            case .success:
                self.labelWardrobesCount.text = "\(viewModel.outfits.count) wardrobes"
                self.loadNextPage()
                
            case .failure(let failure):
                self.showAlert(message: failure.errorMsg)
                AppLogs.shared.debugLogs("FAILURE : \(failure.errorMsg)")
            }
        }
    }
    
    //MARK: PAGINATING
    func loadNextPage() {
        
        guard !isLoading else { return }
        isLoading = true
        
        outfitsTableView.reloadSections(IndexSet(integer: 0), with: .none)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let start = self.currentPage * self.pageSize
            let end = min(start + self.pageSize, self.viewModel.outfits.count)
            
            if start < end {
                let nextPageData = Array(self.viewModel.outfits[start..<end])
                self.displayedOutfits.append(contentsOf: nextPageData)
                self.currentPage += 1
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.outfitsTableView.reloadData()
            }
        }
    }
    
    //MARK: BACK BUTTON CLICKED
    @IBAction func backButtonClicked(_ sender: UIButton) { /*not functional*/ }
}

//MARK: TABLE DELEGATE
extension OutfitsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayedOutfits.count - 1 {
            loadNextPage()
        }
    }
    
    /*
     Purpose : to show activity indicator while loading data for next page.
     Issue : As this pagination is implemented locally because web service does no permit so. IN such case data is being appended locally and this operation is too fast hence it does isLoading value updates its value early hence loader is not visible at bottom
     
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return isLoading ? UIView().createFooterLoader(showLoader: true) : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isLoading ? 60 : 0.001
    }
     */
}

//MARK: TABLE DATASOURCE
extension OutfitsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOutfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutfitsTableViewCell", for: indexPath) as! OutfitsTableViewCell
        cell.setupData(outfit: displayedOutfits[indexPath.row])
        return cell
    }
}


/*
 #Remaining case handling :
 - footer at bottom with loader
 - refresh api
 - error msgs placeholders
 */
