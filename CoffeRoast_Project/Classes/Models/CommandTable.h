//
//  CommandTable.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/17.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//


#ifndef CoffeRoast_Project_CommandTable_h
#define CoffeRoast_Project_CommandTable_h

/* Sync Commands
*/
static NSString * const CMSyncConnection      = @"FFAA0001000100";// Command Data , 0x00,0x01
static NSString * const CMSyncDisConnection   = @"FFAA0002000100";// Command Data , 0x00,0x03
static NSString * const CMSyncIdentification    = @"FFAA0003000100";// (Model Name (8 byte) + Device Serial No (8 byte) Command Data , 0x00,0x03
//<ffaa0003 00103341 4c494645 2d413132 33343536 373856>

/* Calibration Commands
*/
static NSString * const CMCalibrateDateRequest  = @"FFAA0601000100";
static NSString * const CMCalibrateTimeFormate = @"FFAA06020006%@"; // yyyy/MM/dd/HH/mm/
static NSString * const CMCalibrateTempRequest = @"FFAA0603000100";
static NSString * const CMCalibrateTempFormat = @"FFAA0604000100";
/* Device Commands
 */
static NSString * const CMDeviceMessage   = @"FFAA0102000100";// (production date(8 bytes) + Device ID(8 bytes) Command Data , 0x01,0x02
//<ffaa0102 00103230 31323132 32353030 30303030 303043>
static NSString * const CMDeviceStatus    = @"FFAA0103000100";// (No Data Return) Command Data , 0x01,0x03
//<ffaa0103 000a0000 00000000 00000000 5d>
static NSString * const CMDeviceHDVersion = @"FFAA0104000100";// (Firmware version (8 bytes) + PCB info (8 bytes) Command Data , 0x01,0x04
//<ffaa0104 00103030 30303030 2e383030 30303030 304127>

/* Profile Commands
 */
static NSString * const CMProfileGetName  = @"FFAA02010001%02x";    // last Bytes is Address(00~09). FF = ALL
static NSString * const CMProfileGetBody  = @"FFAA02020001%02x";    // last Bytes is Address(00~09).
static NSString * const CMProfileWriteAddress    = @"FFAA02030001%02x"; // last Bytes is Address(00~09).
static NSString * const CMProfileWriteBody    = @"FFAA02040300%@";   // Profile Body.
static NSString * const CMProfileDelete   = @"FFAA02050001%02x";    // last Bytes is Address(00~09). FF = ALL
static NSString * const CMProfileWriteTemp = @"FFAA02030001FF";

/* History Commands
 */
static NSString * const CMHistoryGetName  = @"FFAA04010001%02x";// last Bytes is Address(00~09). FF = ALL
static NSString * const CMHistoryGetBody  = @"FFAA04020001%02x";// last Bytes is Address(00~09).
static NSString * const CMHistoryDelete   = @"FFAA04030001%02x";// last Bytes is Address(00~09). FF = ALL

/* Roast Commands
 */
static NSString * const CMControlAutoModeStart   = @"FFAA0501000100";
static NSString * const CMControlManualModeStart   = @"FFAA0501000101";
static NSString * const CMControlStopRoast        = @"FFAA0501000102";
static NSString * const CMControlSetTimeStamp   = @"FFAA0501000104";
static NSString * const CMControlStopCooling     = @"FFAA0501000105";
static NSString * const CMControlReadStatus     = @"FFAA05020001FF";

static NSString * const CMControlValue = @"FFAA0504000A00%02x00%02x00%02x00000000";
static NSString * const CMControlLoadGreenBean  = @"FFAA0504000A00000014000000010000";
static NSString * const CMControlLoadRoastedBean  = @"FFAA0504000A000000014000000000001";
static NSString * const CMControlWriteParaIndex   = @"FFAA05030001FF";

#endif
