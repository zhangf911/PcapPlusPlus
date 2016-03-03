#ifndef PACKETPP_PACKET_UTILS
#define PACKETPP_PACKET_UTILS

#include "Packet.h"
#include "Macros.h"

/// @file

/**
 * A method that is given a packet and calculates a hash value by the packet's 5-tuple
 * @param[in] packet The packet to calculate hash for
 * @return The hash value calculated for this packet
 */
size_t PCAPPP_EXPORT hash5Tuple(Packet* packet);

#endif /* PACKETPP_PACKET_UTILS */
