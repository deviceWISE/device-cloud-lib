/**
 * @file
 * @brief VxWorks 7 configlette file
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

const char *deviceCloudConfigDirGet (void)
    {
    return DEVICE_CLOUD_CONFIG_DIR;
    }

const char *deviceCloudRuntimeDirGet (void)
    {
    return DEVICE_CLOUD_RUNTIME_DIR;
    }

const char *deviceCloudRtpDirGet (void)
    {
    return DEVICE_CLOUD_RTP_DIR;
    }

unsigned int deviceCloudPriorityGet (void)
    {
    return DEVICE_CLOUD_PRIORITY;
    }

unsigned int deviceCloudStackSizeGet (void)
    {
    return DEVICE_CLOUD_STACK_SIZE;
    }
