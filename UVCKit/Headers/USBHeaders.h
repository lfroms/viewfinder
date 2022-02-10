//
//  USBHeaders.h
//  UVCKit
//
//  Created by Lukas Romsicki on 2022-02-07.
//
//  Originally written by Itay Brenner on 2020-07-20. Adapted from:
//  https://github.com/Itaybre/CameraController/blob/50747fb07880a15e175cd4d98adfa028df7ebe42/CameraController/UVC/Models/USBHeaders.h
//

#include <stdint.h>

struct UVC_InterfaceDescriptorHdr {
    uint8_t bLength;
    uint8_t bDescriptorType;
    uint8_t bDescriptorSubType;
} __attribute__((packed));

struct UVC_VCHeaderDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint16_t bcdUVC;
    uint16_t wTotalLength;
    uint32_t dwClockFrequency;
    uint8_t  bInCollection;
    uint8_t  baInterface;
} __attribute__((packed));

struct UVC_CameraTerminalDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint8_t  bTerminalID;
    uint16_t wTerminalType;
    uint8_t  bAssocTerminal;
    uint8_t  iTerminal;
    uint16_t wObjectiveFocalLengthMin;
    uint16_t wObjectiveFocalLengthMax;
    uint16_t wOcularFocalLength;
    uint8_t  bControlSize;
    uint8_t  bmControls[];
} __attribute__((packed));

struct UVC_ProcessingUnitDescriptor {
    uint8_t  bLength;
    uint8_t  bDescriptorType;
    uint8_t  bDescriptorSubType;
    uint8_t  bUnitID;
    uint8_t  bSourceID;
    uint16_t wMaxMultiplier;
    uint8_t  bControlSize;
    uint8_t  bmControls[];
} __attribute__((packed));
