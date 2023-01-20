import Foundation
import Combine
import XMLCoder

public class ConnectionManager1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum A_ARG_TYPE_ConnectionStatusEnum: String, Codable {
		case oK = "OK"
		case contentFormatMismatch = "ContentFormatMismatch"
		case insufficientBandwidth = "InsufficientBandwidth"
		case unreliableChannel = "UnreliableChannel"
		case unknown = "Unknown"
	}

	public enum A_ARG_TYPE_DirectionEnum: String, Codable {
		case input = "Input"
		case output = "Output"
	}

	public struct GetCurrentConnectionInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case rcsID = "RcsID"
			case aVTransportID = "AVTransportID"
			case protocolInfo = "ProtocolInfo"
			case peerConnectionManager = "PeerConnectionManager"
			case peerConnectionID = "PeerConnectionID"
			case direction = "Direction"
			case status = "Status"
		}

		public var rcsID: Int32
		public var aVTransportID: Int32
		public var protocolInfo: String
		public var peerConnectionManager: String
		public var peerConnectionID: Int32
		public var direction: A_ARG_TYPE_DirectionEnum
		public var status: A_ARG_TYPE_ConnectionStatusEnum
	}
	public func getCurrentConnectionInfo(connectionID: Int32) async throws -> GetCurrentConnectionInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case connectionID = "ConnectionID"
			}

			@Attribute var urn: String
			public var connectionID: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetCurrentConnectionInfo"
				case response = "u:GetCurrentConnectionInfoResponse"
			}

			var action: SoapAction?
			var response: GetCurrentConnectionInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetCurrentConnectionInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), connectionID: connectionID))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetProtocolInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case source = "Source"
			case sink = "Sink"
		}

		public var source: String
		public var sink: String
	}
	public func getProtocolInfo() async throws -> GetProtocolInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetProtocolInfo"
				case response = "u:GetProtocolInfoResponse"
			}

			var action: SoapAction?
			var response: GetProtocolInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetProtocolInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetCurrentConnectionIDsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case connectionIDs = "ConnectionIDs"
		}

		public var connectionIDs: String
	}
	public func getCurrentConnectionIDs() async throws -> GetCurrentConnectionIDsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetCurrentConnectionIDs"
				case response = "u:GetCurrentConnectionIDsResponse"
			}

			var action: SoapAction?
			var response: GetCurrentConnectionIDsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetCurrentConnectionIDs", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension ConnectionManager1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case sourceProtocolInfo = "SourceProtocolInfo"
			case sinkProtocolInfo = "SinkProtocolInfo"
			case currentConnectionIDs = "CurrentConnectionIDs"
		}

		public var sourceProtocolInfo: String?
		public var sinkProtocolInfo: String?
		public var currentConnectionIDs: String?
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
			if let sourceProtocolInfo = property.sourceProtocolInfo {
				result.sourceProtocolInfo = sourceProtocolInfo
			}
			if let sinkProtocolInfo = property.sinkProtocolInfo {
				result.sinkProtocolInfo = sinkProtocolInfo
			}
			if let currentConnectionIDs = property.currentConnectionIDs {
				result.currentConnectionIDs = currentConnectionIDs
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