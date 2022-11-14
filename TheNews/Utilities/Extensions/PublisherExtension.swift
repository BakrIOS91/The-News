//
//  PublisherExtension.swift
//  

import Combine

extension Publisher {
    public func mapToVoid() -> Publishers.Map<Self, Void> {
        map { _ in }
    }
}
