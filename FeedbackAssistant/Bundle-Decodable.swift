//
//  Bundle-Decodable.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 17/10/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(
        _ file: String,
        as type: T.Type = T.self,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file)from bundle. \(key.stringValue)- context \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file)Type mismatch: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) Type\(type) not found in \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle. Data corrupted.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
