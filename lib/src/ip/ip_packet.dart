import 'package:better_dart_ip/foundation.dart';
import 'package:better_dart_ip/ip.dart';
import 'package:dart_raw/raw.dart';


/// Superclass of [Ip4Packet] and [Ip6Packet].
abstract class IpPacket<T extends IpAddress> extends Packet {
  /// Source IP address.
  late T source;

  /// Destination IP address.
  late T destination;

  SelfEncoder payload = RawData.empty;

  /// IP version (4 or 6)
  int get ipVersion;

  /// 8-bit encapsulated protocol (e.g. TCP, UDP).
  int get payloadProtocolNumber;

  /// Returns [IPv4Packet] or [IPv6Packet] depending on the initial byte.
  static IpPacket decode(RawReader reader) {
    final version = reader.previewUint8(0) >> 4;
    switch (version) {
      case 4:
        final result = Ip4Packet();
        result.decodeSelf(reader);
        return result;
      case 6:
        final result = Ip6Packet();
        result.decodeSelf(reader);
        return result;
      default:
        throw ArgumentError('Invalid IP version number');
    }
  }
}

abstract class IpPayload extends Packet {
  int get ipProtocolNumber;

  IpPacket? parentPacket;

  IpPacket get _parentPacketOrThrow {
    if (parentPacket == null) {
      throw StateError("'parentPacket' is null");
    }
    return parentPacket!;
  }

  IpAddress get sourceAddress => _parentPacketOrThrow.source;

  set sourceAddress(IpAddress value) {
    _parentPacketOrThrow.source = value;
  }

  IpAddress get destinationAddress => _parentPacketOrThrow.destination;

  set destinationAddress(IpAddress value) {
    _parentPacketOrThrow.destination = value;
  }
}
