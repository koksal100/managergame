import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../domain/services/relationship_rule_service.dart';

final relationshipRuleServiceProvider = Provider<RelationshipRuleService>((
  ref,
) {
  return RelationshipRuleService(ref.watch(appDatabaseProvider));
});
