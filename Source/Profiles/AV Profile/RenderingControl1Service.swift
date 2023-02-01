import Foundation
import Combine
import XMLCoder
import os.log

public class RenderingControl1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum A_ARG_TYPE_ChannelEnum: String, Codable {
		case master = "Master"
		case lf = "LF"
		case rf = "RF"
		case cf = "CF"
		case lfe = "LFE"
		case ls = "LS"
		case rs = "RS"
		case lfc = "LFC"
		case rfc = "RFC"
		case sd = "SD"
		case sl = "SL"
		case sr = "SR"
		case t = "T"
		case b = "B"
		case vendorDefined = "Vendor defined"
	}

	public enum A_ARG_TYPE_PresetNameEnum: String, Codable {
		case factoryDefaults = "FactoryDefaults"
		case installationDefaults = "InstallationDefaults"
		case vendorDefined = "Vendor defined"
	}

	public struct ListPresetsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentPresetNameList = "CurrentPresetNameList"
		}

		public var currentPresetNameList: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ListPresetsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentPresetNameList: '\(currentPresetNameList)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func listPresets(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> ListPresetsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ListPresets"
				case response = "u:ListPresetsResponse"
			}

			var action: SoapAction?
			var response: ListPresetsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ListPresets", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func selectPreset(instanceID: UInt32, presetName: A_ARG_TYPE_PresetNameEnum, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case presetName = "PresetName"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var presetName: A_ARG_TYPE_PresetNameEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SelectPreset"
			}

			var action: SoapAction
		}
		try await post(action: "SelectPreset", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, presetName: presetName))), log: log)
	}

	public struct GetBrightnessResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentBrightness = "CurrentBrightness"
		}

		public var currentBrightness: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetBrightnessResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentBrightness: \(currentBrightness)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getBrightness(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetBrightnessResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetBrightness"
				case response = "u:GetBrightnessResponse"
			}

			var action: SoapAction?
			var response: GetBrightnessResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetBrightness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setBrightness(instanceID: UInt32, desiredBrightness: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredBrightness = "DesiredBrightness"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredBrightness: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetBrightness"
			}

			var action: SoapAction
		}
		try await post(action: "SetBrightness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredBrightness: desiredBrightness))), log: log)
	}

	public struct GetContrastResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentContrast = "CurrentContrast"
		}

		public var currentContrast: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetContrastResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentContrast: \(currentContrast)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getContrast(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetContrastResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetContrast"
				case response = "u:GetContrastResponse"
			}

			var action: SoapAction?
			var response: GetContrastResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetContrast", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setContrast(instanceID: UInt32, desiredContrast: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredContrast = "DesiredContrast"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredContrast: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetContrast"
			}

			var action: SoapAction
		}
		try await post(action: "SetContrast", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredContrast: desiredContrast))), log: log)
	}

	public struct GetSharpnessResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentSharpness = "CurrentSharpness"
		}

		public var currentSharpness: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetSharpnessResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentSharpness: \(currentSharpness)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getSharpness(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetSharpnessResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetSharpness"
				case response = "u:GetSharpnessResponse"
			}

			var action: SoapAction?
			var response: GetSharpnessResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetSharpness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setSharpness(instanceID: UInt32, desiredSharpness: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredSharpness = "DesiredSharpness"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredSharpness: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetSharpness"
			}

			var action: SoapAction
		}
		try await post(action: "SetSharpness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredSharpness: desiredSharpness))), log: log)
	}

	public struct GetRedVideoGainResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentRedVideoGain = "CurrentRedVideoGain"
		}

		public var currentRedVideoGain: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetRedVideoGainResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentRedVideoGain: \(currentRedVideoGain)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getRedVideoGain(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetRedVideoGainResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetRedVideoGain"
				case response = "u:GetRedVideoGainResponse"
			}

			var action: SoapAction?
			var response: GetRedVideoGainResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetRedVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setRedVideoGain(instanceID: UInt32, desiredRedVideoGain: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredRedVideoGain = "DesiredRedVideoGain"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredRedVideoGain: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetRedVideoGain"
			}

			var action: SoapAction
		}
		try await post(action: "SetRedVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredRedVideoGain: desiredRedVideoGain))), log: log)
	}

	public struct GetGreenVideoGainResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentGreenVideoGain = "CurrentGreenVideoGain"
		}

		public var currentGreenVideoGain: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetGreenVideoGainResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentGreenVideoGain: \(currentGreenVideoGain)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getGreenVideoGain(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetGreenVideoGainResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetGreenVideoGain"
				case response = "u:GetGreenVideoGainResponse"
			}

			var action: SoapAction?
			var response: GetGreenVideoGainResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetGreenVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setGreenVideoGain(instanceID: UInt32, desiredGreenVideoGain: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredGreenVideoGain = "DesiredGreenVideoGain"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredGreenVideoGain: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetGreenVideoGain"
			}

			var action: SoapAction
		}
		try await post(action: "SetGreenVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredGreenVideoGain: desiredGreenVideoGain))), log: log)
	}

	public struct GetBlueVideoGainResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentBlueVideoGain = "CurrentBlueVideoGain"
		}

		public var currentBlueVideoGain: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetBlueVideoGainResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentBlueVideoGain: \(currentBlueVideoGain)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getBlueVideoGain(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetBlueVideoGainResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetBlueVideoGain"
				case response = "u:GetBlueVideoGainResponse"
			}

			var action: SoapAction?
			var response: GetBlueVideoGainResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetBlueVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setBlueVideoGain(instanceID: UInt32, desiredBlueVideoGain: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredBlueVideoGain = "DesiredBlueVideoGain"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredBlueVideoGain: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetBlueVideoGain"
			}

			var action: SoapAction
		}
		try await post(action: "SetBlueVideoGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredBlueVideoGain: desiredBlueVideoGain))), log: log)
	}

	public struct GetRedVideoBlackLevelResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentRedVideoBlackLevel = "CurrentRedVideoBlackLevel"
		}

		public var currentRedVideoBlackLevel: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetRedVideoBlackLevelResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentRedVideoBlackLevel: \(currentRedVideoBlackLevel)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getRedVideoBlackLevel(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetRedVideoBlackLevelResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetRedVideoBlackLevel"
				case response = "u:GetRedVideoBlackLevelResponse"
			}

			var action: SoapAction?
			var response: GetRedVideoBlackLevelResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetRedVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setRedVideoBlackLevel(instanceID: UInt32, desiredRedVideoBlackLevel: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredRedVideoBlackLevel = "DesiredRedVideoBlackLevel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredRedVideoBlackLevel: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetRedVideoBlackLevel"
			}

			var action: SoapAction
		}
		try await post(action: "SetRedVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredRedVideoBlackLevel: desiredRedVideoBlackLevel))), log: log)
	}

	public struct GetGreenVideoBlackLevelResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentGreenVideoBlackLevel = "CurrentGreenVideoBlackLevel"
		}

		public var currentGreenVideoBlackLevel: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetGreenVideoBlackLevelResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentGreenVideoBlackLevel: \(currentGreenVideoBlackLevel)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getGreenVideoBlackLevel(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetGreenVideoBlackLevelResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetGreenVideoBlackLevel"
				case response = "u:GetGreenVideoBlackLevelResponse"
			}

			var action: SoapAction?
			var response: GetGreenVideoBlackLevelResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetGreenVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setGreenVideoBlackLevel(instanceID: UInt32, desiredGreenVideoBlackLevel: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredGreenVideoBlackLevel = "DesiredGreenVideoBlackLevel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredGreenVideoBlackLevel: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetGreenVideoBlackLevel"
			}

			var action: SoapAction
		}
		try await post(action: "SetGreenVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredGreenVideoBlackLevel: desiredGreenVideoBlackLevel))), log: log)
	}

	public struct GetBlueVideoBlackLevelResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentBlueVideoBlackLevel = "CurrentBlueVideoBlackLevel"
		}

		public var currentBlueVideoBlackLevel: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetBlueVideoBlackLevelResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentBlueVideoBlackLevel: \(currentBlueVideoBlackLevel)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getBlueVideoBlackLevel(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetBlueVideoBlackLevelResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetBlueVideoBlackLevel"
				case response = "u:GetBlueVideoBlackLevelResponse"
			}

			var action: SoapAction?
			var response: GetBlueVideoBlackLevelResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetBlueVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setBlueVideoBlackLevel(instanceID: UInt32, desiredBlueVideoBlackLevel: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredBlueVideoBlackLevel = "DesiredBlueVideoBlackLevel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredBlueVideoBlackLevel: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetBlueVideoBlackLevel"
			}

			var action: SoapAction
		}
		try await post(action: "SetBlueVideoBlackLevel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredBlueVideoBlackLevel: desiredBlueVideoBlackLevel))), log: log)
	}

	public struct GetColorTemperatureResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentColorTemperature = "CurrentColorTemperature"
		}

		public var currentColorTemperature: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetColorTemperatureResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentColorTemperature: \(currentColorTemperature)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getColorTemperature(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetColorTemperatureResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetColorTemperature"
				case response = "u:GetColorTemperatureResponse"
			}

			var action: SoapAction?
			var response: GetColorTemperatureResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetColorTemperature", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setColorTemperature(instanceID: UInt32, desiredColorTemperature: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredColorTemperature = "DesiredColorTemperature"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredColorTemperature: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetColorTemperature"
			}

			var action: SoapAction
		}
		try await post(action: "SetColorTemperature", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredColorTemperature: desiredColorTemperature))), log: log)
	}

	public struct GetHorizontalKeystoneResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentHorizontalKeystone = "CurrentHorizontalKeystone"
		}

		public var currentHorizontalKeystone: Int16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetHorizontalKeystoneResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentHorizontalKeystone: \(currentHorizontalKeystone)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getHorizontalKeystone(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetHorizontalKeystoneResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetHorizontalKeystone"
				case response = "u:GetHorizontalKeystoneResponse"
			}

			var action: SoapAction?
			var response: GetHorizontalKeystoneResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetHorizontalKeystone", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setHorizontalKeystone(instanceID: UInt32, desiredHorizontalKeystone: Int16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredHorizontalKeystone = "DesiredHorizontalKeystone"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredHorizontalKeystone: Int16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetHorizontalKeystone"
			}

			var action: SoapAction
		}
		try await post(action: "SetHorizontalKeystone", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredHorizontalKeystone: desiredHorizontalKeystone))), log: log)
	}

	public struct GetVerticalKeystoneResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentVerticalKeystone = "CurrentVerticalKeystone"
		}

		public var currentVerticalKeystone: Int16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetVerticalKeystoneResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentVerticalKeystone: \(currentVerticalKeystone)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getVerticalKeystone(instanceID: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetVerticalKeystoneResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetVerticalKeystone"
				case response = "u:GetVerticalKeystoneResponse"
			}

			var action: SoapAction?
			var response: GetVerticalKeystoneResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetVerticalKeystone", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setVerticalKeystone(instanceID: UInt32, desiredVerticalKeystone: Int16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case desiredVerticalKeystone = "DesiredVerticalKeystone"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var desiredVerticalKeystone: Int16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVerticalKeystone"
			}

			var action: SoapAction
		}
		try await post(action: "SetVerticalKeystone", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, desiredVerticalKeystone: desiredVerticalKeystone))), log: log)
	}

	public struct GetMuteResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentMute = "CurrentMute"
		}

		public var currentMute: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetMuteResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentMute: \(currentMute == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getMute(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, log: UPnPService.MessageLog = .none) async throws -> GetMuteResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetMute"
				case response = "u:GetMuteResponse"
			}

			var action: SoapAction?
			var response: GetMuteResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetMute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setMute(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, desiredMute: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
				case desiredMute = "DesiredMute"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
			public var desiredMute: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetMute"
			}

			var action: SoapAction
		}
		try await post(action: "SetMute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel, desiredMute: desiredMute))), log: log)
	}

	public struct GetVolumeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentVolume = "CurrentVolume"
		}

		public var currentVolume: UInt16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetVolumeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentVolume: \(currentVolume)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getVolume(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, log: UPnPService.MessageLog = .none) async throws -> GetVolumeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetVolume"
				case response = "u:GetVolumeResponse"
			}

			var action: SoapAction?
			var response: GetVolumeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetVolume", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setVolume(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, desiredVolume: UInt16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
				case desiredVolume = "DesiredVolume"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
			public var desiredVolume: UInt16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVolume"
			}

			var action: SoapAction
		}
		try await post(action: "SetVolume", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel, desiredVolume: desiredVolume))), log: log)
	}

	public struct GetVolumeDBResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentVolume = "CurrentVolume"
		}

		public var currentVolume: Int16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetVolumeDBResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentVolume: \(currentVolume)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getVolumeDB(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, log: UPnPService.MessageLog = .none) async throws -> GetVolumeDBResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetVolumeDB"
				case response = "u:GetVolumeDBResponse"
			}

			var action: SoapAction?
			var response: GetVolumeDBResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetVolumeDB", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setVolumeDB(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, desiredVolume: Int16, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
				case desiredVolume = "DesiredVolume"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
			public var desiredVolume: Int16
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVolumeDB"
			}

			var action: SoapAction
		}
		try await post(action: "SetVolumeDB", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel, desiredVolume: desiredVolume))), log: log)
	}

	public struct GetVolumeDBRangeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case minValue = "MinValue"
			case maxValue = "MaxValue"
		}

		public var minValue: Int16
		public var maxValue: Int16

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetVolumeDBRangeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))minValue: \(minValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))maxValue: \(maxValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getVolumeDBRange(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, log: UPnPService.MessageLog = .none) async throws -> GetVolumeDBRangeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetVolumeDBRange"
				case response = "u:GetVolumeDBRangeResponse"
			}

			var action: SoapAction?
			var response: GetVolumeDBRangeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetVolumeDBRange", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetLoudnessResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentLoudness = "CurrentLoudness"
		}

		public var currentLoudness: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetLoudnessResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentLoudness: \(currentLoudness == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getLoudness(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, log: UPnPService.MessageLog = .none) async throws -> GetLoudnessResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetLoudness"
				case response = "u:GetLoudnessResponse"
			}

			var action: SoapAction?
			var response: GetLoudnessResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetLoudness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setLoudness(instanceID: UInt32, channel: A_ARG_TYPE_ChannelEnum, desiredLoudness: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case instanceID = "InstanceID"
				case channel = "Channel"
				case desiredLoudness = "DesiredLoudness"
			}

			@Attribute var urn: String
			public var instanceID: UInt32
			public var channel: A_ARG_TYPE_ChannelEnum
			public var desiredLoudness: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetLoudness"
			}

			var action: SoapAction
		}
		try await post(action: "SetLoudness", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), instanceID: instanceID, channel: channel, desiredLoudness: desiredLoudness))), log: log)
	}

}

// Event parser
extension RenderingControl1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case lastChange = "LastChange"
		}

		public var lastChange: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))RenderingControl1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lastChange: '\(lastChange ?? "nil")'")
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
			if let lastChange = property.lastChange {
				result.lastChange = lastChange
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