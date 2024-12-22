import 'package:better_dart_ip/ip.dart';
import 'package:dart_raw/raw.dart';

void printPacketInfo(List<int> bytes) {
  // Decode packet
  final reader = RawReader.withBytes(bytes);
  final packet = IpPacket.decode(reader);

  // Print some information
  print('Source: ${packet.source}');
  print('Destination: ${packet.destination}');
}
