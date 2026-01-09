import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/relationship_repository_impl.dart';
import '../domain/entities/relationship.dart';
import '../domain/repositories/relationship_repository.dart';

final relationshipRepositoryProvider = Provider<RelationshipRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return RelationshipRepositoryImpl(database);
});

final relationshipsProvider = AsyncNotifierProvider<RelationshipsNotifier, List<Relationship>>(() {
  return RelationshipsNotifier();
});

class RelationshipsNotifier extends AsyncNotifier<List<Relationship>> {
  @override
  Future<List<Relationship>> build() async {
    final repository = ref.read(relationshipRepositoryProvider);
    final result = await repository.getRelationships();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (relationships) => relationships,
    );
  }

  Future<void> addRelationship(Relationship relationship) async {
    final repository = ref.read(relationshipRepositoryProvider);
    final result = await repository.createRelationship(relationship);
    
    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
         state = const AsyncValue.loading();
         ref.invalidateSelf(); 
      },
    );
  }
}
