/**
 * @file
 * @brief Contains definitions for handling base64 data
 *
 * @copyright Copyright (C) 2017 Wind River Systems, Inc. All Rights Reserved.
 *
 * @license The right to copy, distribute or otherwise make use of this software
 * may be licensed only pursuant to the terms of an applicable Wind River
 * license agreement.  No license to Wind River intellectual property rights is
 * granted herein.  All rights not licensed by Wind River are reserved by Wind
 * River.
 */

#ifndef IOT_BASE64_H
#define IOT_BASE64_H

#include "iot.h" /* for IOT_API, IOT_SECTION definitions */
#include <os.h>  /* for ssize_t */

#ifdef __cplusplus
extern "C" {
#endif /* ifdef __cplusplus */

/**
 * @brief Decode an arbitrary size memory area.
 *
 * This function decodes the base64-string pointed to by \c in and stores the
 * result in the memory area pointed to by \c out. The result will \e not be
 * null-terminated.
 *
 * @param[out]     out                 pointer to destination
 * @param[out]     out_len             size of destination buffer
 * @param[in]      in                  pointer to source
 * @param[in]      in_len              length of source data
 *
 * @returns -1 on error (illegal character) or the number of bytes decoded
 */
IOT_API IOT_SECTION ssize_t iot_base64_decode( uint8_t *out,
                                               size_t out_len,
                                               const uint8_t *in,
                                               size_t in_len );

/**
 * @brief Compute size of needed storage for decoding
 *
 * This function computes the minimum size of a memory area needed to hold the
 * result of a decoding operation, not including the terminating null character.
 *
 * @param[in]      in_bytes            size of data in bytes
 *
 * @returns output size
 */
IOT_API IOT_SECTION size_t iot_base64_decode_size( size_t in_bytes );

/**
 * @brief Encode a block of data in base64
 *
 * This function encodes the base64-string pointed to by \c in and stores the
 * result in the memory area pointed to by \c out. The result will \e not be
 * null-terminated.
 *
 * @param[out]     out                 pointer to destination
 * @param[out]     out_len             size of destination buffer
 * @param[in]      in                  pointer to source
 * @param[in]      in_len              length of source data
 *
 * @return Number of characters outputted
 */
IOT_API IOT_SECTION size_t iot_base64_encode( uint8_t *out,
                                              size_t out_len,
                                              const uint8_t *in,
                                              size_t in_len );

/**
 * @brief Compute size of needed storage for encoding
 *
 * This function computes the minimum size of a memory area needed to hold the
 * result of a encoding operation, not including the terminating null character.
 *
 * @param[in]      in_bytes            size of data in bytes
 *
 * @return The minimum amount of size required to hold the data
 */
IOT_API IOT_SECTION size_t iot_base64_encode_size( size_t in_bytes );

#ifdef __cplusplus
}
#endif /* ifdef __cplusplus */

#endif /* ifndef IOT_BASE64_H */