//
//  ViewModelServicesImpl.swift
//  Link2
//
//  Created by Zhengyuan Jin on 2015-05-30.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

 public class ViewModelServicesImpl: ViewModelServices {
    
    public let navigationController: UINavigationController
    public let appointmentService: AppointmentService
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appointmentService = AppointmentServiceImpl()
    }
    
    @objc public func pushViewModel(viewModel:AnyObject) {
//        if let searchResultsViewModel = viewModel as? SearchResultsViewModel {
//            self.navigationController.pushViewController(AppointmentListController(viewModel: searchResultsViewModel), animated: true)
//        }
    }
}