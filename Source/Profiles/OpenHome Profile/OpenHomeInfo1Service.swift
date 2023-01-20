import Foundation
import Combine
import XMLCoder

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
	}
	public func counters() async throws -> CountersResponse {
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
		let result: Envelope<Body> = try await postWithResult(action: "Counters", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

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
	}
	public func track() async throws -> TrackResponse {
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
		let result: Envelope<Body> = try await postWithResult(action: "Track", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

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
	}
	public func details() async throws -> DetailsResponse {
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
		let result: Envelope<Body> = try await postWithResult(action: "Details", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MetatextResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: String
	}
	public func metatext() async throws -> MetatextResponse {
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
		let result: Envelope<Body> = try await postWithResult(action: "Metatext", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

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
}