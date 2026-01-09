// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LeaguesTable extends Leagues with TableInfo<$LeaguesTable, League> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaguesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryIdMeta = const VerificationMeta(
    'countryId',
  );
  @override
  late final GeneratedColumn<int> countryId = GeneratedColumn<int>(
    'country_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, countryId, reputation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leagues';
  @override
  VerificationContext validateIntegrity(
    Insertable<League> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country_id')) {
      context.handle(
        _countryIdMeta,
        countryId.isAcceptableOrUnknown(data['country_id']!, _countryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_countryIdMeta);
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  League map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return League(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      countryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}country_id'],
      )!,
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
    );
  }

  @override
  $LeaguesTable createAlias(String alias) {
    return $LeaguesTable(attachedDatabase, alias);
  }
}

class League extends DataClass implements Insertable<League> {
  final int id;
  final String name;
  final int countryId;
  final int reputation;
  const League({
    required this.id,
    required this.name,
    required this.countryId,
    required this.reputation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['country_id'] = Variable<int>(countryId);
    map['reputation'] = Variable<int>(reputation);
    return map;
  }

  LeaguesCompanion toCompanion(bool nullToAbsent) {
    return LeaguesCompanion(
      id: Value(id),
      name: Value(name),
      countryId: Value(countryId),
      reputation: Value(reputation),
    );
  }

  factory League.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return League(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryId: serializer.fromJson<int>(json['countryId']),
      reputation: serializer.fromJson<int>(json['reputation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'countryId': serializer.toJson<int>(countryId),
      'reputation': serializer.toJson<int>(reputation),
    };
  }

  League copyWith({int? id, String? name, int? countryId, int? reputation}) =>
      League(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
        reputation: reputation ?? this.reputation,
      );
  League copyWithCompanion(LeaguesCompanion data) {
    return League(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      countryId: data.countryId.present ? data.countryId.value : this.countryId,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('League(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryId: $countryId, ')
          ..write('reputation: $reputation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, countryId, reputation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is League &&
          other.id == this.id &&
          other.name == this.name &&
          other.countryId == this.countryId &&
          other.reputation == this.reputation);
}

class LeaguesCompanion extends UpdateCompanion<League> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> countryId;
  final Value<int> reputation;
  const LeaguesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryId = const Value.absent(),
    this.reputation = const Value.absent(),
  });
  LeaguesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int countryId,
    required int reputation,
  }) : name = Value(name),
       countryId = Value(countryId),
       reputation = Value(reputation);
  static Insertable<League> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? countryId,
    Expression<int>? reputation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (countryId != null) 'country_id': countryId,
      if (reputation != null) 'reputation': reputation,
    });
  }

  LeaguesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? countryId,
    Value<int>? reputation,
  }) {
    return LeaguesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryId: countryId ?? this.countryId,
      reputation: reputation ?? this.reputation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (countryId.present) {
      map['country_id'] = Variable<int>(countryId.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaguesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryId: $countryId, ')
          ..write('reputation: $reputation')
          ..write(')'))
        .toString();
  }
}

class $ClubsTable extends Clubs with TableInfo<$ClubsTable, Club> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClubsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leagueIdMeta = const VerificationMeta(
    'leagueId',
  );
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
    'league_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES leagues (id)',
    ),
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transferBudgetMeta = const VerificationMeta(
    'transferBudget',
  );
  @override
  late final GeneratedColumn<double> transferBudget = GeneratedColumn<double>(
    'transfer_budget',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageBudgetMeta = const VerificationMeta(
    'wageBudget',
  );
  @override
  late final GeneratedColumn<double> wageBudget = GeneratedColumn<double>(
    'wage_budget',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    leagueId,
    reputation,
    transferBudget,
    wageBudget,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clubs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Club> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('league_id')) {
      context.handle(
        _leagueIdMeta,
        leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta),
      );
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    if (data.containsKey('transfer_budget')) {
      context.handle(
        _transferBudgetMeta,
        transferBudget.isAcceptableOrUnknown(
          data['transfer_budget']!,
          _transferBudgetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transferBudgetMeta);
    }
    if (data.containsKey('wage_budget')) {
      context.handle(
        _wageBudgetMeta,
        wageBudget.isAcceptableOrUnknown(data['wage_budget']!, _wageBudgetMeta),
      );
    } else if (isInserting) {
      context.missing(_wageBudgetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Club map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Club(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      leagueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}league_id'],
      ),
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
      transferBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}transfer_budget'],
      )!,
      wageBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wage_budget'],
      )!,
    );
  }

  @override
  $ClubsTable createAlias(String alias) {
    return $ClubsTable(attachedDatabase, alias);
  }
}

class Club extends DataClass implements Insertable<Club> {
  final int id;
  final String name;
  final int? leagueId;
  final int reputation;
  final double transferBudget;
  final double wageBudget;
  const Club({
    required this.id,
    required this.name,
    this.leagueId,
    required this.reputation,
    required this.transferBudget,
    required this.wageBudget,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || leagueId != null) {
      map['league_id'] = Variable<int>(leagueId);
    }
    map['reputation'] = Variable<int>(reputation);
    map['transfer_budget'] = Variable<double>(transferBudget);
    map['wage_budget'] = Variable<double>(wageBudget);
    return map;
  }

  ClubsCompanion toCompanion(bool nullToAbsent) {
    return ClubsCompanion(
      id: Value(id),
      name: Value(name),
      leagueId: leagueId == null && nullToAbsent
          ? const Value.absent()
          : Value(leagueId),
      reputation: Value(reputation),
      transferBudget: Value(transferBudget),
      wageBudget: Value(wageBudget),
    );
  }

  factory Club.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Club(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      leagueId: serializer.fromJson<int?>(json['leagueId']),
      reputation: serializer.fromJson<int>(json['reputation']),
      transferBudget: serializer.fromJson<double>(json['transferBudget']),
      wageBudget: serializer.fromJson<double>(json['wageBudget']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'leagueId': serializer.toJson<int?>(leagueId),
      'reputation': serializer.toJson<int>(reputation),
      'transferBudget': serializer.toJson<double>(transferBudget),
      'wageBudget': serializer.toJson<double>(wageBudget),
    };
  }

  Club copyWith({
    int? id,
    String? name,
    Value<int?> leagueId = const Value.absent(),
    int? reputation,
    double? transferBudget,
    double? wageBudget,
  }) => Club(
    id: id ?? this.id,
    name: name ?? this.name,
    leagueId: leagueId.present ? leagueId.value : this.leagueId,
    reputation: reputation ?? this.reputation,
    transferBudget: transferBudget ?? this.transferBudget,
    wageBudget: wageBudget ?? this.wageBudget,
  );
  Club copyWithCompanion(ClubsCompanion data) {
    return Club(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
      transferBudget: data.transferBudget.present
          ? data.transferBudget.value
          : this.transferBudget,
      wageBudget: data.wageBudget.present
          ? data.wageBudget.value
          : this.wageBudget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Club(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('leagueId: $leagueId, ')
          ..write('reputation: $reputation, ')
          ..write('transferBudget: $transferBudget, ')
          ..write('wageBudget: $wageBudget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, leagueId, reputation, transferBudget, wageBudget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Club &&
          other.id == this.id &&
          other.name == this.name &&
          other.leagueId == this.leagueId &&
          other.reputation == this.reputation &&
          other.transferBudget == this.transferBudget &&
          other.wageBudget == this.wageBudget);
}

class ClubsCompanion extends UpdateCompanion<Club> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> leagueId;
  final Value<int> reputation;
  final Value<double> transferBudget;
  final Value<double> wageBudget;
  const ClubsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.reputation = const Value.absent(),
    this.transferBudget = const Value.absent(),
    this.wageBudget = const Value.absent(),
  });
  ClubsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.leagueId = const Value.absent(),
    required int reputation,
    required double transferBudget,
    required double wageBudget,
  }) : name = Value(name),
       reputation = Value(reputation),
       transferBudget = Value(transferBudget),
       wageBudget = Value(wageBudget);
  static Insertable<Club> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? leagueId,
    Expression<int>? reputation,
    Expression<double>? transferBudget,
    Expression<double>? wageBudget,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (leagueId != null) 'league_id': leagueId,
      if (reputation != null) 'reputation': reputation,
      if (transferBudget != null) 'transfer_budget': transferBudget,
      if (wageBudget != null) 'wage_budget': wageBudget,
    });
  }

  ClubsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? leagueId,
    Value<int>? reputation,
    Value<double>? transferBudget,
    Value<double>? wageBudget,
  }) {
    return ClubsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      leagueId: leagueId ?? this.leagueId,
      reputation: reputation ?? this.reputation,
      transferBudget: transferBudget ?? this.transferBudget,
      wageBudget: wageBudget ?? this.wageBudget,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    if (transferBudget.present) {
      map['transfer_budget'] = Variable<double>(transferBudget.value);
    }
    if (wageBudget.present) {
      map['wage_budget'] = Variable<double>(wageBudget.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClubsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('leagueId: $leagueId, ')
          ..write('reputation: $reputation, ')
          ..write('transferBudget: $transferBudget, ')
          ..write('wageBudget: $wageBudget')
          ..write(')'))
        .toString();
  }
}

