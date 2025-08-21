//
//  AVCaptureDevice+Extension.swift
//  camera_macos
//
//  Created by riccardo on 04/11/22.
//

import Foundation
import AVFoundation

extension AVCaptureDevice {
    
    @available(macOS 10.15, *)
    public class func captureDevice(deviceTypes: [AVCaptureDevice.DeviceType], mediaType: AVMediaType) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: mediaType, position: .unspecified).devices
        return devices.first
    }
    
    @available(macOS 10.15, *)
    public class func captureDevices(deviceTypes: [AVCaptureDevice.DeviceType], mediaType: AVMediaType? = nil) -> [AVCaptureDevice] {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: mediaType, position: .unspecified).devices
        return devices
    }
    
    public class func captureDevice(mediaType: AVMediaType) -> AVCaptureDevice? {
        if #available(macOS 10.15, *) {
            let deviceTypes: [AVCaptureDevice.DeviceType] = mediaType == .video ? [.builtInWideAngleCamera, .external] : [.microphone, .external]
            return AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: mediaType, position: .unspecified).devices.first
        } else {
            return AVCaptureDevice.devices(for: mediaType).first
        }
    }
    
    public class func captureDevices(mediaType: AVMediaType? = nil) -> [AVCaptureDevice] {
        if #available(macOS 10.15, *) {
            if let mediaType = mediaType {
                let deviceTypes: [AVCaptureDevice.DeviceType] = mediaType == .video ? [.builtInWideAngleCamera, .external] : [.microphone, .external]
                return AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: mediaType, position: .unspecified).devices
            } else {
                let videoDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .external], mediaType: .video, position: .unspecified).devices
                let audioDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.microphone, .external], mediaType: .audio, position: .unspecified).devices
                return videoDevices + audioDevices
            }
        } else {
            if let mediaType = mediaType {
                return AVCaptureDevice.devices(for: mediaType)
            } else {
                return AVCaptureDevice.devices()
            }
        }
    }
    
}
