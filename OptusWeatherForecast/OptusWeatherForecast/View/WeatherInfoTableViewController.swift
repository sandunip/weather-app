//
//  WeatherInfoTableViewController.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import UIKit

class WeatherInfoTableViewController: UITableViewController, AddCityDelegate {
    lazy var viewModel = {
        CityViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel() {
        // Get city data
        viewModel.getCityInfo()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Add City Delegate
    func addCity(city: CitySearchCellViewModel) {
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityCellViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CityTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.ENTRY_CELL, for: indexPath) as? CityTableViewCell)!
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let destinationViewController = segue.destination as? AddCityViewController
            destinationViewController?.delegate = self
        }
    }
}
