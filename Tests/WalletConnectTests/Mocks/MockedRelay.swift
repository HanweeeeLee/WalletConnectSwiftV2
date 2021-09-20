
import Foundation
import Combine
@testable import WalletConnect

class MockedRelay: Relaying {
    private let clientSynchJsonRpcPublisherSubject = PassthroughSubject<WCSubscriptionPayload, Never>()
    var clientSynchJsonRpcPublisher: AnyPublisher<WCSubscriptionPayload, Never> {
        clientSynchJsonRpcPublisherSubject.eraseToAnyPublisher()
    }
    var subscribeCompletionId: String = ""
    var didCallSubscribe = false
    var didCallUnsubscribe = false
    func publish(topic: String, payload: Encodable, completion: @escaping ((Result<Void, Error>) -> ())) throws -> Int64 {
        fatalError()
    }
    
    func subscribe(topic: String, completion: @escaping ((Result<String, Error>) -> ())) throws -> Int64 {
        didCallSubscribe = true
        completion(.success(subscribeCompletionId))
        return 0
    }
    
    func unsubscribe(topic: String, id: String, completion: @escaping ((Result<Void, Error>) -> ())) throws -> Int64 {
        didCallUnsubscribe = true
        completion(.success(()))
        return 0
    }
    
    func sendSubscriptionPayloadOn(topic: String, subscriptionId: String) {
        let payload = WCSubscriptionPayload(topic: topic,
                                            subscriptionId: subscriptionId,
                                            clientSynchJsonRpc: SerialiserTestData.pairingApproveJSONRPCRequest)
        clientSynchJsonRpcPublisherSubject.send(payload)
    }
}
