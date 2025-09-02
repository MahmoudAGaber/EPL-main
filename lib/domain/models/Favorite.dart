import 'package:hive/hive.dart';

part 'Favorite.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type; // 'team' or 'competition'

  @HiveField(3)
  final String? country; // Nullable (Only for competitions)

  FavoriteModel({
    required this.id,
    required this.name,
    required this.type,
    this.country,
  });
}