class $AgentsTable extends Agents with TableInfo<$AgentsTable, Agent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _negotiationSkillMeta = const VerificationMeta(
    'negotiationSkill',
  );
  @override
  late final GeneratedColumn<int> negotiationSkill = GeneratedColumn<int>(
    'negotiation_skill',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoutingSkillMeta = const VerificationMeta(
    'scoutingSkill',
  );
  @override
  late final GeneratedColumn<int> scoutingSkill = GeneratedColumn<int>(
    'scouting_skill',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    balance,
    reputation,
    negotiationSkill,
    scoutingSkill,
    level,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Agent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    if (data.containsKey('negotiation_skill')) {
      context.handle(
        _negotiationSkillMeta,
        negotiationSkill.isAcceptableOrUnknown(
          data['negotiation_skill']!,
          _negotiationSkillMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_negotiationSkillMeta);
    }
    if (data.containsKey('scouting_skill')) {
      context.handle(
        _scoutingSkillMeta,
        scoutingSkill.isAcceptableOrUnknown(
          data['scouting_skill']!,
          _scoutingSkillMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scoutingSkillMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Agent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Agent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
      negotiationSkill: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}negotiation_skill'],
      )!,
      scoutingSkill: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scouting_skill'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $AgentsTable createAlias(String alias) {
    return $AgentsTable(attachedDatabase, alias);
  }
}

class Agent extends DataClass implements Insertable<Agent> {
  final int id;
  final String name;
  final double balance;
  final int reputation;
  final int negotiationSkill;
  final int scoutingSkill;
  final int level;
  const Agent({
    required this.id,
    required this.name,
    required this.balance,
    required this.reputation,
    required this.negotiationSkill,
    required this.scoutingSkill,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['balance'] = Variable<double>(balance);
    map['reputation'] = Variable<int>(reputation);
    map['negotiation_skill'] = Variable<int>(negotiationSkill);
    map['scouting_skill'] = Variable<int>(scoutingSkill);
    map['level'] = Variable<int>(level);
    return map;
  }

  AgentsCompanion toCompanion(bool nullToAbsent) {
    return AgentsCompanion(
      id: Value(id),
      name: Value(name),
      balance: Value(balance),
      reputation: Value(reputation),
      negotiationSkill: Value(negotiationSkill),
      scoutingSkill: Value(scoutingSkill),
      level: Value(level),
    );
  }

  factory Agent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Agent(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      balance: serializer.fromJson<double>(json['balance']),
      reputation: serializer.fromJson<int>(json['reputation']),
      negotiationSkill: serializer.fromJson<int>(json['negotiationSkill']),
      scoutingSkill: serializer.fromJson<int>(json['scoutingSkill']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'balance': serializer.toJson<double>(balance),
      'reputation': serializer.toJson<int>(reputation),
      'negotiationSkill': serializer.toJson<int>(negotiationSkill),
      'scoutingSkill': serializer.toJson<int>(scoutingSkill),
      'level': serializer.toJson<int>(level),
    };
  }

  Agent copyWith({
    int? id,
    String? name,
    double? balance,
    int? reputation,
    int? negotiationSkill,
    int? scoutingSkill,
    int? level,
  }) => Agent(
    id: id ?? this.id,
    name: name ?? this.name,
    balance: balance ?? this.balance,
    reputation: reputation ?? this.reputation,
    negotiationSkill: negotiationSkill ?? this.negotiationSkill,
    scoutingSkill: scoutingSkill ?? this.scoutingSkill,
    level: level ?? this.level,
  );
  Agent copyWithCompanion(AgentsCompanion data) {
    return Agent(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      balance: data.balance.present ? data.balance.value : this.balance,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
      negotiationSkill: data.negotiationSkill.present
          ? data.negotiationSkill.value
          : this.negotiationSkill,
      scoutingSkill: data.scoutingSkill.present
          ? data.scoutingSkill.value
          : this.scoutingSkill,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Agent(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('reputation: $reputation, ')
          ..write('negotiationSkill: $negotiationSkill, ')
          ..write('scoutingSkill: $scoutingSkill, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    balance,
    reputation,
    negotiationSkill,
    scoutingSkill,
    level,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Agent &&
          other.id == this.id &&
          other.name == this.name &&
          other.balance == this.balance &&
          other.reputation == this.reputation &&
          other.negotiationSkill == this.negotiationSkill &&
          other.scoutingSkill == this.scoutingSkill &&
          other.level == this.level);
}

class AgentsCompanion extends UpdateCompanion<Agent> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> balance;
  final Value<int> reputation;
  final Value<int> negotiationSkill;
  final Value<int> scoutingSkill;
  final Value<int> level;
  const AgentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.balance = const Value.absent(),
    this.reputation = const Value.absent(),
    this.negotiationSkill = const Value.absent(),
    this.scoutingSkill = const Value.absent(),
    this.level = const Value.absent(),
  });
  AgentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double balance,
    required int reputation,
    required int negotiationSkill,
    required int scoutingSkill,
    required int level,
  }) : name = Value(name),
       balance = Value(balance),
       reputation = Value(reputation),
       negotiationSkill = Value(negotiationSkill),
       scoutingSkill = Value(scoutingSkill),
       level = Value(level);
  static Insertable<Agent> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? balance,
    Expression<int>? reputation,
    Expression<int>? negotiationSkill,
    Expression<int>? scoutingSkill,
    Expression<int>? level,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (balance != null) 'balance': balance,
      if (reputation != null) 'reputation': reputation,
      if (negotiationSkill != null) 'negotiation_skill': negotiationSkill,
      if (scoutingSkill != null) 'scouting_skill': scoutingSkill,
      if (level != null) 'level': level,
    });
  }

  AgentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? balance,
    Value<int>? reputation,
    Value<int>? negotiationSkill,
    Value<int>? scoutingSkill,
    Value<int>? level,
  }) {
    return AgentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      reputation: reputation ?? this.reputation,
      negotiationSkill: negotiationSkill ?? this.negotiationSkill,
      scoutingSkill: scoutingSkill ?? this.scoutingSkill,
      level: level ?? this.level,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    if (negotiationSkill.present) {
      map['negotiation_skill'] = Variable<int>(negotiationSkill.value);
    }
    if (scoutingSkill.present) {
      map['scouting_skill'] = Variable<int>(scoutingSkill.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('balance: $balance, ')
          ..write('reputation: $reputation, ')
          ..write('negotiationSkill: $negotiationSkill, ')
          ..write('scoutingSkill: $scoutingSkill, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }
}

class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agentIdMeta = const VerificationMeta(
    'agentId',
  );
  @override
  late final GeneratedColumn<int> agentId = GeneratedColumn<int>(
    'agent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES agents (id)',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageMeta = const VerificationMeta('wage');
  @override
  late final GeneratedColumn<double> wage = GeneratedColumn<double>(
    'wage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releaseClauseMeta = const VerificationMeta(
    'releaseClause',
  );
  @override
  late final GeneratedColumn<double> releaseClause = GeneratedColumn<double>(
    'release_clause',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    agentId,
    startDate,
    endDate,
    wage,
    releaseClause,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('agent_id')) {
      context.handle(
        _agentIdMeta,
        agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('wage')) {
      context.handle(
        _wageMeta,
        wage.isAcceptableOrUnknown(data['wage']!, _wageMeta),
      );
    } else if (isInserting) {
      context.missing(_wageMeta);
    }
    if (data.containsKey('release_clause')) {
      context.handle(
        _releaseClauseMeta,
        releaseClause.isAcceptableOrUnknown(
          data['release_clause']!,
          _releaseClauseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releaseClauseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      agentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agent_id'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      wage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wage'],
      )!,
      releaseClause: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}release_clause'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final int id;
  final int playerId;
  final int? agentId;
  final DateTime startDate;
  final DateTime endDate;
  final double wage;
  final double releaseClause;
  final String status;
  const Contract({
    required this.id,
    required this.playerId,
    this.agentId,
    required this.startDate,
    required this.endDate,
    required this.wage,
    required this.releaseClause,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<int>(agentId);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['wage'] = Variable<double>(wage);
    map['release_clause'] = Variable<double>(releaseClause);
    map['status'] = Variable<String>(status);
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      startDate: Value(startDate),
      endDate: Value(endDate),
      wage: Value(wage),
      releaseClause: Value(releaseClause),
      status: Value(status),
    );
  }

  factory Contract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      agentId: serializer.fromJson<int?>(json['agentId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      wage: serializer.fromJson<double>(json['wage']),
      releaseClause: serializer.fromJson<double>(json['releaseClause']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'agentId': serializer.toJson<int?>(agentId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'wage': serializer.toJson<double>(wage),
      'releaseClause': serializer.toJson<double>(releaseClause),
      'status': serializer.toJson<String>(status),
    };
  }

  Contract copyWith({
    int? id,
    int? playerId,
    Value<int?> agentId = const Value.absent(),
    DateTime? startDate,
    DateTime? endDate,
    double? wage,
    double? releaseClause,
    String? status,
  }) => Contract(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    agentId: agentId.present ? agentId.value : this.agentId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    wage: wage ?? this.wage,
    releaseClause: releaseClause ?? this.releaseClause,
    status: status ?? this.status,
  );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      wage: data.wage.present ? data.wage.value : this.wage,
      releaseClause: data.releaseClause.present
          ? data.releaseClause.value
          : this.releaseClause,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('agentId: $agentId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('wage: $wage, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    agentId,
    startDate,
    endDate,
    wage,
    releaseClause,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.agentId == this.agentId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.wage == this.wage &&
          other.releaseClause == this.releaseClause &&
          other.status == this.status);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int?> agentId;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<double> wage;
  final Value<double> releaseClause;
  final Value<String> status;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.agentId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.wage = const Value.absent(),
    this.releaseClause = const Value.absent(),
    this.status = const Value.absent(),
  });
  ContractsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    this.agentId = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    required double wage,
    required double releaseClause,
    required String status,
  }) : playerId = Value(playerId),
       startDate = Value(startDate),
       endDate = Value(endDate),
       wage = Value(wage),
       releaseClause = Value(releaseClause),
       status = Value(status);
  static Insertable<Contract> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? agentId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<double>? wage,
    Expression<double>? releaseClause,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (agentId != null) 'agent_id': agentId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (wage != null) 'wage': wage,
      if (releaseClause != null) 'release_clause': releaseClause,
      if (status != null) 'status': status,
    });
  }

  ContractsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int?>? agentId,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<double>? wage,
    Value<double>? releaseClause,
    Value<String>? status,
  }) {
    return ContractsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      agentId: agentId ?? this.agentId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      wage: wage ?? this.wage,
      releaseClause: releaseClause ?? this.releaseClause,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<int>(agentId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (wage.present) {
      map['wage'] = Variable<double>(wage.value);
    }
    if (releaseClause.present) {
      map['release_clause'] = Variable<double>(releaseClause.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('agentId: $agentId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('wage: $wage, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clubIdMeta = const VerificationMeta('clubId');
  @override
  late final GeneratedColumn<int> clubId = GeneratedColumn<int>(
    'club_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
  );
  static const VerificationMeta _agentIdMeta = const VerificationMeta(
    'agentId',
  );
  @override
  late final GeneratedColumn<int> agentId = GeneratedColumn<int>(
    'agent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES agents (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caMeta = const VerificationMeta('ca');
  @override
  late final GeneratedColumn<int> ca = GeneratedColumn<int>(
    'ca',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paMeta = const VerificationMeta('pa');
  @override
  late final GeneratedColumn<int> pa = GeneratedColumn<int>(
    'pa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketValueMeta = const VerificationMeta(
    'marketValue',
  );
  @override
  late final GeneratedColumn<int> marketValue = GeneratedColumn<int>(
    'market_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentContractIdMeta = const VerificationMeta(
    'currentContractId',
  );
  @override
  late final GeneratedColumn<int> currentContractId = GeneratedColumn<int>(
    'current_contract_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contracts (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    age,
    clubId,
    agentId,
    position,
    ca,
    pa,
    reputation,
    marketValue,
    currentContractId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('club_id')) {
      context.handle(
        _clubIdMeta,
        clubId.isAcceptableOrUnknown(data['club_id']!, _clubIdMeta),
      );
    }
    if (data.containsKey('agent_id')) {
      context.handle(
        _agentIdMeta,
        agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('ca')) {
      context.handle(_caMeta, ca.isAcceptableOrUnknown(data['ca']!, _caMeta));
    } else if (isInserting) {
      context.missing(_caMeta);
    }
    if (data.containsKey('pa')) {
      context.handle(_paMeta, pa.isAcceptableOrUnknown(data['pa']!, _paMeta));
    } else if (isInserting) {
      context.missing(_paMeta);
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    if (data.containsKey('market_value')) {
      context.handle(
        _marketValueMeta,
        marketValue.isAcceptableOrUnknown(
          data['market_value']!,
          _marketValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_marketValueMeta);
    }
    if (data.containsKey('current_contract_id')) {
      context.handle(
        _currentContractIdMeta,
        currentContractId.isAcceptableOrUnknown(
          data['current_contract_id']!,
          _currentContractIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      clubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}club_id'],
      ),
      agentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agent_id'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      ca: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ca'],
      )!,
      pa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pa'],
      )!,
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
      marketValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}market_value'],
      )!,
      currentContractId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_contract_id'],
      ),
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final int age;
  final int? clubId;
  final int? agentId;
  final String position;
  final int ca;
  final int pa;
  final int reputation;
  final int marketValue;
  final int? currentContractId;
  const Player({
    required this.id,
    required this.name,
    required this.age,
    this.clubId,
    this.agentId,
    required this.position,
    required this.ca,
    required this.pa,
    required this.reputation,
    required this.marketValue,
    this.currentContractId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['age'] = Variable<int>(age);
    if (!nullToAbsent || clubId != null) {
      map['club_id'] = Variable<int>(clubId);
    }
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<int>(agentId);
    }
    map['position'] = Variable<String>(position);
    map['ca'] = Variable<int>(ca);
    map['pa'] = Variable<int>(pa);
    map['reputation'] = Variable<int>(reputation);
    map['market_value'] = Variable<int>(marketValue);
    if (!nullToAbsent || currentContractId != null) {
      map['current_contract_id'] = Variable<int>(currentContractId);
    }
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      age: Value(age),
      clubId: clubId == null && nullToAbsent
          ? const Value.absent()
          : Value(clubId),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      position: Value(position),
      ca: Value(ca),
      pa: Value(pa),
      reputation: Value(reputation),
      marketValue: Value(marketValue),
      currentContractId: currentContractId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentContractId),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int>(json['age']),
      clubId: serializer.fromJson<int?>(json['clubId']),
      agentId: serializer.fromJson<int?>(json['agentId']),
      position: serializer.fromJson<String>(json['position']),
      ca: serializer.fromJson<int>(json['ca']),
      pa: serializer.fromJson<int>(json['pa']),
      reputation: serializer.fromJson<int>(json['reputation']),
      marketValue: serializer.fromJson<int>(json['marketValue']),
      currentContractId: serializer.fromJson<int?>(json['currentContractId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int>(age),
      'clubId': serializer.toJson<int?>(clubId),
      'agentId': serializer.toJson<int?>(agentId),
      'position': serializer.toJson<String>(position),
      'ca': serializer.toJson<int>(ca),
      'pa': serializer.toJson<int>(pa),
      'reputation': serializer.toJson<int>(reputation),
      'marketValue': serializer.toJson<int>(marketValue),
      'currentContractId': serializer.toJson<int?>(currentContractId),
    };
  }

  Player copyWith({
    int? id,
    String? name,
    int? age,
    Value<int?> clubId = const Value.absent(),
    Value<int?> agentId = const Value.absent(),
    String? position,
    int? ca,
    int? pa,
    int? reputation,
    int? marketValue,
    Value<int?> currentContractId = const Value.absent(),
  }) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    age: age ?? this.age,
    clubId: clubId.present ? clubId.value : this.clubId,
    agentId: agentId.present ? agentId.value : this.agentId,
    position: position ?? this.position,
    ca: ca ?? this.ca,
    pa: pa ?? this.pa,
    reputation: reputation ?? this.reputation,
    marketValue: marketValue ?? this.marketValue,
    currentContractId: currentContractId.present
        ? currentContractId.value
        : this.currentContractId,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      clubId: data.clubId.present ? data.clubId.value : this.clubId,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      position: data.position.present ? data.position.value : this.position,
      ca: data.ca.present ? data.ca.value : this.ca,
      pa: data.pa.present ? data.pa.value : this.pa,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
      marketValue: data.marketValue.present
          ? data.marketValue.value
          : this.marketValue,
      currentContractId: data.currentContractId.present
          ? data.currentContractId.value
          : this.currentContractId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('clubId: $clubId, ')
          ..write('agentId: $agentId, ')
          ..write('position: $position, ')
          ..write('ca: $ca, ')
          ..write('pa: $pa, ')
          ..write('reputation: $reputation, ')
          ..write('marketValue: $marketValue, ')
          ..write('currentContractId: $currentContractId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    age,
    clubId,
    agentId,
    position,
    ca,
    pa,
    reputation,
    marketValue,
    currentContractId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age &&
          other.clubId == this.clubId &&
          other.agentId == this.agentId &&
          other.position == this.position &&
          other.ca == this.ca &&
          other.pa == this.pa &&
          other.reputation == this.reputation &&
          other.marketValue == this.marketValue &&
          other.currentContractId == this.currentContractId);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> age;
  final Value<int?> clubId;
  final Value<int?> agentId;
  final Value<String> position;
  final Value<int> ca;
  final Value<int> pa;
  final Value<int> reputation;
  final Value<int> marketValue;
  final Value<int?> currentContractId;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.clubId = const Value.absent(),
    this.agentId = const Value.absent(),
    this.position = const Value.absent(),
    this.ca = const Value.absent(),
    this.pa = const Value.absent(),
    this.reputation = const Value.absent(),
    this.marketValue = const Value.absent(),
    this.currentContractId = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int age,
    this.clubId = const Value.absent(),
    this.agentId = const Value.absent(),
    required String position,
    required int ca,
    required int pa,
    required int reputation,
    required int marketValue,
    this.currentContractId = const Value.absent(),
  }) : name = Value(name),
       age = Value(age),
       position = Value(position),
       ca = Value(ca),
       pa = Value(pa),
       reputation = Value(reputation),
       marketValue = Value(marketValue);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? age,
    Expression<int>? clubId,
    Expression<int>? agentId,
    Expression<String>? position,
    Expression<int>? ca,
    Expression<int>? pa,
    Expression<int>? reputation,
    Expression<int>? marketValue,
    Expression<int>? currentContractId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (clubId != null) 'club_id': clubId,
      if (agentId != null) 'agent_id': agentId,
      if (position != null) 'position': position,
      if (ca != null) 'ca': ca,
      if (pa != null) 'pa': pa,
      if (reputation != null) 'reputation': reputation,
      if (marketValue != null) 'market_value': marketValue,
      if (currentContractId != null) 'current_contract_id': currentContractId,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? age,
    Value<int?>? clubId,
    Value<int?>? agentId,
    Value<String>? position,
    Value<int>? ca,
    Value<int>? pa,
    Value<int>? reputation,
    Value<int>? marketValue,
    Value<int?>? currentContractId,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      clubId: clubId ?? this.clubId,
      agentId: agentId ?? this.agentId,
      position: position ?? this.position,
      ca: ca ?? this.ca,
      pa: pa ?? this.pa,
      reputation: reputation ?? this.reputation,
      marketValue: marketValue ?? this.marketValue,
      currentContractId: currentContractId ?? this.currentContractId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (clubId.present) {
      map['club_id'] = Variable<int>(clubId.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<int>(agentId.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (ca.present) {
      map['ca'] = Variable<int>(ca.value);
    }
    if (pa.present) {
      map['pa'] = Variable<int>(pa.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    if (marketValue.present) {
      map['market_value'] = Variable<int>(marketValue.value);
    }
    if (currentContractId.present) {
      map['current_contract_id'] = Variable<int>(currentContractId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('clubId: $clubId, ')
          ..write('agentId: $agentId, ')
          ..write('position: $position, ')
          ..write('ca: $ca, ')
          ..write('pa: $pa, ')
          ..write('reputation: $reputation, ')
          ..write('marketValue: $marketValue, ')
          ..write('currentContractId: $currentContractId')
          ..write(')'))
        .toString();
  }
}

class $TransfersTable extends Transfers
    with TableInfo<$TransfersTable, Transfer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _fromClubIdMeta = const VerificationMeta(
    'fromClubId',
  );
  @override
  late final GeneratedColumn<int> fromClubId = GeneratedColumn<int>(
    'from_club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
  );
  static const VerificationMeta _toClubIdMeta = const VerificationMeta(
    'toClubId',
  );
  @override
  late final GeneratedColumn<int> toClubId = GeneratedColumn<int>(
    'to_club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feeAmountMeta = const VerificationMeta(
    'feeAmount',
  );
  @override
  late final GeneratedColumn<double> feeAmount = GeneratedColumn<double>(
    'fee_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    fromClubId,
    toClubId,
    date,
    feeAmount,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transfer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('from_club_id')) {
      context.handle(
        _fromClubIdMeta,
        fromClubId.isAcceptableOrUnknown(
          data['from_club_id']!,
          _fromClubIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromClubIdMeta);
    }
    if (data.containsKey('to_club_id')) {
      context.handle(
        _toClubIdMeta,
        toClubId.isAcceptableOrUnknown(data['to_club_id']!, _toClubIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toClubIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fee_amount')) {
      context.handle(
        _feeAmountMeta,
        feeAmount.isAcceptableOrUnknown(data['fee_amount']!, _feeAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_feeAmountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transfer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transfer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      fromClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_club_id'],
      )!,
      toClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_club_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      feeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fee_amount'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $TransfersTable createAlias(String alias) {
    return $TransfersTable(attachedDatabase, alias);
  }
}

class Transfer extends DataClass implements Insertable<Transfer> {
  final int id;
  final int playerId;
  final int fromClubId;
  final int toClubId;
  final DateTime date;
  final double feeAmount;
  final String type;
  const Transfer({
    required this.id,
    required this.playerId,
    required this.fromClubId,
    required this.toClubId,
    required this.date,
    required this.feeAmount,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['from_club_id'] = Variable<int>(fromClubId);
    map['to_club_id'] = Variable<int>(toClubId);
    map['date'] = Variable<DateTime>(date);
    map['fee_amount'] = Variable<double>(feeAmount);
    map['type'] = Variable<String>(type);
    return map;
  }

  TransfersCompanion toCompanion(bool nullToAbsent) {
    return TransfersCompanion(
      id: Value(id),
      playerId: Value(playerId),
      fromClubId: Value(fromClubId),
      toClubId: Value(toClubId),
      date: Value(date),
      feeAmount: Value(feeAmount),
      type: Value(type),
    );
  }

  factory Transfer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transfer(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      fromClubId: serializer.fromJson<int>(json['fromClubId']),
      toClubId: serializer.fromJson<int>(json['toClubId']),
      date: serializer.fromJson<DateTime>(json['date']),
      feeAmount: serializer.fromJson<double>(json['feeAmount']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'fromClubId': serializer.toJson<int>(fromClubId),
      'toClubId': serializer.toJson<int>(toClubId),
      'date': serializer.toJson<DateTime>(date),
      'feeAmount': serializer.toJson<double>(feeAmount),
      'type': serializer.toJson<String>(type),
    };
  }

  Transfer copyWith({
    int? id,
    int? playerId,
    int? fromClubId,
    int? toClubId,
    DateTime? date,
    double? feeAmount,
    String? type,
  }) => Transfer(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    fromClubId: fromClubId ?? this.fromClubId,
    toClubId: toClubId ?? this.toClubId,
    date: date ?? this.date,
    feeAmount: feeAmount ?? this.feeAmount,
    type: type ?? this.type,
  );
  Transfer copyWithCompanion(TransfersCompanion data) {
    return Transfer(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      fromClubId: data.fromClubId.present
          ? data.fromClubId.value
          : this.fromClubId,
      toClubId: data.toClubId.present ? data.toClubId.value : this.toClubId,
      date: data.date.present ? data.date.value : this.date,
      feeAmount: data.feeAmount.present ? data.feeAmount.value : this.feeAmount,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transfer(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('fromClubId: $fromClubId, ')
          ..write('toClubId: $toClubId, ')
          ..write('date: $date, ')
          ..write('feeAmount: $feeAmount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playerId, fromClubId, toClubId, date, feeAmount, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transfer &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.fromClubId == this.fromClubId &&
          other.toClubId == this.toClubId &&
          other.date == this.date &&
          other.feeAmount == this.feeAmount &&
          other.type == this.type);
}

class TransfersCompanion extends UpdateCompanion<Transfer> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> fromClubId;
  final Value<int> toClubId;
  final Value<DateTime> date;
  final Value<double> feeAmount;
  final Value<String> type;
  const TransfersCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.fromClubId = const Value.absent(),
    this.toClubId = const Value.absent(),
    this.date = const Value.absent(),
    this.feeAmount = const Value.absent(),
    this.type = const Value.absent(),
  });
  TransfersCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required int fromClubId,
    required int toClubId,
    required DateTime date,
    required double feeAmount,
    required String type,
  }) : playerId = Value(playerId),
       fromClubId = Value(fromClubId),
       toClubId = Value(toClubId),
       date = Value(date),
       feeAmount = Value(feeAmount),
       type = Value(type);
  static Insertable<Transfer> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<int>? fromClubId,
    Expression<int>? toClubId,
    Expression<DateTime>? date,
    Expression<double>? feeAmount,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (fromClubId != null) 'from_club_id': fromClubId,
      if (toClubId != null) 'to_club_id': toClubId,
      if (date != null) 'date': date,
      if (feeAmount != null) 'fee_amount': feeAmount,
      if (type != null) 'type': type,
    });
  }

  TransfersCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<int>? fromClubId,
    Value<int>? toClubId,
    Value<DateTime>? date,
    Value<double>? feeAmount,
    Value<String>? type,
  }) {
    return TransfersCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      fromClubId: fromClubId ?? this.fromClubId,
      toClubId: toClubId ?? this.toClubId,
      date: date ?? this.date,
      feeAmount: feeAmount ?? this.feeAmount,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (fromClubId.present) {
      map['from_club_id'] = Variable<int>(fromClubId.value);
    }
    if (toClubId.present) {
      map['to_club_id'] = Variable<int>(toClubId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (feeAmount.present) {
      map['fee_amount'] = Variable<double>(feeAmount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransfersCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('fromClubId: $fromClubId, ')
          ..write('toClubId: $toClubId, ')
          ..write('date: $date, ')
          ..write('feeAmount: $feeAmount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $ValueHistoriesTable extends ValueHistories
    with TableInfo<$ValueHistoriesTable, ValueHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ValueHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, playerId, date, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'value_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ValueHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ValueHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ValueHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $ValueHistoriesTable createAlias(String alias) {
    return $ValueHistoriesTable(attachedDatabase, alias);
  }
}

class ValueHistory extends DataClass implements Insertable<ValueHistory> {
  final int id;
  final int playerId;
  final DateTime date;
  final double value;
  const ValueHistory({
    required this.id,
    required this.playerId,
    required this.date,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['date'] = Variable<DateTime>(date);
    map['value'] = Variable<double>(value);
    return map;
  }

  ValueHistoriesCompanion toCompanion(bool nullToAbsent) {
    return ValueHistoriesCompanion(
      id: Value(id),
      playerId: Value(playerId),
      date: Value(date),
      value: Value(value),
    );
  }

  factory ValueHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ValueHistory(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      date: serializer.fromJson<DateTime>(json['date']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'date': serializer.toJson<DateTime>(date),
      'value': serializer.toJson<double>(value),
    };
  }

  ValueHistory copyWith({
    int? id,
    int? playerId,
    DateTime? date,
    double? value,
  }) => ValueHistory(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    date: date ?? this.date,
    value: value ?? this.value,
  );
  ValueHistory copyWithCompanion(ValueHistoriesCompanion data) {
    return ValueHistory(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      date: data.date.present ? data.date.value : this.date,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ValueHistory(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('date: $date, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerId, date, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ValueHistory &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.date == this.date &&
          other.value == this.value);
}

class ValueHistoriesCompanion extends UpdateCompanion<ValueHistory> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<DateTime> date;
  final Value<double> value;
  const ValueHistoriesCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.date = const Value.absent(),
    this.value = const Value.absent(),
  });
  ValueHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required DateTime date,
    required double value,
  }) : playerId = Value(playerId),
       date = Value(date),
       value = Value(value);
  static Insertable<ValueHistory> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<DateTime>? date,
    Expression<double>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (date != null) 'date': date,
      if (value != null) 'value': value,
    });
  }

  ValueHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<DateTime>? date,
    Value<double>? value,
  }) {
    return ValueHistoriesCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ValueHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('date: $date, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $RelationshipsTable extends Relationships
    with TableInfo<$RelationshipsTable, Relationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fromIdMeta = const VerificationMeta('fromId');
  @override
  late final GeneratedColumn<int> fromId = GeneratedColumn<int>(
    'from_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toIdMeta = const VerificationMeta('toId');
  @override
  late final GeneratedColumn<int> toId = GeneratedColumn<int>(
    'to_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromTypeMeta = const VerificationMeta(
    'fromType',
  );
  @override
  late final GeneratedColumn<String> fromType = GeneratedColumn<String>(
    'from_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toTypeMeta = const VerificationMeta('toType');
  @override
  late final GeneratedColumn<String> toType = GeneratedColumn<String>(
    'to_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromId,
    toId,
    fromType,
    toType,
    score,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(
    Insertable<Relationship> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_id')) {
      context.handle(
        _fromIdMeta,
        fromId.isAcceptableOrUnknown(data['from_id']!, _fromIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fromIdMeta);
    }
    if (data.containsKey('to_id')) {
      context.handle(
        _toIdMeta,
        toId.isAcceptableOrUnknown(data['to_id']!, _toIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toIdMeta);
    }
    if (data.containsKey('from_type')) {
      context.handle(
        _fromTypeMeta,
        fromType.isAcceptableOrUnknown(data['from_type']!, _fromTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fromTypeMeta);
    }
    if (data.containsKey('to_type')) {
      context.handle(
        _toTypeMeta,
        toType.isAcceptableOrUnknown(data['to_type']!, _toTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_toTypeMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Relationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Relationship(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_id'],
      )!,
      toId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_id'],
      )!,
      fromType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_type'],
      )!,
      toType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_type'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
    );
  }

  @override
  $RelationshipsTable createAlias(String alias) {
    return $RelationshipsTable(attachedDatabase, alias);
  }
}

class Relationship extends DataClass implements Insertable<Relationship> {
  final int id;
  final int fromId;
  final int toId;
  final String fromType;
  final String toType;
  final int score;
  const Relationship({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.fromType,
    required this.toType,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_id'] = Variable<int>(fromId);
    map['to_id'] = Variable<int>(toId);
    map['from_type'] = Variable<String>(fromType);
    map['to_type'] = Variable<String>(toType);
    map['score'] = Variable<int>(score);
    return map;
  }

  RelationshipsCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsCompanion(
      id: Value(id),
      fromId: Value(fromId),
      toId: Value(toId),
      fromType: Value(fromType),
      toType: Value(toType),
      score: Value(score),
    );
  }

  factory Relationship.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relationship(
      id: serializer.fromJson<int>(json['id']),
      fromId: serializer.fromJson<int>(json['fromId']),
      toId: serializer.fromJson<int>(json['toId']),
      fromType: serializer.fromJson<String>(json['fromType']),
      toType: serializer.fromJson<String>(json['toType']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromId': serializer.toJson<int>(fromId),
      'toId': serializer.toJson<int>(toId),
      'fromType': serializer.toJson<String>(fromType),
      'toType': serializer.toJson<String>(toType),
      'score': serializer.toJson<int>(score),
    };
  }

  Relationship copyWith({
    int? id,
    int? fromId,
    int? toId,
    String? fromType,
    String? toType,
    int? score,
  }) => Relationship(
    id: id ?? this.id,
    fromId: fromId ?? this.fromId,
    toId: toId ?? this.toId,
    fromType: fromType ?? this.fromType,
    toType: toType ?? this.toType,
    score: score ?? this.score,
  );
  Relationship copyWithCompanion(RelationshipsCompanion data) {
    return Relationship(
      id: data.id.present ? data.id.value : this.id,
      fromId: data.fromId.present ? data.fromId.value : this.fromId,
      toId: data.toId.present ? data.toId.value : this.toId,
      fromType: data.fromType.present ? data.fromType.value : this.fromType,
      toType: data.toType.present ? data.toType.value : this.toType,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Relationship(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('toId: $toId, ')
          ..write('fromType: $fromType, ')
          ..write('toType: $toType, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fromId, toId, fromType, toType, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relationship &&
          other.id == this.id &&
          other.fromId == this.fromId &&
          other.toId == this.toId &&
          other.fromType == this.fromType &&
          other.toType == this.toType &&
          other.score == this.score);
}

class RelationshipsCompanion extends UpdateCompanion<Relationship> {
  final Value<int> id;
  final Value<int> fromId;
  final Value<int> toId;
  final Value<String> fromType;
  final Value<String> toType;
  final Value<int> score;
  const RelationshipsCompanion({
    this.id = const Value.absent(),
    this.fromId = const Value.absent(),
    this.toId = const Value.absent(),
    this.fromType = const Value.absent(),
    this.toType = const Value.absent(),
    this.score = const Value.absent(),
  });
  RelationshipsCompanion.insert({
    this.id = const Value.absent(),
    required int fromId,
    required int toId,
    required String fromType,
    required String toType,
    required int score,
  }) : fromId = Value(fromId),
       toId = Value(toId),
       fromType = Value(fromType),
       toType = Value(toType),
       score = Value(score);
  static Insertable<Relationship> custom({
    Expression<int>? id,
    Expression<int>? fromId,
    Expression<int>? toId,
    Expression<String>? fromType,
    Expression<String>? toType,
    Expression<int>? score,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromId != null) 'from_id': fromId,
      if (toId != null) 'to_id': toId,
      if (fromType != null) 'from_type': fromType,
      if (toType != null) 'to_type': toType,
      if (score != null) 'score': score,
    });
  }

  RelationshipsCompanion copyWith({
    Value<int>? id,
    Value<int>? fromId,
    Value<int>? toId,
    Value<String>? fromType,
    Value<String>? toType,
    Value<int>? score,
  }) {
    return RelationshipsCompanion(
      id: id ?? this.id,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      fromType: fromType ?? this.fromType,
      toType: toType ?? this.toType,
      score: score ?? this.score,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromId.present) {
      map['from_id'] = Variable<int>(fromId.value);
    }
    if (toId.present) {
      map['to_id'] = Variable<int>(toId.value);
    }
    if (fromType.present) {
      map['from_type'] = Variable<String>(fromType.value);
    }
    if (toType.present) {
      map['to_type'] = Variable<String>(toType.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsCompanion(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('toId: $toId, ')
          ..write('fromType: $fromType, ')
          ..write('toType: $toType, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }
}

class $CountriesTable extends Countries
    with TableInfo<$CountriesTable, Country> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, code, reputation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'countries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Country> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Country map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Country(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
    );
  }

  @override
  $CountriesTable createAlias(String alias) {
    return $CountriesTable(attachedDatabase, alias);
  }
}

class Country extends DataClass implements Insertable<Country> {
  final int id;
  final String name;
  final String code;
  final int reputation;
  const Country({
    required this.id,
    required this.name,
    required this.code,
    required this.reputation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    map['reputation'] = Variable<int>(reputation);
    return map;
  }

  CountriesCompanion toCompanion(bool nullToAbsent) {
    return CountriesCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      reputation: Value(reputation),
    );
  }

  factory Country.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Country(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      reputation: serializer.fromJson<int>(json['reputation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'reputation': serializer.toJson<int>(reputation),
    };
  }

  Country copyWith({int? id, String? name, String? code, int? reputation}) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        reputation: reputation ?? this.reputation,
      );
  Country copyWithCompanion(CountriesCompanion data) {
    return Country(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Country(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('reputation: $reputation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, code, reputation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Country &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.reputation == this.reputation);
}

class CountriesCompanion extends UpdateCompanion<Country> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> code;
  final Value<int> reputation;
  const CountriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.reputation = const Value.absent(),
  });
  CountriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String code,
    required int reputation,
  }) : name = Value(name),
       code = Value(code),
       reputation = Value(reputation);
  static Insertable<Country> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? reputation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (reputation != null) 'reputation': reputation,
    });
  }

  CountriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? code,
    Value<int>? reputation,
  }) {
    return CountriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      reputation: reputation ?? this.reputation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('reputation: $reputation')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LeaguesTable leagues = $LeaguesTable(this);
  late final $ClubsTable clubs = $ClubsTable(this);
  late final $AgentsTable agents = $AgentsTable(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $TransfersTable transfers = $TransfersTable(this);
  late final $ValueHistoriesTable valueHistories = $ValueHistoriesTable(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $CountriesTable countries = $CountriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    leagues,
    clubs,
    agents,
    contracts,
    players,
    transfers,
    valueHistories,
    relationships,
    countries,
  ];
}

typedef $$LeaguesTableCreateCompanionBuilder =
    LeaguesCompanion Function({
      Value<int> id,
      required String name,
      required int countryId,
      required int reputation,
    });
typedef $$LeaguesTableUpdateCompanionBuilder =
    LeaguesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> countryId,
      Value<int> reputation,
    });

final class $$LeaguesTableReferences
    extends BaseReferences<_$AppDatabase, $LeaguesTable, League> {
  $$LeaguesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClubsTable, List<Club>> _clubsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.clubs,
    aliasName: $_aliasNameGenerator(db.leagues.id, db.clubs.leagueId),
  );

  $$ClubsTableProcessedTableManager get clubsRefs {
    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.leagueId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_clubsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LeaguesTableFilterComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countryId => $composableBuilder(
    column: $table.countryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> clubsRefs(
    Expression<bool> Function($$ClubsTableFilterComposer f) f,
  ) {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.leagueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableFilterComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LeaguesTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countryId => $composableBuilder(
    column: $table.countryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaguesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaguesTable> {
  $$LeaguesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get countryId =>
      $composableBuilder(column: $table.countryId, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );

  Expression<T> clubsRefs<T extends Object>(
    Expression<T> Function($$ClubsTableAnnotationComposer a) f,
  ) {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.leagueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LeaguesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaguesTable,
          League,
          $$LeaguesTableFilterComposer,
          $$LeaguesTableOrderingComposer,
          $$LeaguesTableAnnotationComposer,
          $$LeaguesTableCreateCompanionBuilder,
          $$LeaguesTableUpdateCompanionBuilder,
          (League, $$LeaguesTableReferences),
          League,
          PrefetchHooks Function({bool clubsRefs})
        > {
  $$LeaguesTableTableManager(_$AppDatabase db, $LeaguesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaguesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaguesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaguesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> countryId = const Value.absent(),
                Value<int> reputation = const Value.absent(),
              }) => LeaguesCompanion(
                id: id,
                name: name,
                countryId: countryId,
                reputation: reputation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int countryId,
                required int reputation,
              }) => LeaguesCompanion.insert(
                id: id,
                name: name,
                countryId: countryId,
                reputation: reputation,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LeaguesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clubsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (clubsRefs) db.clubs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (clubsRefs)
                    await $_getPrefetchedData<League, $LeaguesTable, Club>(
                      currentTable: table,
                      referencedTable: $$LeaguesTableReferences._clubsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$LeaguesTableReferences(db, table, p0).clubsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.leagueId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LeaguesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaguesTable,
      League,
      $$LeaguesTableFilterComposer,
      $$LeaguesTableOrderingComposer,
      $$LeaguesTableAnnotationComposer,
      $$LeaguesTableCreateCompanionBuilder,
      $$LeaguesTableUpdateCompanionBuilder,
      (League, $$LeaguesTableReferences),
      League,
      PrefetchHooks Function({bool clubsRefs})
    >;
typedef $$ClubsTableCreateCompanionBuilder =
    ClubsCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> leagueId,
      required int reputation,
      required double transferBudget,
      required double wageBudget,
    });
typedef $$ClubsTableUpdateCompanionBuilder =
    ClubsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> leagueId,
      Value<int> reputation,
      Value<double> transferBudget,
      Value<double> wageBudget,
    });

final class $$ClubsTableReferences
    extends BaseReferences<_$AppDatabase, $ClubsTable, Club> {
  $$ClubsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeaguesTable _leagueIdTable(_$AppDatabase db) => db.leagues
      .createAlias($_aliasNameGenerator(db.clubs.leagueId, db.leagues.id));

  $$LeaguesTableProcessedTableManager? get leagueId {
    final $_column = $_itemColumn<int>('league_id');
    if ($_column == null) return null;
    final manager = $$LeaguesTableTableManager(
      $_db,
      $_db.leagues,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_leagueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(db.clubs.id, db.players.clubId),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.clubId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClubsTableFilterComposer extends Composer<_$AppDatabase, $ClubsTable> {
  $$ClubsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get transferBudget => $composableBuilder(
    column: $table.transferBudget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wageBudget => $composableBuilder(
    column: $table.wageBudget,
    builder: (column) => ColumnFilters(column),
  );

  $$LeaguesTableFilterComposer get leagueId {
    final $$LeaguesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leagueId,
      referencedTable: $db.leagues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeaguesTableFilterComposer(
            $db: $db,
            $table: $db.leagues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClubsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClubsTable> {
  $$ClubsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get transferBudget => $composableBuilder(
    column: $table.transferBudget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wageBudget => $composableBuilder(
    column: $table.wageBudget,
    builder: (column) => ColumnOrderings(column),
  );

  $$LeaguesTableOrderingComposer get leagueId {
    final $$LeaguesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leagueId,
      referencedTable: $db.leagues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeaguesTableOrderingComposer(
            $db: $db,
            $table: $db.leagues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClubsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClubsTable> {
  $$ClubsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get transferBudget => $composableBuilder(
    column: $table.transferBudget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wageBudget => $composableBuilder(
    column: $table.wageBudget,
    builder: (column) => column,
  );

  $$LeaguesTableAnnotationComposer get leagueId {
    final $$LeaguesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leagueId,
      referencedTable: $db.leagues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeaguesTableAnnotationComposer(
            $db: $db,
            $table: $db.leagues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClubsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClubsTable,
          Club,
          $$ClubsTableFilterComposer,
          $$ClubsTableOrderingComposer,
          $$ClubsTableAnnotationComposer,
          $$ClubsTableCreateCompanionBuilder,
          $$ClubsTableUpdateCompanionBuilder,
          (Club, $$ClubsTableReferences),
          Club,
          PrefetchHooks Function({bool leagueId, bool playersRefs})
        > {
  $$ClubsTableTableManager(_$AppDatabase db, $ClubsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClubsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClubsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClubsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> leagueId = const Value.absent(),
                Value<int> reputation = const Value.absent(),
                Value<double> transferBudget = const Value.absent(),
                Value<double> wageBudget = const Value.absent(),
              }) => ClubsCompanion(
                id: id,
                name: name,
                leagueId: leagueId,
                reputation: reputation,
                transferBudget: transferBudget,
                wageBudget: wageBudget,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> leagueId = const Value.absent(),
                required int reputation,
                required double transferBudget,
                required double wageBudget,
              }) => ClubsCompanion.insert(
                id: id,
                name: name,
                leagueId: leagueId,
                reputation: reputation,
                transferBudget: transferBudget,
                wageBudget: wageBudget,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ClubsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({leagueId = false, playersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (playersRefs) db.players],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (leagueId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.leagueId,
                                referencedTable: $$ClubsTableReferences
                                    ._leagueIdTable(db),
                                referencedColumn: $$ClubsTableReferences
                                    ._leagueIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData<Club, $ClubsTable, Player>(
                      currentTable: table,
                      referencedTable: $$ClubsTableReferences._playersRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$ClubsTableReferences(db, table, p0).playersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clubId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClubsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClubsTable,
      Club,
      $$ClubsTableFilterComposer,
      $$ClubsTableOrderingComposer,
      $$ClubsTableAnnotationComposer,
      $$ClubsTableCreateCompanionBuilder,
      $$ClubsTableUpdateCompanionBuilder,
      (Club, $$ClubsTableReferences),
      Club,
      PrefetchHooks Function({bool leagueId, bool playersRefs})
    >;
typedef $$AgentsTableCreateCompanionBuilder =
    AgentsCompanion Function({
      Value<int> id,
      required String name,
      required double balance,
      required int reputation,
      required int negotiationSkill,
      required int scoutingSkill,
      required int level,
    });
typedef $$AgentsTableUpdateCompanionBuilder =
    AgentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> balance,
      Value<int> reputation,
      Value<int> negotiationSkill,
      Value<int> scoutingSkill,
      Value<int> level,
    });

final class $$AgentsTableReferences
    extends BaseReferences<_$AppDatabase, $AgentsTable, Agent> {
  $$AgentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: $_aliasNameGenerator(db.agents.id, db.contracts.agentId),
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.agentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(db.agents.id, db.players.agentId),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.agentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AgentsTableFilterComposer
    extends Composer<_$AppDatabase, $AgentsTable> {
  $$AgentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get negotiationSkill => $composableBuilder(
    column: $table.negotiationSkill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoutingSkill => $composableBuilder(
    column: $table.scoutingSkill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AgentsTable> {
  $$AgentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get negotiationSkill => $composableBuilder(
    column: $table.negotiationSkill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoutingSkill => $composableBuilder(
    column: $table.scoutingSkill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AgentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgentsTable> {
  $$AgentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get negotiationSkill => $composableBuilder(
    column: $table.negotiationSkill,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoutingSkill => $composableBuilder(
    column: $table.scoutingSkill,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgentsTable,
          Agent,
          $$AgentsTableFilterComposer,
          $$AgentsTableOrderingComposer,
          $$AgentsTableAnnotationComposer,
          $$AgentsTableCreateCompanionBuilder,
          $$AgentsTableUpdateCompanionBuilder,
          (Agent, $$AgentsTableReferences),
          Agent,
          PrefetchHooks Function({bool contractsRefs, bool playersRefs})
        > {
  $$AgentsTableTableManager(_$AppDatabase db, $AgentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<int> reputation = const Value.absent(),
                Value<int> negotiationSkill = const Value.absent(),
                Value<int> scoutingSkill = const Value.absent(),
                Value<int> level = const Value.absent(),
              }) => AgentsCompanion(
                id: id,
                name: name,
                balance: balance,
                reputation: reputation,
                negotiationSkill: negotiationSkill,
                scoutingSkill: scoutingSkill,
                level: level,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double balance,
                required int reputation,
                required int negotiationSkill,
                required int scoutingSkill,
                required int level,
              }) => AgentsCompanion.insert(
                id: id,
                name: name,
                balance: balance,
                reputation: reputation,
                negotiationSkill: negotiationSkill,
                scoutingSkill: scoutingSkill,
                level: level,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AgentsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({contractsRefs = false, playersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contractsRefs) db.contracts,
                    if (playersRefs) db.players,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contractsRefs)
                        await $_getPrefetchedData<
                          Agent,
                          $AgentsTable,
                          Contract
                        >(
                          currentTable: table,
                          referencedTable: $$AgentsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AgentsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.agentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (playersRefs)
                        await $_getPrefetchedData<Agent, $AgentsTable, Player>(
                          currentTable: table,
                          referencedTable: $$AgentsTableReferences
                              ._playersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AgentsTableReferences(
                                db,
                                table,
                                p0,
                              ).playersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.agentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AgentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgentsTable,
      Agent,
      $$AgentsTableFilterComposer,
      $$AgentsTableOrderingComposer,
      $$AgentsTableAnnotationComposer,
      $$AgentsTableCreateCompanionBuilder,
      $$AgentsTableUpdateCompanionBuilder,
      (Agent, $$AgentsTableReferences),
      Agent,
      PrefetchHooks Function({bool contractsRefs, bool playersRefs})
    >;
typedef $$ContractsTableCreateCompanionBuilder =
    ContractsCompanion Function({
      Value<int> id,
      required int playerId,
      Value<int?> agentId,
      required DateTime startDate,
      required DateTime endDate,
      required double wage,
      required double releaseClause,
      required String status,
    });
typedef $$ContractsTableUpdateCompanionBuilder =
    ContractsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int?> agentId,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<double> wage,
      Value<double> releaseClause,
      Value<String> status,
    });

final class $$ContractsTableReferences
    extends BaseReferences<_$AppDatabase, $ContractsTable, Contract> {
  $$ContractsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AgentsTable _agentIdTable(_$AppDatabase db) => db.agents.createAlias(
    $_aliasNameGenerator(db.contracts.agentId, db.agents.id),
  );

  $$AgentsTableProcessedTableManager? get agentId {
    final $_column = $_itemColumn<int>('agent_id');
    if ($_column == null) return null;
    final manager = $$AgentsTableTableManager(
      $_db,
      $_db.agents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_agentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(
      db.contracts.id,
      db.players.currentContractId,
    ),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.currentContractId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wage => $composableBuilder(
    column: $table.wage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$AgentsTableFilterComposer get agentId {
    final $$AgentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableFilterComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.currentContractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wage => $composableBuilder(
    column: $table.wage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$AgentsTableOrderingComposer get agentId {
    final $$AgentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableOrderingComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get wage =>
      $composableBuilder(column: $table.wage, builder: (column) => column);

  GeneratedColumn<double> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$AgentsTableAnnotationComposer get agentId {
    final $$AgentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableAnnotationComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.currentContractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContractsTable,
          Contract,
          $$ContractsTableFilterComposer,
          $$ContractsTableOrderingComposer,
          $$ContractsTableAnnotationComposer,
          $$ContractsTableCreateCompanionBuilder,
          $$ContractsTableUpdateCompanionBuilder,
          (Contract, $$ContractsTableReferences),
          Contract,
          PrefetchHooks Function({bool agentId, bool playersRefs})
        > {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int?> agentId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<double> wage = const Value.absent(),
                Value<double> releaseClause = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => ContractsCompanion(
                id: id,
                playerId: playerId,
                agentId: agentId,
                startDate: startDate,
                endDate: endDate,
                wage: wage,
                releaseClause: releaseClause,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                Value<int?> agentId = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                required double wage,
                required double releaseClause,
                required String status,
              }) => ContractsCompanion.insert(
                id: id,
                playerId: playerId,
                agentId: agentId,
                startDate: startDate,
                endDate: endDate,
                wage: wage,
                releaseClause: releaseClause,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({agentId = false, playersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (playersRefs) db.players],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (agentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.agentId,
                                referencedTable: $$ContractsTableReferences
                                    ._agentIdTable(db),
                                referencedColumn: $$ContractsTableReferences
                                    ._agentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData<
                      Contract,
                      $ContractsTable,
                      Player
                    >(
                      currentTable: table,
                      referencedTable: $$ContractsTableReferences
                          ._playersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ContractsTableReferences(db, table, p0).playersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.currentContractId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContractsTable,
      Contract,
      $$ContractsTableFilterComposer,
      $$ContractsTableOrderingComposer,
      $$ContractsTableAnnotationComposer,
      $$ContractsTableCreateCompanionBuilder,
      $$ContractsTableUpdateCompanionBuilder,
      (Contract, $$ContractsTableReferences),
      Contract,
      PrefetchHooks Function({bool agentId, bool playersRefs})
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required String name,
      required int age,
      Value<int?> clubId,
      Value<int?> agentId,
      required String position,
      required int ca,
      required int pa,
      required int reputation,
      required int marketValue,
      Value<int?> currentContractId,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> age,
      Value<int?> clubId,
      Value<int?> agentId,
      Value<String> position,
      Value<int> ca,
      Value<int> pa,
      Value<int> reputation,
      Value<int> marketValue,
      Value<int?> currentContractId,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClubsTable _clubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.players.clubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager? get clubId {
    final $_column = $_itemColumn<int>('club_id');
    if ($_column == null) return null;
    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clubIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AgentsTable _agentIdTable(_$AppDatabase db) => db.agents.createAlias(
    $_aliasNameGenerator(db.players.agentId, db.agents.id),
  );

  $$AgentsTableProcessedTableManager? get agentId {
    final $_column = $_itemColumn<int>('agent_id');
    if ($_column == null) return null;
    final manager = $$AgentsTableTableManager(
      $_db,
      $_db.agents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_agentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContractsTable _currentContractIdTable(_$AppDatabase db) =>
      db.contracts.createAlias(
        $_aliasNameGenerator(db.players.currentContractId, db.contracts.id),
      );

  $$ContractsTableProcessedTableManager? get currentContractId {
    final $_column = $_itemColumn<int>('current_contract_id');
    if ($_column == null) return null;
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currentContractIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransfersTable, List<Transfer>>
  _transfersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transfers,
    aliasName: $_aliasNameGenerator(db.players.id, db.transfers.playerId),
  );

  $$TransfersTableProcessedTableManager get transfersRefs {
    final manager = $$TransfersTableTableManager(
      $_db,
      $_db.transfers,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transfersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ValueHistoriesTable, List<ValueHistory>>
  _valueHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.valueHistories,
    aliasName: $_aliasNameGenerator(db.players.id, db.valueHistories.playerId),
  );

  $$ValueHistoriesTableProcessedTableManager get valueHistoriesRefs {
    final manager = $$ValueHistoriesTableTableManager(
      $_db,
      $_db.valueHistories,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_valueHistoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ca => $composableBuilder(
    column: $table.ca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pa => $composableBuilder(
    column: $table.pa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => ColumnFilters(column),
  );

  $$ClubsTableFilterComposer get clubId {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableFilterComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AgentsTableFilterComposer get agentId {
    final $$AgentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableFilterComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableFilterComposer get currentContractId {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transfersRefs(
    Expression<bool> Function($$TransfersTableFilterComposer f) f,
  ) {
    final $$TransfersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableFilterComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> valueHistoriesRefs(
    Expression<bool> Function($$ValueHistoriesTableFilterComposer f) f,
  ) {
    final $$ValueHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.valueHistories,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ValueHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.valueHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ca => $composableBuilder(
    column: $table.ca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pa => $composableBuilder(
    column: $table.pa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClubsTableOrderingComposer get clubId {
    final $$ClubsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableOrderingComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AgentsTableOrderingComposer get agentId {
    final $$AgentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableOrderingComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableOrderingComposer get currentContractId {
    final $$ContractsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableOrderingComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get ca =>
      $composableBuilder(column: $table.ca, builder: (column) => column);

  GeneratedColumn<int> get pa =>
      $composableBuilder(column: $table.pa, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => column,
  );

  $$ClubsTableAnnotationComposer get clubId {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AgentsTableAnnotationComposer get agentId {
    final $$AgentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.agentId,
      referencedTable: $db.agents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentsTableAnnotationComposer(
            $db: $db,
            $table: $db.agents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableAnnotationComposer get currentContractId {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transfersRefs<T extends Object>(
    Expression<T> Function($$TransfersTableAnnotationComposer a) f,
  ) {
    final $$TransfersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableAnnotationComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> valueHistoriesRefs<T extends Object>(
    Expression<T> Function($$ValueHistoriesTableAnnotationComposer a) f,
  ) {
    final $$ValueHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.valueHistories,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ValueHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.valueHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({
            bool clubId,
            bool agentId,
            bool currentContractId,
            bool transfersRefs,
            bool valueHistoriesRefs,
          })
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<int?> clubId = const Value.absent(),
                Value<int?> agentId = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<int> ca = const Value.absent(),
                Value<int> pa = const Value.absent(),
                Value<int> reputation = const Value.absent(),
                Value<int> marketValue = const Value.absent(),
                Value<int?> currentContractId = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                name: name,
                age: age,
                clubId: clubId,
                agentId: agentId,
                position: position,
                ca: ca,
                pa: pa,
                reputation: reputation,
                marketValue: marketValue,
                currentContractId: currentContractId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int age,
                Value<int?> clubId = const Value.absent(),
                Value<int?> agentId = const Value.absent(),
                required String position,
                required int ca,
                required int pa,
                required int reputation,
                required int marketValue,
                Value<int?> currentContractId = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                age: age,
                clubId: clubId,
                agentId: agentId,
                position: position,
                ca: ca,
                pa: pa,
                reputation: reputation,
                marketValue: marketValue,
                currentContractId: currentContractId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clubId = false,
                agentId = false,
                currentContractId = false,
                transfersRefs = false,
                valueHistoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transfersRefs) db.transfers,
                    if (valueHistoriesRefs) db.valueHistories,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clubId,
                                    referencedTable: $$PlayersTableReferences
                                        ._clubIdTable(db),
                                    referencedColumn: $$PlayersTableReferences
                                        ._clubIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (agentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.agentId,
                                    referencedTable: $$PlayersTableReferences
                                        ._agentIdTable(db),
                                    referencedColumn: $$PlayersTableReferences
                                        ._agentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (currentContractId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currentContractId,
                                    referencedTable: $$PlayersTableReferences
                                        ._currentContractIdTable(db),
                                    referencedColumn: $$PlayersTableReferences
                                        ._currentContractIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transfersRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          Transfer
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._transfersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).transfersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (valueHistoriesRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          ValueHistory
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._valueHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).valueHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({
        bool clubId,
        bool agentId,
        bool currentContractId,
        bool transfersRefs,
        bool valueHistoriesRefs,
      })
    >;
typedef $$TransfersTableCreateCompanionBuilder =
    TransfersCompanion Function({
      Value<int> id,
      required int playerId,
      required int fromClubId,
      required int toClubId,
      required DateTime date,
      required double feeAmount,
      required String type,
    });
typedef $$TransfersTableUpdateCompanionBuilder =
    TransfersCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<int> fromClubId,
      Value<int> toClubId,
      Value<DateTime> date,
      Value<double> feeAmount,
      Value<String> type,
    });

final class $$TransfersTableReferences
    extends BaseReferences<_$AppDatabase, $TransfersTable, Transfer> {
  $$TransfersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayersTable _playerIdTable(_$AppDatabase db) => db.players
      .createAlias($_aliasNameGenerator(db.transfers.playerId, db.players.id));

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClubsTable _fromClubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.transfers.fromClubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get fromClubId {
    final $_column = $_itemColumn<int>('from_club_id')!;

    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromClubIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClubsTable _toClubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.transfers.toClubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get toClubId {
    final $_column = $_itemColumn<int>('to_club_id')!;

    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toClubIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransfersTableFilterComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feeAmount => $composableBuilder(
    column: $table.feeAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableFilterComposer get fromClubId {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableFilterComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableFilterComposer get toClubId {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableFilterComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feeAmount => $composableBuilder(
    column: $table.feeAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableOrderingComposer get fromClubId {
    final $$ClubsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableOrderingComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableOrderingComposer get toClubId {
    final $$ClubsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableOrderingComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransfersTable> {
  $$TransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get feeAmount =>
      $composableBuilder(column: $table.feeAmount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableAnnotationComposer get fromClubId {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClubsTableAnnotationComposer get toClubId {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toClubId,
      referencedTable: $db.clubs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransfersTable,
          Transfer,
          $$TransfersTableFilterComposer,
          $$TransfersTableOrderingComposer,
          $$TransfersTableAnnotationComposer,
          $$TransfersTableCreateCompanionBuilder,
          $$TransfersTableUpdateCompanionBuilder,
          (Transfer, $$TransfersTableReferences),
          Transfer,
          PrefetchHooks Function({
            bool playerId,
            bool fromClubId,
            bool toClubId,
          })
        > {
  $$TransfersTableTableManager(_$AppDatabase db, $TransfersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> fromClubId = const Value.absent(),
                Value<int> toClubId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> feeAmount = const Value.absent(),
                Value<String> type = const Value.absent(),
              }) => TransfersCompanion(
                id: id,
                playerId: playerId,
                fromClubId: fromClubId,
                toClubId: toClubId,
                date: date,
                feeAmount: feeAmount,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required int fromClubId,
                required int toClubId,
                required DateTime date,
                required double feeAmount,
                required String type,
              }) => TransfersCompanion.insert(
                id: id,
                playerId: playerId,
                fromClubId: fromClubId,
                toClubId: toClubId,
                date: date,
                feeAmount: feeAmount,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransfersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({playerId = false, fromClubId = false, toClubId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable: $$TransfersTableReferences
                                        ._playerIdTable(db),
                                    referencedColumn: $$TransfersTableReferences
                                        ._playerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (fromClubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromClubId,
                                    referencedTable: $$TransfersTableReferences
                                        ._fromClubIdTable(db),
                                    referencedColumn: $$TransfersTableReferences
                                        ._fromClubIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (toClubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toClubId,
                                    referencedTable: $$TransfersTableReferences
                                        ._toClubIdTable(db),
                                    referencedColumn: $$TransfersTableReferences
                                        ._toClubIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransfersTable,
      Transfer,
      $$TransfersTableFilterComposer,
      $$TransfersTableOrderingComposer,
      $$TransfersTableAnnotationComposer,
      $$TransfersTableCreateCompanionBuilder,
      $$TransfersTableUpdateCompanionBuilder,
      (Transfer, $$TransfersTableReferences),
      Transfer,
      PrefetchHooks Function({bool playerId, bool fromClubId, bool toClubId})
    >;
typedef $$ValueHistoriesTableCreateCompanionBuilder =
    ValueHistoriesCompanion Function({
      Value<int> id,
      required int playerId,
      required DateTime date,
      required double value,
    });
typedef $$ValueHistoriesTableUpdateCompanionBuilder =
    ValueHistoriesCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<DateTime> date,
      Value<double> value,
    });

final class $$ValueHistoriesTableReferences
    extends BaseReferences<_$AppDatabase, $ValueHistoriesTable, ValueHistory> {
  $$ValueHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.valueHistories.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ValueHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ValueHistoriesTable> {
  $$ValueHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ValueHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ValueHistoriesTable> {
  $$ValueHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ValueHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ValueHistoriesTable> {
  $$ValueHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ValueHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ValueHistoriesTable,
          ValueHistory,
          $$ValueHistoriesTableFilterComposer,
          $$ValueHistoriesTableOrderingComposer,
          $$ValueHistoriesTableAnnotationComposer,
          $$ValueHistoriesTableCreateCompanionBuilder,
          $$ValueHistoriesTableUpdateCompanionBuilder,
          (ValueHistory, $$ValueHistoriesTableReferences),
          ValueHistory,
          PrefetchHooks Function({bool playerId})
        > {
  $$ValueHistoriesTableTableManager(
    _$AppDatabase db,
    $ValueHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ValueHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ValueHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ValueHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> value = const Value.absent(),
              }) => ValueHistoriesCompanion(
                id: id,
                playerId: playerId,
                date: date,
                value: value,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required DateTime date,
                required double value,
              }) => ValueHistoriesCompanion.insert(
                id: id,
                playerId: playerId,
                date: date,
                value: value,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ValueHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$ValueHistoriesTableReferences
                                    ._playerIdTable(db),
                                referencedColumn:
                                    $$ValueHistoriesTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ValueHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ValueHistoriesTable,
      ValueHistory,
      $$ValueHistoriesTableFilterComposer,
      $$ValueHistoriesTableOrderingComposer,
      $$ValueHistoriesTableAnnotationComposer,
      $$ValueHistoriesTableCreateCompanionBuilder,
      $$ValueHistoriesTableUpdateCompanionBuilder,
      (ValueHistory, $$ValueHistoriesTableReferences),
      ValueHistory,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$RelationshipsTableCreateCompanionBuilder =
    RelationshipsCompanion Function({
      Value<int> id,
      required int fromId,
      required int toId,
      required String fromType,
      required String toType,
      required int score,
    });
typedef $$RelationshipsTableUpdateCompanionBuilder =
    RelationshipsCompanion Function({
      Value<int> id,
      Value<int> fromId,
      Value<int> toId,
      Value<String> fromType,
      Value<String> toType,
      Value<int> score,
    });

class $$RelationshipsTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromId => $composableBuilder(
    column: $table.fromId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toId => $composableBuilder(
    column: $table.toId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromType => $composableBuilder(
    column: $table.fromType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toType => $composableBuilder(
    column: $table.toType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RelationshipsTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromId => $composableBuilder(
    column: $table.fromId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toId => $composableBuilder(
    column: $table.toId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromType => $composableBuilder(
    column: $table.fromType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toType => $composableBuilder(
    column: $table.toType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RelationshipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fromId =>
      $composableBuilder(column: $table.fromId, builder: (column) => column);

  GeneratedColumn<int> get toId =>
      $composableBuilder(column: $table.toId, builder: (column) => column);

  GeneratedColumn<String> get fromType =>
      $composableBuilder(column: $table.fromType, builder: (column) => column);

  GeneratedColumn<String> get toType =>
      $composableBuilder(column: $table.toType, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);
}

class $$RelationshipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RelationshipsTable,
          Relationship,
          $$RelationshipsTableFilterComposer,
          $$RelationshipsTableOrderingComposer,
          $$RelationshipsTableAnnotationComposer,
          $$RelationshipsTableCreateCompanionBuilder,
          $$RelationshipsTableUpdateCompanionBuilder,
          (
            Relationship,
            BaseReferences<_$AppDatabase, $RelationshipsTable, Relationship>,
          ),
          Relationship,
          PrefetchHooks Function()
        > {
  $$RelationshipsTableTableManager(_$AppDatabase db, $RelationshipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromId = const Value.absent(),
                Value<int> toId = const Value.absent(),
                Value<String> fromType = const Value.absent(),
                Value<String> toType = const Value.absent(),
                Value<int> score = const Value.absent(),
              }) => RelationshipsCompanion(
                id: id,
                fromId: fromId,
                toId: toId,
                fromType: fromType,
                toType: toType,
                score: score,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromId,
                required int toId,
                required String fromType,
                required String toType,
                required int score,
              }) => RelationshipsCompanion.insert(
                id: id,
                fromId: fromId,
                toId: toId,
                fromType: fromType,
                toType: toType,
                score: score,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RelationshipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RelationshipsTable,
      Relationship,
      $$RelationshipsTableFilterComposer,
      $$RelationshipsTableOrderingComposer,
      $$RelationshipsTableAnnotationComposer,
      $$RelationshipsTableCreateCompanionBuilder,
      $$RelationshipsTableUpdateCompanionBuilder,
      (
        Relationship,
        BaseReferences<_$AppDatabase, $RelationshipsTable, Relationship>,
      ),
      Relationship,
      PrefetchHooks Function()
    >;
typedef $$CountriesTableCreateCompanionBuilder =
    CountriesCompanion Function({
      Value<int> id,
      required String name,
      required String code,
      required int reputation,
    });
typedef $$CountriesTableUpdateCompanionBuilder =
    CountriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> code,
      Value<int> reputation,
    });

class $$CountriesTableFilterComposer
    extends Composer<_$AppDatabase, $CountriesTable> {
  $$CountriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CountriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CountriesTable> {
  $$CountriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CountriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountriesTable> {
  $$CountriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );
}

class $$CountriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountriesTable,
          Country,
          $$CountriesTableFilterComposer,
          $$CountriesTableOrderingComposer,
          $$CountriesTableAnnotationComposer,
          $$CountriesTableCreateCompanionBuilder,
          $$CountriesTableUpdateCompanionBuilder,
          (Country, BaseReferences<_$AppDatabase, $CountriesTable, Country>),
          Country,
          PrefetchHooks Function()
        > {
  $$CountriesTableTableManager(_$AppDatabase db, $CountriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> reputation = const Value.absent(),
              }) => CountriesCompanion(
                id: id,
                name: name,
                code: code,
                reputation: reputation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String code,
                required int reputation,
              }) => CountriesCompanion.insert(
                id: id,
                name: name,
                code: code,
                reputation: reputation,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CountriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountriesTable,
      Country,
      $$CountriesTableFilterComposer,
      $$CountriesTableOrderingComposer,
      $$CountriesTableAnnotationComposer,
      $$CountriesTableCreateCompanionBuilder,
      $$CountriesTableUpdateCompanionBuilder,
      (Country, BaseReferences<_$AppDatabase, $CountriesTable, Country>),
      Country,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LeaguesTableTableManager get leagues =>
      $$LeaguesTableTableManager(_db, _db.leagues);
  $$ClubsTableTableManager get clubs =>
      $$ClubsTableTableManager(_db, _db.clubs);
  $$AgentsTableTableManager get agents =>
      $$AgentsTableTableManager(_db, _db.agents);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$TransfersTableTableManager get transfers =>
      $$TransfersTableTableManager(_db, _db.transfers);
  $$ValueHistoriesTableTableManager get valueHistories =>
      $$ValueHistoriesTableTableManager(_db, _db.valueHistories);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$CountriesTableTableManager get countries =>
      $$CountriesTableTableManager(_db, _db.countries);
}
