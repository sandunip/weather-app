//
//  AddCityViewController.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 13/2/22.
//

import UIKit

protocol AddCityDelegate {
    func addCity(city:CitySearchCellViewModel)
}

class AddCityViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var citySearchbar: UISearchBar!
    
    var delegate : AddCityDelegate?

    lazy var viewModel = {
        CitySearchViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel() {
        // Get city results
        viewModel.getCityInfo()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.citiesTableView.reloadData()
            }
        }
    }
}

extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citySearchCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CitySearchTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.ENTRY_CELL, for: indexPath) as? CitySearchTableViewCell)!
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.citySearchCellViewModels[indexPath.row]
        self.delegate?.addCity(city: selectedCity)
    }
}


