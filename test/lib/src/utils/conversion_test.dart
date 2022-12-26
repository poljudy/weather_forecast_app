import 'package:test/test.dart';
import 'package:weather_pack/src/utils/conversion.dart';

void main() {
  group('$SideOfTheWorld', () {
    test('$SideOfTheWorld.fromDegrees()', () async {
      // check on uncorrected data

      expect(
        () => SideOfTheWorld.fromDegrees(-1100.0),
        throwsA(const TypeMatcher<AssertionError>()),
      );

      expect(
        () => SideOfTheWorld.fromDegrees(1100.0),
        throwsA(const TypeMatcher<AssertionError>()),
      );

      expect(
        () => SideOfTheWorld.fromDegrees(361.0),
        throwsA(const TypeMatcher<AssertionError>()),
      );

      expect(
        () => SideOfTheWorld.fromDegrees(360.0000000000001),
        throwsA(const TypeMatcher<AssertionError>()),
      );

      // it's not the expected behavior, when 10^-14 decimal
      expect(
        () => SideOfTheWorld.fromDegrees(360.00000000000001),
        returnsNormally,
      );

      expect(
        () => SideOfTheWorld.fromDegrees(-361.0),
        throwsA(const TypeMatcher<AssertionError>()),
      );

      // north('N', 'North')

      expect(SideOfTheWorld.fromDegrees(0), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(22.5), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(337.5), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(360.0), SideOfTheWorld.north);

      expect(SideOfTheWorld.fromDegrees(359.9), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(337.6), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(18), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(22.49), SideOfTheWorld.north);

      // check northEast('NE', 'North-East')

      expect(SideOfTheWorld.fromDegrees(22.51), SideOfTheWorld.northEast);
      expect(SideOfTheWorld.fromDegrees(67.48), SideOfTheWorld.northEast);
      expect(SideOfTheWorld.fromDegrees(30), SideOfTheWorld.northEast);
      expect(SideOfTheWorld.fromDegrees(50.78), SideOfTheWorld.northEast);

      // east('E', 'East')

      expect(SideOfTheWorld.fromDegrees(67.55), SideOfTheWorld.east);
      expect(SideOfTheWorld.fromDegrees(112.45), SideOfTheWorld.east);
      expect(SideOfTheWorld.fromDegrees(70), SideOfTheWorld.east);
      expect(SideOfTheWorld.fromDegrees(110.78), SideOfTheWorld.east);

      // southEast('SE', 'South-East')

      expect(SideOfTheWorld.fromDegrees(112.51), SideOfTheWorld.southEast);
      expect(SideOfTheWorld.fromDegrees(156.59), SideOfTheWorld.southEast);
      expect(SideOfTheWorld.fromDegrees(130), SideOfTheWorld.southEast);
      expect(SideOfTheWorld.fromDegrees(150.78), SideOfTheWorld.southEast);

      // south('S', 'South')

      expect(SideOfTheWorld.fromDegrees(157.6), SideOfTheWorld.south);
      expect(SideOfTheWorld.fromDegrees(202.4), SideOfTheWorld.south);
      expect(SideOfTheWorld.fromDegrees(180), SideOfTheWorld.south);
      expect(SideOfTheWorld.fromDegrees(201.78), SideOfTheWorld.south);

      // southWest('SW', 'South-West')

      expect(SideOfTheWorld.fromDegrees(202.59), SideOfTheWorld.southWest);
      expect(SideOfTheWorld.fromDegrees(247.4), SideOfTheWorld.southWest);
      expect(SideOfTheWorld.fromDegrees(240), SideOfTheWorld.southWest);
      expect(SideOfTheWorld.fromDegrees(221.78), SideOfTheWorld.southWest);

      // west('W', 'West')

      expect(SideOfTheWorld.fromDegrees(247.6), SideOfTheWorld.west);
      expect(SideOfTheWorld.fromDegrees(292.499), SideOfTheWorld.west);
      expect(SideOfTheWorld.fromDegrees(260), SideOfTheWorld.west);
      expect(SideOfTheWorld.fromDegrees(271.23), SideOfTheWorld.west);

      // northWest('NW', 'North-West')

      expect(SideOfTheWorld.fromDegrees(292.52), SideOfTheWorld.northWest);
      expect(SideOfTheWorld.fromDegrees(337.4), SideOfTheWorld.northWest);
      expect(SideOfTheWorld.fromDegrees(330), SideOfTheWorld.northWest);
      expect(SideOfTheWorld.fromDegrees(298.88), SideOfTheWorld.northWest);

      // edge cases
      expect(SideOfTheWorld.fromDegrees(0.0), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(22.5), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(67.5), SideOfTheWorld.east);
      expect(SideOfTheWorld.fromDegrees(112.5), SideOfTheWorld.east);
      expect(SideOfTheWorld.fromDegrees(157.5), SideOfTheWorld.south);
      expect(SideOfTheWorld.fromDegrees(202.5), SideOfTheWorld.south);
      expect(SideOfTheWorld.fromDegrees(247.5), SideOfTheWorld.west);
      expect(SideOfTheWorld.fromDegrees(292.5), SideOfTheWorld.west);
      expect(SideOfTheWorld.fromDegrees(337.5), SideOfTheWorld.north);
      expect(SideOfTheWorld.fromDegrees(360.0), SideOfTheWorld.north);
    });
  });
}
