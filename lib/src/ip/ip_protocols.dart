import 'package:better_dart_ip/foundation.dart';
import 'package:better_dart_ip/icmp.dart';
import 'package:better_dart_ip/tcp.dart';
import 'package:better_dart_ip/udp.dart';

const Map<int, Protocol> ipProtocolMap = <int, Protocol>{
  ipProtocolIcmp: icmp,
  ipProtocolTcp: tcp,
  ipProtocolUdp: udp,
};

const int ipProtocolIcmp = 1;
const int ipProtocolTcp = 6;
const int ipProtocolUdp = 17;
