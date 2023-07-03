//
//  FilterUIComposer.swift
//  UsersApp
//
//  Created by Maxos on 6/25/23.
//

import UIKit

enum FilterUIComposer {
    typealias ChangeCompletion = (_ selectedFilter: Filter, _ selectedSorting: Sorting) -> Void
    
    static func build(
        selectedFilter: Filter,
        selectedSorting: Sorting,
        onFiltersChange: @escaping ChangeCompletion
    ) -> UIViewController {
        let vc = FilterViewController()
        let viewModel = FilterViewModel(
            filteredByGender: selectedFilter,
            sortedByAge: selectedSorting,
            onFiltersChange: onFiltersChange
        )
        
        vc.viewModel = viewModel
        
        return vc
    }
}
