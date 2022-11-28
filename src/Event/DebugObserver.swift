import Foundation

open class DebugObserverFactory: ObserverFactory {
    public override init() {}

    override open func getObserverForTunnel(_ tunnel: Tunnel) -> Observer<TunnelEvent>? {
        return DebugTunnelObserver()
    }

    override open func getObserverForProxyServer(_ server: ProxyServer) -> Observer<ProxyServerEvent>? {
        return DebugProxyServerObserver()
    }

    override open func getObserverForProxySocket(_ socket: ProxySocket) -> Observer<ProxySocketEvent>? {
        return DebugProxySocketObserver()
    }

    override open func getObserverForAdapterSocket(_ socket: AdapterSocket) -> Observer<AdapterSocketEvent>? {
        return DebugAdapterSocketObserver()
    }

    open override func getObserverForRuleManager(_ manager: RuleManager) -> Observer<RuleMatchEvent>? {
        return DebugRuleManagerObserver()
    }
}

open class DebugTunnelObserver: Observer<TunnelEvent> {
    override open func signal(_ event: TunnelEvent) {
        switch event {
        case .receivedRequest,
             .closed:
            print("\(event)")
        case .opened,
             .connectedToRemote,
             .updatingAdapterSocket:
            print("\(event)")
        case .closeCalled,
             .forceCloseCalled,
             .receivedReadySignal,
             .proxySocketReadData,
             .proxySocketWroteData,
             .adapterSocketReadData,
             .adapterSocketWroteData:
            print("\(event)")
        }
    }
}

open class DebugProxySocketObserver: Observer<ProxySocketEvent> {
    override open func signal(_ event: ProxySocketEvent) {
        switch event {
        case .errorOccured:
            print("\(event)")
        case .disconnected,
             .receivedRequest:
            print("\(event)")
        case .socketOpened,
             .askedToResponseTo,
             .readyForForward:
            print("\(event)")
        case .disconnectCalled,
             .forceDisconnectCalled,
             .readData,
             .wroteData:
            print("\(event)")
        }
    }
}

open class DebugAdapterSocketObserver: Observer<AdapterSocketEvent> {
    override open func signal(_ event: AdapterSocketEvent) {
        switch event {
        case .errorOccured:
            print("\(event)")
        case .disconnected,
             .connected:
            print("\(event)")
        case .socketOpened,
             .readyForForward:
            print("\(event)")
        case .disconnectCalled,
             .forceDisconnectCalled,
             .readData,
             .wroteData:
            print("\(event)")
        }
    }
}

open class DebugProxyServerObserver: Observer<ProxyServerEvent> {
    override open func signal(_ event: ProxyServerEvent) {
        switch event {
        case .started,
             .stopped:
            print("\(event)")
        case .newSocketAccepted,
             .tunnelClosed:
            print("\(event)")
        }
    }
}

open class DebugRuleManagerObserver: Observer<RuleMatchEvent> {
    open override func signal(_ event: RuleMatchEvent) {
        switch event {
        case .ruleDidNotMatch, .dnsRuleMatched:
            print("\(event)")
        case .ruleMatched:
            print("\(event)")
        }
    }
}
