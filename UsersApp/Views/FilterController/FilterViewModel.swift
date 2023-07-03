//
//  FilterViewModel.swift
//  UsersApp
//
//  Created by Maxos on 6/25/23.
//

import Foundation

final class FilterViewModel {
    private var filteredByGender: Filter
    private var sortedByAge: Sorting
    private var onFiltersChange: FilterUIComposer.ChangeCompletion
    
    init(filteredByGender: Filter, sortedByAge: Sorting, onFiltersChange: @escaping FilterUIComposer.ChangeCompletion) {
        self.filteredByGender = filteredByGender
        self.sortedByAge = sortedByAge
        self.onFiltersChange = onFiltersChange
    }
    
    func done() {
        onFiltersChange(filteredByGender, sortedByAge)
    }
}
