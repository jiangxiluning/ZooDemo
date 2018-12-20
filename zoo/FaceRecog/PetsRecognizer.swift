//
//  PetsRecognizer.swift
//  zoo
//
//  Created by luning on 2018/12/20.
//  Copyright © 2018 luning. All rights reserved.
//

import Foundation
import CoreML

class PetsRecognizer {
    static let core = PetsRecognizer()
    
    private let classifier: MLModel? = nil
    private let detector: MLModel? = nil
    private let featurizer: MLModel? = nil
    private let threshold: Float = 0.5
    
    private init()
    {
        
    }
    
    func classify(image: Data) -> Pet.Category? {
        return .dog
    }
    
    private func detect(image: Data) -> [Int]? {
        return [1,2,3,4]
    }
    
    func featurize(image:Data) -> Data? {
        
        let _ = self.detect(image: image)
        return Data([1,2,3,4])
    }
    
    func verify(featureInDB: Data, featureNow: Data) -> Bool {
        return false
    }
}
