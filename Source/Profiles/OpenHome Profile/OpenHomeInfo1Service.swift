//
//  Copyright (c) 2023 Katoemba Software, (https://rigelian.net/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Generated by SwiftUPnP/UPnPCodeGenerator
//

import Foundation
import Combine
import XMLCoder
import os.log

public class OpenHomeInfo1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct CountersResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case trackCount = "TrackCount"
			case detailsCount = "DetailsCount"
			case metatextCount = "MetatextCount"
		}

		public var trackCount: UInt32
		public var detailsCount: UInt32
		public var metatextCount: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))CountersResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trackCount: \(trackCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))detailsCount: \(detailsCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metatextCount: \(metatextCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func counters(log: UPnPService.MessageLog = .none) async throws -> CountersResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Counters"
				case response = "u:CountersResponse"
			}

			var action: SoapAction?
			var response: CountersResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Counters", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct TrackResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case uri = "Uri"
			case metadata = "Metadata"
		}

		public var uri: String
		public var metadata: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))TrackResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))uri: '\(uri)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metadata: '\(metadata)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func track(log: UPnPService.MessageLog = .none) async throws -> TrackResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Track"
				case response = "u:TrackResponse"
			}

			var action: SoapAction?
			var response: TrackResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Track", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct DetailsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case duration = "Duration"
			case bitRate = "BitRate"
			case bitDepth = "BitDepth"
			case sampleRate = "SampleRate"
			case lossless = "Lossless"
			case codecName = "CodecName"
		}

		public var duration: UInt32
		public var bitRate: UInt32
		public var bitDepth: UInt32
		public var sampleRate: UInt32
		public var lossless: Bool
		public var codecName: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DetailsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))duration: \(duration)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))bitRate: \(bitRate)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))bitDepth: \(bitDepth)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))sampleRate: \(sampleRate)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lossless: \(lossless == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))codecName: '\(codecName)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func details(log: UPnPService.MessageLog = .none) async throws -> DetailsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Details"
				case response = "u:DetailsResponse"
			}

			var action: SoapAction?
			var response: DetailsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Details", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MetatextResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MetatextResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: '\(value)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func metatext(log: UPnPService.MessageLog = .none) async throws -> MetatextResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Metatext"
				case response = "u:MetatextResponse"
			}

			var action: SoapAction?
			var response: MetatextResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Metatext", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension OpenHomeInfo1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case trackCount = "TrackCount"
			case detailsCount = "DetailsCount"
			case metatextCount = "MetatextCount"
			case uri = "Uri"
			case metadata = "Metadata"
			case duration = "Duration"
			case bitRate = "BitRate"
			case bitDepth = "BitDepth"
			case sampleRate = "SampleRate"
			case lossless = "Lossless"
			case codecName = "CodecName"
			case metatext = "Metatext"
		}

		public var trackCount: UInt32?
		public var detailsCount: UInt32?
		public var metatextCount: UInt32?
		public var uri: String?
		public var metadata: String?
		public var duration: UInt32?
		public var bitRate: UInt32?
		public var bitDepth: UInt32?
		public var sampleRate: UInt32?
		public var lossless: Bool?
		public var codecName: String?
		public var metatext: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))OpenHomeInfo1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trackCount: \(trackCount ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))detailsCount: \(detailsCount ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metatextCount: \(metatextCount ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))uri: '\(uri ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metadata: '\(metadata ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))duration: \(duration ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))bitRate: \(bitRate ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))bitDepth: \(bitDepth ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))sampleRate: \(sampleRate ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lossless: \((lossless == nil) ? "nil" : (lossless! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))codecName: '\(codecName ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))metatext: '\(metatext ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}

	public func state(xml: Data) throws -> State {
		struct PropertySet: Codable {
			var property: [State]
		}

		let decoder = XMLDecoder()
		decoder.shouldProcessNamespaces = true
		let propertySet = try decoder.decode(PropertySet.self, from: xml)

		return propertySet.property.reduce(State()) { partialResult, property in
			var result = partialResult
			if let trackCount = property.trackCount {
				result.trackCount = trackCount
			}
			if let detailsCount = property.detailsCount {
				result.detailsCount = detailsCount
			}
			if let metatextCount = property.metatextCount {
				result.metatextCount = metatextCount
			}
			if let uri = property.uri {
				result.uri = uri
			}
			if let metadata = property.metadata {
				result.metadata = metadata
			}
			if let duration = property.duration {
				result.duration = duration
			}
			if let bitRate = property.bitRate {
				result.bitRate = bitRate
			}
			if let bitDepth = property.bitDepth {
				result.bitDepth = bitDepth
			}
			if let sampleRate = property.sampleRate {
				result.sampleRate = sampleRate
			}
			if let lossless = property.lossless {
				result.lossless = lossless
			}
			if let codecName = property.codecName {
				result.codecName = codecName
			}
			if let metatext = property.metatext {
				result.metatext = metatext
			}
			return result
		}
	}

	public var stateSubject: AnyPublisher<State, Never> {
		subscribedEventPublisher
			.compactMap { [weak self] in
				guard let self else { return nil }

				return try? self.state(xml: $0)
			}
			.eraseToAnyPublisher()
	}

	public var stateChangeStream: AsyncStream<State> {
		stateSubject.stream
	}
}
