//
//  MessageFilterExtension.swift
//  MessageFilterExtension
//
//  Created by Marin on 08/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import IdentityLookup

final class MessageFilterExtension: ILMessageFilterExtension {}

extension MessageFilterExtension: ILMessageFilterQueryHandling {

    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        let action = self.offlineAction(for: queryRequest)
        let response = ILMessageFilterQueryResponse()
        response.action = action
        completion(response)
    }

    private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
        
        guard let messageBody = queryRequest.messageBody?.lowercased() else { return .none}
        let filterWords = ["free", "won"]
        
        for word in filterWords {
            if messageBody.contains(word) {
                return .filter
            }
        }
        return .allow
    }

    private func action(for networkResponse: ILNetworkResponse) -> ILMessageFilterAction {
        // Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
        return .none
    }

}
