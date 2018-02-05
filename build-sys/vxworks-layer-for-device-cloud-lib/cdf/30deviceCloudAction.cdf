/**
 * @file
 * @brief VxWorks 7 component descriptor file
 *
 * @copyright Copyright (C) 2017 Wind River Systems, Inc. All Rights Reserved.
 *
 * @license Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed
 * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
 * OR CONDITIONS OF ANY KIND, either express or implied."
 */

/*
modification history
--------------------
05oct17,yat  created
*/

Component INCLUDE_DEVICE_CLOUD_ACTION_KERNEL {
        NAME            Device Cloud actions kernel task
        SYNOPSIS        This component invokes the actions application as kernel task
        _CHILDREN       SELECT_DEVICE_CLOUD_APP
        ARCHIVE         libdeviceCloudAction.a
        CONFIGLETTES    deviceCloudActionCfg.c
        PROTOTYPE       void deviceCloudActionStart(void);
        INIT_RTN        deviceCloudActionStart();
        _INIT_ORDER     usrRoot
        INIT_AFTER      usrToolsInit
        INIT_BEFORE     INCLUDE_USER_APPL
        REQUIRES        INCLUDE_DEVICE_CLOUD
}

Component INCLUDE_DEVICE_CLOUD_ACTION_RTP {
        NAME            Device Cloud actions RTP
        SYNOPSIS        This component invokes the actions application as RTP
        _CHILDREN       SELECT_DEVICE_CLOUD_APP
        CONFIGLETTES    deviceCloudActionRtpCfg.c
        PROTOTYPE       void deviceCloudActionRtp(void);
        INIT_RTN        deviceCloudActionRtp();
        _INIT_ORDER     usrRoot
        INIT_AFTER      usrToolsInit
        INIT_BEFORE     INCLUDE_USER_APPL
        REQUIRES        INCLUDE_DEVICE_CLOUD
}
