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
          ..write('marketValue: $marketValue')
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
          other.marketValue == this.marketValue);
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
          ..write('marketValue: $marketValue')
          ..write(')'))
        .toString();
  }
}

class $AgentContractsTable extends AgentContracts
    with TableInfo<$AgentContractsTable, AgentContract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentContractsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _agentIdMeta = const VerificationMeta(
    'agentId',
  );
  @override
  late final GeneratedColumn<int> agentId = GeneratedColumn<int>(
    'agent_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES agents (id)',
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
  static const VerificationMeta _feePercentageMeta = const VerificationMeta(
    'feePercentage',
  );
  @override
  late final GeneratedColumn<double> feePercentage = GeneratedColumn<double>(
    'fee_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10.0),
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
    agentId,
    playerId,
    startDate,
    endDate,
    feePercentage,
    wage,
    releaseClause,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgentContract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('agent_id')) {
      context.handle(
        _agentIdMeta,
        agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_agentIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
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
    if (data.containsKey('fee_percentage')) {
      context.handle(
        _feePercentageMeta,
        feePercentage.isAcceptableOrUnknown(
          data['fee_percentage']!,
          _feePercentageMeta,
        ),
      );
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
  AgentContract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentContract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      agentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agent_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      feePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fee_percentage'],
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
  $AgentContractsTable createAlias(String alias) {
    return $AgentContractsTable(attachedDatabase, alias);
  }
}

class AgentContract extends DataClass implements Insertable<AgentContract> {
  final int id;
  final int agentId;
  final int playerId;
  final DateTime startDate;
  final DateTime endDate;
  final double feePercentage;
  final double wage;
  final double releaseClause;
  final String status;
  const AgentContract({
    required this.id,
    required this.agentId,
    required this.playerId,
    required this.startDate,
    required this.endDate,
    required this.feePercentage,
    required this.wage,
    required this.releaseClause,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['agent_id'] = Variable<int>(agentId);
    map['player_id'] = Variable<int>(playerId);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['fee_percentage'] = Variable<double>(feePercentage);
    map['wage'] = Variable<double>(wage);
    map['release_clause'] = Variable<double>(releaseClause);
    map['status'] = Variable<String>(status);
    return map;
  }

  AgentContractsCompanion toCompanion(bool nullToAbsent) {
    return AgentContractsCompanion(
      id: Value(id),
      agentId: Value(agentId),
      playerId: Value(playerId),
      startDate: Value(startDate),
      endDate: Value(endDate),
      feePercentage: Value(feePercentage),
      wage: Value(wage),
      releaseClause: Value(releaseClause),
      status: Value(status),
    );
  }

  factory AgentContract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentContract(
      id: serializer.fromJson<int>(json['id']),
      agentId: serializer.fromJson<int>(json['agentId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      feePercentage: serializer.fromJson<double>(json['feePercentage']),
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
      'agentId': serializer.toJson<int>(agentId),
      'playerId': serializer.toJson<int>(playerId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'feePercentage': serializer.toJson<double>(feePercentage),
      'wage': serializer.toJson<double>(wage),
      'releaseClause': serializer.toJson<double>(releaseClause),
      'status': serializer.toJson<String>(status),
    };
  }

  AgentContract copyWith({
    int? id,
    int? agentId,
    int? playerId,
    DateTime? startDate,
    DateTime? endDate,
    double? feePercentage,
    double? wage,
    double? releaseClause,
    String? status,
  }) => AgentContract(
    id: id ?? this.id,
    agentId: agentId ?? this.agentId,
    playerId: playerId ?? this.playerId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    feePercentage: feePercentage ?? this.feePercentage,
    wage: wage ?? this.wage,
    releaseClause: releaseClause ?? this.releaseClause,
    status: status ?? this.status,
  );
  AgentContract copyWithCompanion(AgentContractsCompanion data) {
    return AgentContract(
      id: data.id.present ? data.id.value : this.id,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      feePercentage: data.feePercentage.present
          ? data.feePercentage.value
          : this.feePercentage,
      wage: data.wage.present ? data.wage.value : this.wage,
      releaseClause: data.releaseClause.present
          ? data.releaseClause.value
          : this.releaseClause,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentContract(')
          ..write('id: $id, ')
          ..write('agentId: $agentId, ')
          ..write('playerId: $playerId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('feePercentage: $feePercentage, ')
          ..write('wage: $wage, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    agentId,
    playerId,
    startDate,
    endDate,
    feePercentage,
    wage,
    releaseClause,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentContract &&
          other.id == this.id &&
          other.agentId == this.agentId &&
          other.playerId == this.playerId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.feePercentage == this.feePercentage &&
          other.wage == this.wage &&
          other.releaseClause == this.releaseClause &&
          other.status == this.status);
}

class AgentContractsCompanion extends UpdateCompanion<AgentContract> {
  final Value<int> id;
  final Value<int> agentId;
  final Value<int> playerId;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<double> feePercentage;
  final Value<double> wage;
  final Value<double> releaseClause;
  final Value<String> status;
  const AgentContractsCompanion({
    this.id = const Value.absent(),
    this.agentId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.feePercentage = const Value.absent(),
    this.wage = const Value.absent(),
    this.releaseClause = const Value.absent(),
    this.status = const Value.absent(),
  });
  AgentContractsCompanion.insert({
    this.id = const Value.absent(),
    required int agentId,
    required int playerId,
    required DateTime startDate,
    required DateTime endDate,
    this.feePercentage = const Value.absent(),
    required double wage,
    required double releaseClause,
    required String status,
  }) : agentId = Value(agentId),
       playerId = Value(playerId),
       startDate = Value(startDate),
       endDate = Value(endDate),
       wage = Value(wage),
       releaseClause = Value(releaseClause),
       status = Value(status);
  static Insertable<AgentContract> custom({
    Expression<int>? id,
    Expression<int>? agentId,
    Expression<int>? playerId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<double>? feePercentage,
    Expression<double>? wage,
    Expression<double>? releaseClause,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (agentId != null) 'agent_id': agentId,
      if (playerId != null) 'player_id': playerId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (feePercentage != null) 'fee_percentage': feePercentage,
      if (wage != null) 'wage': wage,
      if (releaseClause != null) 'release_clause': releaseClause,
      if (status != null) 'status': status,
    });
  }

  AgentContractsCompanion copyWith({
    Value<int>? id,
    Value<int>? agentId,
    Value<int>? playerId,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<double>? feePercentage,
    Value<double>? wage,
    Value<double>? releaseClause,
    Value<String>? status,
  }) {
    return AgentContractsCompanion(
      id: id ?? this.id,
      agentId: agentId ?? this.agentId,
      playerId: playerId ?? this.playerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      feePercentage: feePercentage ?? this.feePercentage,
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
    if (agentId.present) {
      map['agent_id'] = Variable<int>(agentId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (feePercentage.present) {
      map['fee_percentage'] = Variable<double>(feePercentage.value);
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
    return (StringBuffer('AgentContractsCompanion(')
          ..write('id: $id, ')
          ..write('agentId: $agentId, ')
          ..write('playerId: $playerId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('feePercentage: $feePercentage, ')
          ..write('wage: $wage, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ClubContractsTable extends ClubContracts
    with TableInfo<$ClubContractsTable, ClubContract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClubContractsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _clubIdMeta = const VerificationMeta('clubId');
  @override
  late final GeneratedColumn<int> clubId = GeneratedColumn<int>(
    'club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
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
  static const VerificationMeta _weeklySalaryMeta = const VerificationMeta(
    'weeklySalary',
  );
  @override
  late final GeneratedColumn<int> weeklySalary = GeneratedColumn<int>(
    'weekly_salary',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releaseClauseMeta = const VerificationMeta(
    'releaseClause',
  );
  @override
  late final GeneratedColumn<int> releaseClause = GeneratedColumn<int>(
    'release_clause',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clubId,
    playerId,
    weeklySalary,
    releaseClause,
    startDate,
    endDate,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'club_contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClubContract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('club_id')) {
      context.handle(
        _clubIdMeta,
        clubId.isAcceptableOrUnknown(data['club_id']!, _clubIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clubIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('weekly_salary')) {
      context.handle(
        _weeklySalaryMeta,
        weeklySalary.isAcceptableOrUnknown(
          data['weekly_salary']!,
          _weeklySalaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weeklySalaryMeta);
    }
    if (data.containsKey('release_clause')) {
      context.handle(
        _releaseClauseMeta,
        releaseClause.isAcceptableOrUnknown(
          data['release_clause']!,
          _releaseClauseMeta,
        ),
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
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClubContract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClubContract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}club_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      weeklySalary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_salary'],
      )!,
      releaseClause: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}release_clause'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ClubContractsTable createAlias(String alias) {
    return $ClubContractsTable(attachedDatabase, alias);
  }
}

class ClubContract extends DataClass implements Insertable<ClubContract> {
  final int id;
  final int clubId;
  final int playerId;
  final int weeklySalary;
  final int? releaseClause;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  const ClubContract({
    required this.id,
    required this.clubId,
    required this.playerId,
    required this.weeklySalary,
    this.releaseClause,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['club_id'] = Variable<int>(clubId);
    map['player_id'] = Variable<int>(playerId);
    map['weekly_salary'] = Variable<int>(weeklySalary);
    if (!nullToAbsent || releaseClause != null) {
      map['release_clause'] = Variable<int>(releaseClause);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['status'] = Variable<String>(status);
    return map;
  }

  ClubContractsCompanion toCompanion(bool nullToAbsent) {
    return ClubContractsCompanion(
      id: Value(id),
      clubId: Value(clubId),
      playerId: Value(playerId),
      weeklySalary: Value(weeklySalary),
      releaseClause: releaseClause == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseClause),
      startDate: Value(startDate),
      endDate: Value(endDate),
      status: Value(status),
    );
  }

  factory ClubContract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClubContract(
      id: serializer.fromJson<int>(json['id']),
      clubId: serializer.fromJson<int>(json['clubId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      weeklySalary: serializer.fromJson<int>(json['weeklySalary']),
      releaseClause: serializer.fromJson<int?>(json['releaseClause']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clubId': serializer.toJson<int>(clubId),
      'playerId': serializer.toJson<int>(playerId),
      'weeklySalary': serializer.toJson<int>(weeklySalary),
      'releaseClause': serializer.toJson<int?>(releaseClause),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'status': serializer.toJson<String>(status),
    };
  }

  ClubContract copyWith({
    int? id,
    int? clubId,
    int? playerId,
    int? weeklySalary,
    Value<int?> releaseClause = const Value.absent(),
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) => ClubContract(
    id: id ?? this.id,
    clubId: clubId ?? this.clubId,
    playerId: playerId ?? this.playerId,
    weeklySalary: weeklySalary ?? this.weeklySalary,
    releaseClause: releaseClause.present
        ? releaseClause.value
        : this.releaseClause,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    status: status ?? this.status,
  );
  ClubContract copyWithCompanion(ClubContractsCompanion data) {
    return ClubContract(
      id: data.id.present ? data.id.value : this.id,
      clubId: data.clubId.present ? data.clubId.value : this.clubId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      weeklySalary: data.weeklySalary.present
          ? data.weeklySalary.value
          : this.weeklySalary,
      releaseClause: data.releaseClause.present
          ? data.releaseClause.value
          : this.releaseClause,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClubContract(')
          ..write('id: $id, ')
          ..write('clubId: $clubId, ')
          ..write('playerId: $playerId, ')
          ..write('weeklySalary: $weeklySalary, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clubId,
    playerId,
    weeklySalary,
    releaseClause,
    startDate,
    endDate,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubContract &&
          other.id == this.id &&
          other.clubId == this.clubId &&
          other.playerId == this.playerId &&
          other.weeklySalary == this.weeklySalary &&
          other.releaseClause == this.releaseClause &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status);
}

class ClubContractsCompanion extends UpdateCompanion<ClubContract> {
  final Value<int> id;
  final Value<int> clubId;
  final Value<int> playerId;
  final Value<int> weeklySalary;
  final Value<int?> releaseClause;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> status;
  const ClubContractsCompanion({
    this.id = const Value.absent(),
    this.clubId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.weeklySalary = const Value.absent(),
    this.releaseClause = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  ClubContractsCompanion.insert({
    this.id = const Value.absent(),
    required int clubId,
    required int playerId,
    required int weeklySalary,
    this.releaseClause = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.status = const Value.absent(),
  }) : clubId = Value(clubId),
       playerId = Value(playerId),
       weeklySalary = Value(weeklySalary),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<ClubContract> custom({
    Expression<int>? id,
    Expression<int>? clubId,
    Expression<int>? playerId,
    Expression<int>? weeklySalary,
    Expression<int>? releaseClause,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clubId != null) 'club_id': clubId,
      if (playerId != null) 'player_id': playerId,
      if (weeklySalary != null) 'weekly_salary': weeklySalary,
      if (releaseClause != null) 'release_clause': releaseClause,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
    });
  }

  ClubContractsCompanion copyWith({
    Value<int>? id,
    Value<int>? clubId,
    Value<int>? playerId,
    Value<int>? weeklySalary,
    Value<int?>? releaseClause,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String>? status,
  }) {
    return ClubContractsCompanion(
      id: id ?? this.id,
      clubId: clubId ?? this.clubId,
      playerId: playerId ?? this.playerId,
      weeklySalary: weeklySalary ?? this.weeklySalary,
      releaseClause: releaseClause ?? this.releaseClause,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clubId.present) {
      map['club_id'] = Variable<int>(clubId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (weeklySalary.present) {
      map['weekly_salary'] = Variable<int>(weeklySalary.value);
    }
    if (releaseClause.present) {
      map['release_clause'] = Variable<int>(releaseClause.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClubContractsCompanion(')
          ..write('id: $id, ')
          ..write('clubId: $clubId, ')
          ..write('playerId: $playerId, ')
          ..write('weeklySalary: $weeklySalary, ')
          ..write('releaseClause: $releaseClause, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status')
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
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _weekMeta = const VerificationMeta('week');
  @override
  late final GeneratedColumn<int> week = GeneratedColumn<int>(
    'week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    season,
    week,
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
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('week')) {
      context.handle(
        _weekMeta,
        week.isAcceptableOrUnknown(data['week']!, _weekMeta),
      );
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
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      )!,
      week: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week'],
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
  final int season;
  final int week;
  const Transfer({
    required this.id,
    required this.playerId,
    required this.fromClubId,
    required this.toClubId,
    required this.date,
    required this.feeAmount,
    required this.type,
    required this.season,
    required this.week,
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
    map['season'] = Variable<int>(season);
    map['week'] = Variable<int>(week);
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
      season: Value(season),
      week: Value(week),
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
      season: serializer.fromJson<int>(json['season']),
      week: serializer.fromJson<int>(json['week']),
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
      'season': serializer.toJson<int>(season),
      'week': serializer.toJson<int>(week),
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
    int? season,
    int? week,
  }) => Transfer(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    fromClubId: fromClubId ?? this.fromClubId,
    toClubId: toClubId ?? this.toClubId,
    date: date ?? this.date,
    feeAmount: feeAmount ?? this.feeAmount,
    type: type ?? this.type,
    season: season ?? this.season,
    week: week ?? this.week,
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
      season: data.season.present ? data.season.value : this.season,
      week: data.week.present ? data.week.value : this.week,
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
          ..write('type: $type, ')
          ..write('season: $season, ')
          ..write('week: $week')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    fromClubId,
    toClubId,
    date,
    feeAmount,
    type,
    season,
    week,
  );
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
          other.type == this.type &&
          other.season == this.season &&
          other.week == this.week);
}

class TransfersCompanion extends UpdateCompanion<Transfer> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<int> fromClubId;
  final Value<int> toClubId;
  final Value<DateTime> date;
  final Value<double> feeAmount;
  final Value<String> type;
  final Value<int> season;
  final Value<int> week;
  const TransfersCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.fromClubId = const Value.absent(),
    this.toClubId = const Value.absent(),
    this.date = const Value.absent(),
    this.feeAmount = const Value.absent(),
    this.type = const Value.absent(),
    this.season = const Value.absent(),
    this.week = const Value.absent(),
  });
  TransfersCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required int fromClubId,
    required int toClubId,
    required DateTime date,
    required double feeAmount,
    required String type,
    this.season = const Value.absent(),
    this.week = const Value.absent(),
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
    Expression<int>? season,
    Expression<int>? week,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (fromClubId != null) 'from_club_id': fromClubId,
      if (toClubId != null) 'to_club_id': toClubId,
      if (date != null) 'date': date,
      if (feeAmount != null) 'fee_amount': feeAmount,
      if (type != null) 'type': type,
      if (season != null) 'season': season,
      if (week != null) 'week': week,
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
    Value<int>? season,
    Value<int>? week,
  }) {
    return TransfersCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      fromClubId: fromClubId ?? this.fromClubId,
      toClubId: toClubId ?? this.toClubId,
      date: date ?? this.date,
      feeAmount: feeAmount ?? this.feeAmount,
      type: type ?? this.type,
      season: season ?? this.season,
      week: week ?? this.week,
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
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (week.present) {
      map['week'] = Variable<int>(week.value);
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
          ..write('type: $type, ')
          ..write('season: $season, ')
          ..write('week: $week')
          ..write(')'))
        .toString();
  }
}

class $TransferNeedsTable extends TransferNeeds
    with TableInfo<$TransferNeedsTable, TransferNeed> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransferNeedsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _clubIdMeta = const VerificationMeta('clubId');
  @override
  late final GeneratedColumn<int> clubId = GeneratedColumn<int>(
    'club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
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
  static const VerificationMeta _targetPositionMeta = const VerificationMeta(
    'targetPosition',
  );
  @override
  late final GeneratedColumn<String> targetPosition = GeneratedColumn<String>(
    'target_position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minAgeMeta = const VerificationMeta('minAge');
  @override
  late final GeneratedColumn<int> minAge = GeneratedColumn<int>(
    'min_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxAgeMeta = const VerificationMeta('maxAge');
  @override
  late final GeneratedColumn<int> maxAge = GeneratedColumn<int>(
    'max_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minCaMeta = const VerificationMeta('minCa');
  @override
  late final GeneratedColumn<int> minCa = GeneratedColumn<int>(
    'min_ca',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxTransferBudgetMeta = const VerificationMeta(
    'maxTransferBudget',
  );
  @override
  late final GeneratedColumn<int> maxTransferBudget = GeneratedColumn<int>(
    'max_transfer_budget',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxWeeklySalaryMeta = const VerificationMeta(
    'maxWeeklySalary',
  );
  @override
  late final GeneratedColumn<int> maxWeeklySalary = GeneratedColumn<int>(
    'max_weekly_salary',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playerToSellIdMeta = const VerificationMeta(
    'playerToSellId',
  );
  @override
  late final GeneratedColumn<int> playerToSellId = GeneratedColumn<int>(
    'player_to_sell_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _minimumFeeMeta = const VerificationMeta(
    'minimumFee',
  );
  @override
  late final GeneratedColumn<int> minimumFee = GeneratedColumn<int>(
    'minimum_fee',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFulfilledMeta = const VerificationMeta(
    'isFulfilled',
  );
  @override
  late final GeneratedColumn<bool> isFulfilled = GeneratedColumn<bool>(
    'is_fulfilled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fulfilled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clubId,
    type,
    targetPosition,
    minAge,
    maxAge,
    minCa,
    maxTransferBudget,
    maxWeeklySalary,
    playerToSellId,
    minimumFee,
    isFulfilled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfer_needs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransferNeed> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('club_id')) {
      context.handle(
        _clubIdMeta,
        clubId.isAcceptableOrUnknown(data['club_id']!, _clubIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clubIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('target_position')) {
      context.handle(
        _targetPositionMeta,
        targetPosition.isAcceptableOrUnknown(
          data['target_position']!,
          _targetPositionMeta,
        ),
      );
    }
    if (data.containsKey('min_age')) {
      context.handle(
        _minAgeMeta,
        minAge.isAcceptableOrUnknown(data['min_age']!, _minAgeMeta),
      );
    }
    if (data.containsKey('max_age')) {
      context.handle(
        _maxAgeMeta,
        maxAge.isAcceptableOrUnknown(data['max_age']!, _maxAgeMeta),
      );
    }
    if (data.containsKey('min_ca')) {
      context.handle(
        _minCaMeta,
        minCa.isAcceptableOrUnknown(data['min_ca']!, _minCaMeta),
      );
    }
    if (data.containsKey('max_transfer_budget')) {
      context.handle(
        _maxTransferBudgetMeta,
        maxTransferBudget.isAcceptableOrUnknown(
          data['max_transfer_budget']!,
          _maxTransferBudgetMeta,
        ),
      );
    }
    if (data.containsKey('max_weekly_salary')) {
      context.handle(
        _maxWeeklySalaryMeta,
        maxWeeklySalary.isAcceptableOrUnknown(
          data['max_weekly_salary']!,
          _maxWeeklySalaryMeta,
        ),
      );
    }
    if (data.containsKey('player_to_sell_id')) {
      context.handle(
        _playerToSellIdMeta,
        playerToSellId.isAcceptableOrUnknown(
          data['player_to_sell_id']!,
          _playerToSellIdMeta,
        ),
      );
    }
    if (data.containsKey('minimum_fee')) {
      context.handle(
        _minimumFeeMeta,
        minimumFee.isAcceptableOrUnknown(data['minimum_fee']!, _minimumFeeMeta),
      );
    }
    if (data.containsKey('is_fulfilled')) {
      context.handle(
        _isFulfilledMeta,
        isFulfilled.isAcceptableOrUnknown(
          data['is_fulfilled']!,
          _isFulfilledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransferNeed map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransferNeed(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}club_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      targetPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_position'],
      ),
      minAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_age'],
      ),
      maxAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_age'],
      ),
      minCa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_ca'],
      ),
      maxTransferBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_transfer_budget'],
      ),
      maxWeeklySalary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_weekly_salary'],
      ),
      playerToSellId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_to_sell_id'],
      ),
      minimumFee: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimum_fee'],
      ),
      isFulfilled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fulfilled'],
      )!,
    );
  }

  @override
  $TransferNeedsTable createAlias(String alias) {
    return $TransferNeedsTable(attachedDatabase, alias);
  }
}

class TransferNeed extends DataClass implements Insertable<TransferNeed> {
  final int id;
  final int clubId;
  final String type;
  final String? targetPosition;
  final int? minAge;
  final int? maxAge;
  final int? minCa;
  final int? maxTransferBudget;
  final int? maxWeeklySalary;
  final int? playerToSellId;
  final int? minimumFee;
  final bool isFulfilled;
  const TransferNeed({
    required this.id,
    required this.clubId,
    required this.type,
    this.targetPosition,
    this.minAge,
    this.maxAge,
    this.minCa,
    this.maxTransferBudget,
    this.maxWeeklySalary,
    this.playerToSellId,
    this.minimumFee,
    required this.isFulfilled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['club_id'] = Variable<int>(clubId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || targetPosition != null) {
      map['target_position'] = Variable<String>(targetPosition);
    }
    if (!nullToAbsent || minAge != null) {
      map['min_age'] = Variable<int>(minAge);
    }
    if (!nullToAbsent || maxAge != null) {
      map['max_age'] = Variable<int>(maxAge);
    }
    if (!nullToAbsent || minCa != null) {
      map['min_ca'] = Variable<int>(minCa);
    }
    if (!nullToAbsent || maxTransferBudget != null) {
      map['max_transfer_budget'] = Variable<int>(maxTransferBudget);
    }
    if (!nullToAbsent || maxWeeklySalary != null) {
      map['max_weekly_salary'] = Variable<int>(maxWeeklySalary);
    }
    if (!nullToAbsent || playerToSellId != null) {
      map['player_to_sell_id'] = Variable<int>(playerToSellId);
    }
    if (!nullToAbsent || minimumFee != null) {
      map['minimum_fee'] = Variable<int>(minimumFee);
    }
    map['is_fulfilled'] = Variable<bool>(isFulfilled);
    return map;
  }

  TransferNeedsCompanion toCompanion(bool nullToAbsent) {
    return TransferNeedsCompanion(
      id: Value(id),
      clubId: Value(clubId),
      type: Value(type),
      targetPosition: targetPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(targetPosition),
      minAge: minAge == null && nullToAbsent
          ? const Value.absent()
          : Value(minAge),
      maxAge: maxAge == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAge),
      minCa: minCa == null && nullToAbsent
          ? const Value.absent()
          : Value(minCa),
      maxTransferBudget: maxTransferBudget == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTransferBudget),
      maxWeeklySalary: maxWeeklySalary == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeeklySalary),
      playerToSellId: playerToSellId == null && nullToAbsent
          ? const Value.absent()
          : Value(playerToSellId),
      minimumFee: minimumFee == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumFee),
      isFulfilled: Value(isFulfilled),
    );
  }

  factory TransferNeed.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransferNeed(
      id: serializer.fromJson<int>(json['id']),
      clubId: serializer.fromJson<int>(json['clubId']),
      type: serializer.fromJson<String>(json['type']),
      targetPosition: serializer.fromJson<String?>(json['targetPosition']),
      minAge: serializer.fromJson<int?>(json['minAge']),
      maxAge: serializer.fromJson<int?>(json['maxAge']),
      minCa: serializer.fromJson<int?>(json['minCa']),
      maxTransferBudget: serializer.fromJson<int?>(json['maxTransferBudget']),
      maxWeeklySalary: serializer.fromJson<int?>(json['maxWeeklySalary']),
      playerToSellId: serializer.fromJson<int?>(json['playerToSellId']),
      minimumFee: serializer.fromJson<int?>(json['minimumFee']),
      isFulfilled: serializer.fromJson<bool>(json['isFulfilled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clubId': serializer.toJson<int>(clubId),
      'type': serializer.toJson<String>(type),
      'targetPosition': serializer.toJson<String?>(targetPosition),
      'minAge': serializer.toJson<int?>(minAge),
      'maxAge': serializer.toJson<int?>(maxAge),
      'minCa': serializer.toJson<int?>(minCa),
      'maxTransferBudget': serializer.toJson<int?>(maxTransferBudget),
      'maxWeeklySalary': serializer.toJson<int?>(maxWeeklySalary),
      'playerToSellId': serializer.toJson<int?>(playerToSellId),
      'minimumFee': serializer.toJson<int?>(minimumFee),
      'isFulfilled': serializer.toJson<bool>(isFulfilled),
    };
  }

  TransferNeed copyWith({
    int? id,
    int? clubId,
    String? type,
    Value<String?> targetPosition = const Value.absent(),
    Value<int?> minAge = const Value.absent(),
    Value<int?> maxAge = const Value.absent(),
    Value<int?> minCa = const Value.absent(),
    Value<int?> maxTransferBudget = const Value.absent(),
    Value<int?> maxWeeklySalary = const Value.absent(),
    Value<int?> playerToSellId = const Value.absent(),
    Value<int?> minimumFee = const Value.absent(),
    bool? isFulfilled,
  }) => TransferNeed(
    id: id ?? this.id,
    clubId: clubId ?? this.clubId,
    type: type ?? this.type,
    targetPosition: targetPosition.present
        ? targetPosition.value
        : this.targetPosition,
    minAge: minAge.present ? minAge.value : this.minAge,
    maxAge: maxAge.present ? maxAge.value : this.maxAge,
    minCa: minCa.present ? minCa.value : this.minCa,
    maxTransferBudget: maxTransferBudget.present
        ? maxTransferBudget.value
        : this.maxTransferBudget,
    maxWeeklySalary: maxWeeklySalary.present
        ? maxWeeklySalary.value
        : this.maxWeeklySalary,
    playerToSellId: playerToSellId.present
        ? playerToSellId.value
        : this.playerToSellId,
    minimumFee: minimumFee.present ? minimumFee.value : this.minimumFee,
    isFulfilled: isFulfilled ?? this.isFulfilled,
  );
  TransferNeed copyWithCompanion(TransferNeedsCompanion data) {
    return TransferNeed(
      id: data.id.present ? data.id.value : this.id,
      clubId: data.clubId.present ? data.clubId.value : this.clubId,
      type: data.type.present ? data.type.value : this.type,
      targetPosition: data.targetPosition.present
          ? data.targetPosition.value
          : this.targetPosition,
      minAge: data.minAge.present ? data.minAge.value : this.minAge,
      maxAge: data.maxAge.present ? data.maxAge.value : this.maxAge,
      minCa: data.minCa.present ? data.minCa.value : this.minCa,
      maxTransferBudget: data.maxTransferBudget.present
          ? data.maxTransferBudget.value
          : this.maxTransferBudget,
      maxWeeklySalary: data.maxWeeklySalary.present
          ? data.maxWeeklySalary.value
          : this.maxWeeklySalary,
      playerToSellId: data.playerToSellId.present
          ? data.playerToSellId.value
          : this.playerToSellId,
      minimumFee: data.minimumFee.present
          ? data.minimumFee.value
          : this.minimumFee,
      isFulfilled: data.isFulfilled.present
          ? data.isFulfilled.value
          : this.isFulfilled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransferNeed(')
          ..write('id: $id, ')
          ..write('clubId: $clubId, ')
          ..write('type: $type, ')
          ..write('targetPosition: $targetPosition, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge, ')
          ..write('minCa: $minCa, ')
          ..write('maxTransferBudget: $maxTransferBudget, ')
          ..write('maxWeeklySalary: $maxWeeklySalary, ')
          ..write('playerToSellId: $playerToSellId, ')
          ..write('minimumFee: $minimumFee, ')
          ..write('isFulfilled: $isFulfilled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clubId,
    type,
    targetPosition,
    minAge,
    maxAge,
    minCa,
    maxTransferBudget,
    maxWeeklySalary,
    playerToSellId,
    minimumFee,
    isFulfilled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferNeed &&
          other.id == this.id &&
          other.clubId == this.clubId &&
          other.type == this.type &&
          other.targetPosition == this.targetPosition &&
          other.minAge == this.minAge &&
          other.maxAge == this.maxAge &&
          other.minCa == this.minCa &&
          other.maxTransferBudget == this.maxTransferBudget &&
          other.maxWeeklySalary == this.maxWeeklySalary &&
          other.playerToSellId == this.playerToSellId &&
          other.minimumFee == this.minimumFee &&
          other.isFulfilled == this.isFulfilled);
}

class TransferNeedsCompanion extends UpdateCompanion<TransferNeed> {
  final Value<int> id;
  final Value<int> clubId;
  final Value<String> type;
  final Value<String?> targetPosition;
  final Value<int?> minAge;
  final Value<int?> maxAge;
  final Value<int?> minCa;
  final Value<int?> maxTransferBudget;
  final Value<int?> maxWeeklySalary;
  final Value<int?> playerToSellId;
  final Value<int?> minimumFee;
  final Value<bool> isFulfilled;
  const TransferNeedsCompanion({
    this.id = const Value.absent(),
    this.clubId = const Value.absent(),
    this.type = const Value.absent(),
    this.targetPosition = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
    this.minCa = const Value.absent(),
    this.maxTransferBudget = const Value.absent(),
    this.maxWeeklySalary = const Value.absent(),
    this.playerToSellId = const Value.absent(),
    this.minimumFee = const Value.absent(),
    this.isFulfilled = const Value.absent(),
  });
  TransferNeedsCompanion.insert({
    this.id = const Value.absent(),
    required int clubId,
    required String type,
    this.targetPosition = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
    this.minCa = const Value.absent(),
    this.maxTransferBudget = const Value.absent(),
    this.maxWeeklySalary = const Value.absent(),
    this.playerToSellId = const Value.absent(),
    this.minimumFee = const Value.absent(),
    this.isFulfilled = const Value.absent(),
  }) : clubId = Value(clubId),
       type = Value(type);
  static Insertable<TransferNeed> custom({
    Expression<int>? id,
    Expression<int>? clubId,
    Expression<String>? type,
    Expression<String>? targetPosition,
    Expression<int>? minAge,
    Expression<int>? maxAge,
    Expression<int>? minCa,
    Expression<int>? maxTransferBudget,
    Expression<int>? maxWeeklySalary,
    Expression<int>? playerToSellId,
    Expression<int>? minimumFee,
    Expression<bool>? isFulfilled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clubId != null) 'club_id': clubId,
      if (type != null) 'type': type,
      if (targetPosition != null) 'target_position': targetPosition,
      if (minAge != null) 'min_age': minAge,
      if (maxAge != null) 'max_age': maxAge,
      if (minCa != null) 'min_ca': minCa,
      if (maxTransferBudget != null) 'max_transfer_budget': maxTransferBudget,
      if (maxWeeklySalary != null) 'max_weekly_salary': maxWeeklySalary,
      if (playerToSellId != null) 'player_to_sell_id': playerToSellId,
      if (minimumFee != null) 'minimum_fee': minimumFee,
      if (isFulfilled != null) 'is_fulfilled': isFulfilled,
    });
  }

  TransferNeedsCompanion copyWith({
    Value<int>? id,
    Value<int>? clubId,
    Value<String>? type,
    Value<String?>? targetPosition,
    Value<int?>? minAge,
    Value<int?>? maxAge,
    Value<int?>? minCa,
    Value<int?>? maxTransferBudget,
    Value<int?>? maxWeeklySalary,
    Value<int?>? playerToSellId,
    Value<int?>? minimumFee,
    Value<bool>? isFulfilled,
  }) {
    return TransferNeedsCompanion(
      id: id ?? this.id,
      clubId: clubId ?? this.clubId,
      type: type ?? this.type,
      targetPosition: targetPosition ?? this.targetPosition,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      minCa: minCa ?? this.minCa,
      maxTransferBudget: maxTransferBudget ?? this.maxTransferBudget,
      maxWeeklySalary: maxWeeklySalary ?? this.maxWeeklySalary,
      playerToSellId: playerToSellId ?? this.playerToSellId,
      minimumFee: minimumFee ?? this.minimumFee,
      isFulfilled: isFulfilled ?? this.isFulfilled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clubId.present) {
      map['club_id'] = Variable<int>(clubId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetPosition.present) {
      map['target_position'] = Variable<String>(targetPosition.value);
    }
    if (minAge.present) {
      map['min_age'] = Variable<int>(minAge.value);
    }
    if (maxAge.present) {
      map['max_age'] = Variable<int>(maxAge.value);
    }
    if (minCa.present) {
      map['min_ca'] = Variable<int>(minCa.value);
    }
    if (maxTransferBudget.present) {
      map['max_transfer_budget'] = Variable<int>(maxTransferBudget.value);
    }
    if (maxWeeklySalary.present) {
      map['max_weekly_salary'] = Variable<int>(maxWeeklySalary.value);
    }
    if (playerToSellId.present) {
      map['player_to_sell_id'] = Variable<int>(playerToSellId.value);
    }
    if (minimumFee.present) {
      map['minimum_fee'] = Variable<int>(minimumFee.value);
    }
    if (isFulfilled.present) {
      map['is_fulfilled'] = Variable<bool>(isFulfilled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransferNeedsCompanion(')
          ..write('id: $id, ')
          ..write('clubId: $clubId, ')
          ..write('type: $type, ')
          ..write('targetPosition: $targetPosition, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge, ')
          ..write('minCa: $minCa, ')
          ..write('maxTransferBudget: $maxTransferBudget, ')
          ..write('maxWeeklySalary: $maxWeeklySalary, ')
          ..write('playerToSellId: $playerToSellId, ')
          ..write('minimumFee: $minimumFee, ')
          ..write('isFulfilled: $isFulfilled')
          ..write(')'))
        .toString();
  }
}

class $TransferOffersTable extends TransferOffers
    with TableInfo<$TransferOffersTable, TransferOffer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransferOffersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _needIdMeta = const VerificationMeta('needId');
  @override
  late final GeneratedColumn<int> needId = GeneratedColumn<int>(
    'need_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transfer_needs (id)',
    ),
  );
  static const VerificationMeta _offerAmountMeta = const VerificationMeta(
    'offerAmount',
  );
  @override
  late final GeneratedColumn<int> offerAmount = GeneratedColumn<int>(
    'offer_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposedSalaryMeta = const VerificationMeta(
    'proposedSalary',
  );
  @override
  late final GeneratedColumn<int> proposedSalary = GeneratedColumn<int>(
    'proposed_salary',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contractYearsMeta = const VerificationMeta(
    'contractYears',
  );
  @override
  late final GeneratedColumn<int> contractYears = GeneratedColumn<int>(
    'contract_years',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtWeekMeta = const VerificationMeta(
    'createdAtWeek',
  );
  @override
  late final GeneratedColumn<int> createdAtWeek = GeneratedColumn<int>(
    'created_at_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromClubId,
    toClubId,
    playerId,
    needId,
    offerAmount,
    proposedSalary,
    contractYears,
    season,
    createdAtWeek,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfer_offers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransferOffer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('need_id')) {
      context.handle(
        _needIdMeta,
        needId.isAcceptableOrUnknown(data['need_id']!, _needIdMeta),
      );
    } else if (isInserting) {
      context.missing(_needIdMeta);
    }
    if (data.containsKey('offer_amount')) {
      context.handle(
        _offerAmountMeta,
        offerAmount.isAcceptableOrUnknown(
          data['offer_amount']!,
          _offerAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offerAmountMeta);
    }
    if (data.containsKey('proposed_salary')) {
      context.handle(
        _proposedSalaryMeta,
        proposedSalary.isAcceptableOrUnknown(
          data['proposed_salary']!,
          _proposedSalaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proposedSalaryMeta);
    }
    if (data.containsKey('contract_years')) {
      context.handle(
        _contractYearsMeta,
        contractYears.isAcceptableOrUnknown(
          data['contract_years']!,
          _contractYearsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contractYearsMeta);
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('created_at_week')) {
      context.handle(
        _createdAtWeekMeta,
        createdAtWeek.isAcceptableOrUnknown(
          data['created_at_week']!,
          _createdAtWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtWeekMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransferOffer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransferOffer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_club_id'],
      )!,
      toClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_club_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      needId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}need_id'],
      )!,
      offerAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offer_amount'],
      )!,
      proposedSalary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}proposed_salary'],
      )!,
      contractYears: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contract_years'],
      )!,
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      )!,
      createdAtWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_week'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $TransferOffersTable createAlias(String alias) {
    return $TransferOffersTable(attachedDatabase, alias);
  }
}

class TransferOffer extends DataClass implements Insertable<TransferOffer> {
  final int id;
  final int fromClubId;
  final int toClubId;
  final int playerId;
  final int needId;
  final int offerAmount;
  final int proposedSalary;
  final int contractYears;
  final int season;
  final int createdAtWeek;
  final String status;
  const TransferOffer({
    required this.id,
    required this.fromClubId,
    required this.toClubId,
    required this.playerId,
    required this.needId,
    required this.offerAmount,
    required this.proposedSalary,
    required this.contractYears,
    required this.season,
    required this.createdAtWeek,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_club_id'] = Variable<int>(fromClubId);
    map['to_club_id'] = Variable<int>(toClubId);
    map['player_id'] = Variable<int>(playerId);
    map['need_id'] = Variable<int>(needId);
    map['offer_amount'] = Variable<int>(offerAmount);
    map['proposed_salary'] = Variable<int>(proposedSalary);
    map['contract_years'] = Variable<int>(contractYears);
    map['season'] = Variable<int>(season);
    map['created_at_week'] = Variable<int>(createdAtWeek);
    map['status'] = Variable<String>(status);
    return map;
  }

  TransferOffersCompanion toCompanion(bool nullToAbsent) {
    return TransferOffersCompanion(
      id: Value(id),
      fromClubId: Value(fromClubId),
      toClubId: Value(toClubId),
      playerId: Value(playerId),
      needId: Value(needId),
      offerAmount: Value(offerAmount),
      proposedSalary: Value(proposedSalary),
      contractYears: Value(contractYears),
      season: Value(season),
      createdAtWeek: Value(createdAtWeek),
      status: Value(status),
    );
  }

  factory TransferOffer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransferOffer(
      id: serializer.fromJson<int>(json['id']),
      fromClubId: serializer.fromJson<int>(json['fromClubId']),
      toClubId: serializer.fromJson<int>(json['toClubId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      needId: serializer.fromJson<int>(json['needId']),
      offerAmount: serializer.fromJson<int>(json['offerAmount']),
      proposedSalary: serializer.fromJson<int>(json['proposedSalary']),
      contractYears: serializer.fromJson<int>(json['contractYears']),
      season: serializer.fromJson<int>(json['season']),
      createdAtWeek: serializer.fromJson<int>(json['createdAtWeek']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromClubId': serializer.toJson<int>(fromClubId),
      'toClubId': serializer.toJson<int>(toClubId),
      'playerId': serializer.toJson<int>(playerId),
      'needId': serializer.toJson<int>(needId),
      'offerAmount': serializer.toJson<int>(offerAmount),
      'proposedSalary': serializer.toJson<int>(proposedSalary),
      'contractYears': serializer.toJson<int>(contractYears),
      'season': serializer.toJson<int>(season),
      'createdAtWeek': serializer.toJson<int>(createdAtWeek),
      'status': serializer.toJson<String>(status),
    };
  }

  TransferOffer copyWith({
    int? id,
    int? fromClubId,
    int? toClubId,
    int? playerId,
    int? needId,
    int? offerAmount,
    int? proposedSalary,
    int? contractYears,
    int? season,
    int? createdAtWeek,
    String? status,
  }) => TransferOffer(
    id: id ?? this.id,
    fromClubId: fromClubId ?? this.fromClubId,
    toClubId: toClubId ?? this.toClubId,
    playerId: playerId ?? this.playerId,
    needId: needId ?? this.needId,
    offerAmount: offerAmount ?? this.offerAmount,
    proposedSalary: proposedSalary ?? this.proposedSalary,
    contractYears: contractYears ?? this.contractYears,
    season: season ?? this.season,
    createdAtWeek: createdAtWeek ?? this.createdAtWeek,
    status: status ?? this.status,
  );
  TransferOffer copyWithCompanion(TransferOffersCompanion data) {
    return TransferOffer(
      id: data.id.present ? data.id.value : this.id,
      fromClubId: data.fromClubId.present
          ? data.fromClubId.value
          : this.fromClubId,
      toClubId: data.toClubId.present ? data.toClubId.value : this.toClubId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      needId: data.needId.present ? data.needId.value : this.needId,
      offerAmount: data.offerAmount.present
          ? data.offerAmount.value
          : this.offerAmount,
      proposedSalary: data.proposedSalary.present
          ? data.proposedSalary.value
          : this.proposedSalary,
      contractYears: data.contractYears.present
          ? data.contractYears.value
          : this.contractYears,
      season: data.season.present ? data.season.value : this.season,
      createdAtWeek: data.createdAtWeek.present
          ? data.createdAtWeek.value
          : this.createdAtWeek,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransferOffer(')
          ..write('id: $id, ')
          ..write('fromClubId: $fromClubId, ')
          ..write('toClubId: $toClubId, ')
          ..write('playerId: $playerId, ')
          ..write('needId: $needId, ')
          ..write('offerAmount: $offerAmount, ')
          ..write('proposedSalary: $proposedSalary, ')
          ..write('contractYears: $contractYears, ')
          ..write('season: $season, ')
          ..write('createdAtWeek: $createdAtWeek, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromClubId,
    toClubId,
    playerId,
    needId,
    offerAmount,
    proposedSalary,
    contractYears,
    season,
    createdAtWeek,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferOffer &&
          other.id == this.id &&
          other.fromClubId == this.fromClubId &&
          other.toClubId == this.toClubId &&
          other.playerId == this.playerId &&
          other.needId == this.needId &&
          other.offerAmount == this.offerAmount &&
          other.proposedSalary == this.proposedSalary &&
          other.contractYears == this.contractYears &&
          other.season == this.season &&
          other.createdAtWeek == this.createdAtWeek &&
          other.status == this.status);
}

class TransferOffersCompanion extends UpdateCompanion<TransferOffer> {
  final Value<int> id;
  final Value<int> fromClubId;
  final Value<int> toClubId;
  final Value<int> playerId;
  final Value<int> needId;
  final Value<int> offerAmount;
  final Value<int> proposedSalary;
  final Value<int> contractYears;
  final Value<int> season;
  final Value<int> createdAtWeek;
  final Value<String> status;
  const TransferOffersCompanion({
    this.id = const Value.absent(),
    this.fromClubId = const Value.absent(),
    this.toClubId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.needId = const Value.absent(),
    this.offerAmount = const Value.absent(),
    this.proposedSalary = const Value.absent(),
    this.contractYears = const Value.absent(),
    this.season = const Value.absent(),
    this.createdAtWeek = const Value.absent(),
    this.status = const Value.absent(),
  });
  TransferOffersCompanion.insert({
    this.id = const Value.absent(),
    required int fromClubId,
    required int toClubId,
    required int playerId,
    required int needId,
    required int offerAmount,
    required int proposedSalary,
    required int contractYears,
    this.season = const Value.absent(),
    required int createdAtWeek,
    this.status = const Value.absent(),
  }) : fromClubId = Value(fromClubId),
       toClubId = Value(toClubId),
       playerId = Value(playerId),
       needId = Value(needId),
       offerAmount = Value(offerAmount),
       proposedSalary = Value(proposedSalary),
       contractYears = Value(contractYears),
       createdAtWeek = Value(createdAtWeek);
  static Insertable<TransferOffer> custom({
    Expression<int>? id,
    Expression<int>? fromClubId,
    Expression<int>? toClubId,
    Expression<int>? playerId,
    Expression<int>? needId,
    Expression<int>? offerAmount,
    Expression<int>? proposedSalary,
    Expression<int>? contractYears,
    Expression<int>? season,
    Expression<int>? createdAtWeek,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromClubId != null) 'from_club_id': fromClubId,
      if (toClubId != null) 'to_club_id': toClubId,
      if (playerId != null) 'player_id': playerId,
      if (needId != null) 'need_id': needId,
      if (offerAmount != null) 'offer_amount': offerAmount,
      if (proposedSalary != null) 'proposed_salary': proposedSalary,
      if (contractYears != null) 'contract_years': contractYears,
      if (season != null) 'season': season,
      if (createdAtWeek != null) 'created_at_week': createdAtWeek,
      if (status != null) 'status': status,
    });
  }

  TransferOffersCompanion copyWith({
    Value<int>? id,
    Value<int>? fromClubId,
    Value<int>? toClubId,
    Value<int>? playerId,
    Value<int>? needId,
    Value<int>? offerAmount,
    Value<int>? proposedSalary,
    Value<int>? contractYears,
    Value<int>? season,
    Value<int>? createdAtWeek,
    Value<String>? status,
  }) {
    return TransferOffersCompanion(
      id: id ?? this.id,
      fromClubId: fromClubId ?? this.fromClubId,
      toClubId: toClubId ?? this.toClubId,
      playerId: playerId ?? this.playerId,
      needId: needId ?? this.needId,
      offerAmount: offerAmount ?? this.offerAmount,
      proposedSalary: proposedSalary ?? this.proposedSalary,
      contractYears: contractYears ?? this.contractYears,
      season: season ?? this.season,
      createdAtWeek: createdAtWeek ?? this.createdAtWeek,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromClubId.present) {
      map['from_club_id'] = Variable<int>(fromClubId.value);
    }
    if (toClubId.present) {
      map['to_club_id'] = Variable<int>(toClubId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (needId.present) {
      map['need_id'] = Variable<int>(needId.value);
    }
    if (offerAmount.present) {
      map['offer_amount'] = Variable<int>(offerAmount.value);
    }
    if (proposedSalary.present) {
      map['proposed_salary'] = Variable<int>(proposedSalary.value);
    }
    if (contractYears.present) {
      map['contract_years'] = Variable<int>(contractYears.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (createdAtWeek.present) {
      map['created_at_week'] = Variable<int>(createdAtWeek.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransferOffersCompanion(')
          ..write('id: $id, ')
          ..write('fromClubId: $fromClubId, ')
          ..write('toClubId: $toClubId, ')
          ..write('playerId: $playerId, ')
          ..write('needId: $needId, ')
          ..write('offerAmount: $offerAmount, ')
          ..write('proposedSalary: $proposedSalary, ')
          ..write('contractYears: $contractYears, ')
          ..write('season: $season, ')
          ..write('createdAtWeek: $createdAtWeek, ')
          ..write('status: $status')
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

class $MatchesTable extends Matches with TableInfo<$MatchesTable, Matche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _homeClubIdMeta = const VerificationMeta(
    'homeClubId',
  );
  @override
  late final GeneratedColumn<int> homeClubId = GeneratedColumn<int>(
    'home_club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
  );
  static const VerificationMeta _awayClubIdMeta = const VerificationMeta(
    'awayClubId',
  );
  @override
  late final GeneratedColumn<int> awayClubId = GeneratedColumn<int>(
    'away_club_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clubs (id)',
    ),
  );
  static const VerificationMeta _homeScoreMeta = const VerificationMeta(
    'homeScore',
  );
  @override
  late final GeneratedColumn<int> homeScore = GeneratedColumn<int>(
    'home_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _awayScoreMeta = const VerificationMeta(
    'awayScore',
  );
  @override
  late final GeneratedColumn<int> awayScore = GeneratedColumn<int>(
    'away_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekMeta = const VerificationMeta('week');
  @override
  late final GeneratedColumn<int> week = GeneratedColumn<int>(
    'week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPlayedMeta = const VerificationMeta(
    'isPlayed',
  );
  @override
  late final GeneratedColumn<bool> isPlayed = GeneratedColumn<bool>(
    'is_played',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_played" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    homeClubId,
    awayClubId,
    homeScore,
    awayScore,
    season,
    week,
    isPlayed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Matche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('home_club_id')) {
      context.handle(
        _homeClubIdMeta,
        homeClubId.isAcceptableOrUnknown(
          data['home_club_id']!,
          _homeClubIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeClubIdMeta);
    }
    if (data.containsKey('away_club_id')) {
      context.handle(
        _awayClubIdMeta,
        awayClubId.isAcceptableOrUnknown(
          data['away_club_id']!,
          _awayClubIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_awayClubIdMeta);
    }
    if (data.containsKey('home_score')) {
      context.handle(
        _homeScoreMeta,
        homeScore.isAcceptableOrUnknown(data['home_score']!, _homeScoreMeta),
      );
    }
    if (data.containsKey('away_score')) {
      context.handle(
        _awayScoreMeta,
        awayScore.isAcceptableOrUnknown(data['away_score']!, _awayScoreMeta),
      );
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonMeta);
    }
    if (data.containsKey('week')) {
      context.handle(
        _weekMeta,
        week.isAcceptableOrUnknown(data['week']!, _weekMeta),
      );
    } else if (isInserting) {
      context.missing(_weekMeta);
    }
    if (data.containsKey('is_played')) {
      context.handle(
        _isPlayedMeta,
        isPlayed.isAcceptableOrUnknown(data['is_played']!, _isPlayedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Matche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Matche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      homeClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_club_id'],
      )!,
      awayClubId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}away_club_id'],
      )!,
      homeScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_score'],
      ),
      awayScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}away_score'],
      ),
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      )!,
      week: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week'],
      )!,
      isPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_played'],
      )!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class Matche extends DataClass implements Insertable<Matche> {
  final int id;
  final int homeClubId;
  final int awayClubId;
  final int? homeScore;
  final int? awayScore;
  final int season;
  final int week;
  final bool isPlayed;
  const Matche({
    required this.id,
    required this.homeClubId,
    required this.awayClubId,
    this.homeScore,
    this.awayScore,
    required this.season,
    required this.week,
    required this.isPlayed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['home_club_id'] = Variable<int>(homeClubId);
    map['away_club_id'] = Variable<int>(awayClubId);
    if (!nullToAbsent || homeScore != null) {
      map['home_score'] = Variable<int>(homeScore);
    }
    if (!nullToAbsent || awayScore != null) {
      map['away_score'] = Variable<int>(awayScore);
    }
    map['season'] = Variable<int>(season);
    map['week'] = Variable<int>(week);
    map['is_played'] = Variable<bool>(isPlayed);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      homeClubId: Value(homeClubId),
      awayClubId: Value(awayClubId),
      homeScore: homeScore == null && nullToAbsent
          ? const Value.absent()
          : Value(homeScore),
      awayScore: awayScore == null && nullToAbsent
          ? const Value.absent()
          : Value(awayScore),
      season: Value(season),
      week: Value(week),
      isPlayed: Value(isPlayed),
    );
  }

  factory Matche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Matche(
      id: serializer.fromJson<int>(json['id']),
      homeClubId: serializer.fromJson<int>(json['homeClubId']),
      awayClubId: serializer.fromJson<int>(json['awayClubId']),
      homeScore: serializer.fromJson<int?>(json['homeScore']),
      awayScore: serializer.fromJson<int?>(json['awayScore']),
      season: serializer.fromJson<int>(json['season']),
      week: serializer.fromJson<int>(json['week']),
      isPlayed: serializer.fromJson<bool>(json['isPlayed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'homeClubId': serializer.toJson<int>(homeClubId),
      'awayClubId': serializer.toJson<int>(awayClubId),
      'homeScore': serializer.toJson<int?>(homeScore),
      'awayScore': serializer.toJson<int?>(awayScore),
      'season': serializer.toJson<int>(season),
      'week': serializer.toJson<int>(week),
      'isPlayed': serializer.toJson<bool>(isPlayed),
    };
  }

  Matche copyWith({
    int? id,
    int? homeClubId,
    int? awayClubId,
    Value<int?> homeScore = const Value.absent(),
    Value<int?> awayScore = const Value.absent(),
    int? season,
    int? week,
    bool? isPlayed,
  }) => Matche(
    id: id ?? this.id,
    homeClubId: homeClubId ?? this.homeClubId,
    awayClubId: awayClubId ?? this.awayClubId,
    homeScore: homeScore.present ? homeScore.value : this.homeScore,
    awayScore: awayScore.present ? awayScore.value : this.awayScore,
    season: season ?? this.season,
    week: week ?? this.week,
    isPlayed: isPlayed ?? this.isPlayed,
  );
  Matche copyWithCompanion(MatchesCompanion data) {
    return Matche(
      id: data.id.present ? data.id.value : this.id,
      homeClubId: data.homeClubId.present
          ? data.homeClubId.value
          : this.homeClubId,
      awayClubId: data.awayClubId.present
          ? data.awayClubId.value
          : this.awayClubId,
      homeScore: data.homeScore.present ? data.homeScore.value : this.homeScore,
      awayScore: data.awayScore.present ? data.awayScore.value : this.awayScore,
      season: data.season.present ? data.season.value : this.season,
      week: data.week.present ? data.week.value : this.week,
      isPlayed: data.isPlayed.present ? data.isPlayed.value : this.isPlayed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Matche(')
          ..write('id: $id, ')
          ..write('homeClubId: $homeClubId, ')
          ..write('awayClubId: $awayClubId, ')
          ..write('homeScore: $homeScore, ')
          ..write('awayScore: $awayScore, ')
          ..write('season: $season, ')
          ..write('week: $week, ')
          ..write('isPlayed: $isPlayed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    homeClubId,
    awayClubId,
    homeScore,
    awayScore,
    season,
    week,
    isPlayed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Matche &&
          other.id == this.id &&
          other.homeClubId == this.homeClubId &&
          other.awayClubId == this.awayClubId &&
          other.homeScore == this.homeScore &&
          other.awayScore == this.awayScore &&
          other.season == this.season &&
          other.week == this.week &&
          other.isPlayed == this.isPlayed);
}

class MatchesCompanion extends UpdateCompanion<Matche> {
  final Value<int> id;
  final Value<int> homeClubId;
  final Value<int> awayClubId;
  final Value<int?> homeScore;
  final Value<int?> awayScore;
  final Value<int> season;
  final Value<int> week;
  final Value<bool> isPlayed;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.homeClubId = const Value.absent(),
    this.awayClubId = const Value.absent(),
    this.homeScore = const Value.absent(),
    this.awayScore = const Value.absent(),
    this.season = const Value.absent(),
    this.week = const Value.absent(),
    this.isPlayed = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required int homeClubId,
    required int awayClubId,
    this.homeScore = const Value.absent(),
    this.awayScore = const Value.absent(),
    required int season,
    required int week,
    this.isPlayed = const Value.absent(),
  }) : homeClubId = Value(homeClubId),
       awayClubId = Value(awayClubId),
       season = Value(season),
       week = Value(week);
  static Insertable<Matche> custom({
    Expression<int>? id,
    Expression<int>? homeClubId,
    Expression<int>? awayClubId,
    Expression<int>? homeScore,
    Expression<int>? awayScore,
    Expression<int>? season,
    Expression<int>? week,
    Expression<bool>? isPlayed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (homeClubId != null) 'home_club_id': homeClubId,
      if (awayClubId != null) 'away_club_id': awayClubId,
      if (homeScore != null) 'home_score': homeScore,
      if (awayScore != null) 'away_score': awayScore,
      if (season != null) 'season': season,
      if (week != null) 'week': week,
      if (isPlayed != null) 'is_played': isPlayed,
    });
  }

  MatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? homeClubId,
    Value<int>? awayClubId,
    Value<int?>? homeScore,
    Value<int?>? awayScore,
    Value<int>? season,
    Value<int>? week,
    Value<bool>? isPlayed,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      homeClubId: homeClubId ?? this.homeClubId,
      awayClubId: awayClubId ?? this.awayClubId,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      season: season ?? this.season,
      week: week ?? this.week,
      isPlayed: isPlayed ?? this.isPlayed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (homeClubId.present) {
      map['home_club_id'] = Variable<int>(homeClubId.value);
    }
    if (awayClubId.present) {
      map['away_club_id'] = Variable<int>(awayClubId.value);
    }
    if (homeScore.present) {
      map['home_score'] = Variable<int>(homeScore.value);
    }
    if (awayScore.present) {
      map['away_score'] = Variable<int>(awayScore.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (week.present) {
      map['week'] = Variable<int>(week.value);
    }
    if (isPlayed.present) {
      map['is_played'] = Variable<bool>(isPlayed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('homeClubId: $homeClubId, ')
          ..write('awayClubId: $awayClubId, ')
          ..write('homeScore: $homeScore, ')
          ..write('awayScore: $awayScore, ')
          ..write('season: $season, ')
          ..write('week: $week, ')
          ..write('isPlayed: $isPlayed')
          ..write(')'))
        .toString();
  }
}

class $PerformancesTable extends Performances
    with TableInfo<$PerformancesTable, Performance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PerformancesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matches (id)',
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
  static const VerificationMeta _minutesPlayedMeta = const VerificationMeta(
    'minutesPlayed',
  );
  @override
  late final GeneratedColumn<int> minutesPlayed = GeneratedColumn<int>(
    'minutes_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
  @override
  late final GeneratedColumn<int> goals = GeneratedColumn<int>(
    'goals',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _assistsMeta = const VerificationMeta(
    'assists',
  );
  @override
  late final GeneratedColumn<int> assists = GeneratedColumn<int>(
    'assists',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _yellowCardsMeta = const VerificationMeta(
    'yellowCards',
  );
  @override
  late final GeneratedColumn<int> yellowCards = GeneratedColumn<int>(
    'yellow_cards',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _redCardsMeta = const VerificationMeta(
    'redCards',
  );
  @override
  late final GeneratedColumn<int> redCards = GeneratedColumn<int>(
    'red_cards',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    playerId,
    minutesPlayed,
    goals,
    assists,
    yellowCards,
    redCards,
    season,
    rating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'performances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Performance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('minutes_played')) {
      context.handle(
        _minutesPlayedMeta,
        minutesPlayed.isAcceptableOrUnknown(
          data['minutes_played']!,
          _minutesPlayedMeta,
        ),
      );
    }
    if (data.containsKey('goals')) {
      context.handle(
        _goalsMeta,
        goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta),
      );
    }
    if (data.containsKey('assists')) {
      context.handle(
        _assistsMeta,
        assists.isAcceptableOrUnknown(data['assists']!, _assistsMeta),
      );
    }
    if (data.containsKey('yellow_cards')) {
      context.handle(
        _yellowCardsMeta,
        yellowCards.isAcceptableOrUnknown(
          data['yellow_cards']!,
          _yellowCardsMeta,
        ),
      );
    }
    if (data.containsKey('red_cards')) {
      context.handle(
        _redCardsMeta,
        redCards.isAcceptableOrUnknown(data['red_cards']!, _redCardsMeta),
      );
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Performance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Performance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      minutesPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes_played'],
      )!,
      goals: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goals'],
      )!,
      assists: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assists'],
      )!,
      yellowCards: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}yellow_cards'],
      )!,
      redCards: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}red_cards'],
      )!,
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
    );
  }

  @override
  $PerformancesTable createAlias(String alias) {
    return $PerformancesTable(attachedDatabase, alias);
  }
}

class Performance extends DataClass implements Insertable<Performance> {
  final int id;
  final int matchId;
  final int playerId;
  final int minutesPlayed;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final int season;
  final double rating;
  const Performance({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.minutesPlayed,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.season,
    required this.rating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['player_id'] = Variable<int>(playerId);
    map['minutes_played'] = Variable<int>(minutesPlayed);
    map['goals'] = Variable<int>(goals);
    map['assists'] = Variable<int>(assists);
    map['yellow_cards'] = Variable<int>(yellowCards);
    map['red_cards'] = Variable<int>(redCards);
    map['season'] = Variable<int>(season);
    map['rating'] = Variable<double>(rating);
    return map;
  }

  PerformancesCompanion toCompanion(bool nullToAbsent) {
    return PerformancesCompanion(
      id: Value(id),
      matchId: Value(matchId),
      playerId: Value(playerId),
      minutesPlayed: Value(minutesPlayed),
      goals: Value(goals),
      assists: Value(assists),
      yellowCards: Value(yellowCards),
      redCards: Value(redCards),
      season: Value(season),
      rating: Value(rating),
    );
  }

  factory Performance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Performance(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      minutesPlayed: serializer.fromJson<int>(json['minutesPlayed']),
      goals: serializer.fromJson<int>(json['goals']),
      assists: serializer.fromJson<int>(json['assists']),
      yellowCards: serializer.fromJson<int>(json['yellowCards']),
      redCards: serializer.fromJson<int>(json['redCards']),
      season: serializer.fromJson<int>(json['season']),
      rating: serializer.fromJson<double>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'playerId': serializer.toJson<int>(playerId),
      'minutesPlayed': serializer.toJson<int>(minutesPlayed),
      'goals': serializer.toJson<int>(goals),
      'assists': serializer.toJson<int>(assists),
      'yellowCards': serializer.toJson<int>(yellowCards),
      'redCards': serializer.toJson<int>(redCards),
      'season': serializer.toJson<int>(season),
      'rating': serializer.toJson<double>(rating),
    };
  }

  Performance copyWith({
    int? id,
    int? matchId,
    int? playerId,
    int? minutesPlayed,
    int? goals,
    int? assists,
    int? yellowCards,
    int? redCards,
    int? season,
    double? rating,
  }) => Performance(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    playerId: playerId ?? this.playerId,
    minutesPlayed: minutesPlayed ?? this.minutesPlayed,
    goals: goals ?? this.goals,
    assists: assists ?? this.assists,
    yellowCards: yellowCards ?? this.yellowCards,
    redCards: redCards ?? this.redCards,
    season: season ?? this.season,
    rating: rating ?? this.rating,
  );
  Performance copyWithCompanion(PerformancesCompanion data) {
    return Performance(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      minutesPlayed: data.minutesPlayed.present
          ? data.minutesPlayed.value
          : this.minutesPlayed,
      goals: data.goals.present ? data.goals.value : this.goals,
      assists: data.assists.present ? data.assists.value : this.assists,
      yellowCards: data.yellowCards.present
          ? data.yellowCards.value
          : this.yellowCards,
      redCards: data.redCards.present ? data.redCards.value : this.redCards,
      season: data.season.present ? data.season.value : this.season,
      rating: data.rating.present ? data.rating.value : this.rating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Performance(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('minutesPlayed: $minutesPlayed, ')
          ..write('goals: $goals, ')
          ..write('assists: $assists, ')
          ..write('yellowCards: $yellowCards, ')
          ..write('redCards: $redCards, ')
          ..write('season: $season, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    matchId,
    playerId,
    minutesPlayed,
    goals,
    assists,
    yellowCards,
    redCards,
    season,
    rating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Performance &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.playerId == this.playerId &&
          other.minutesPlayed == this.minutesPlayed &&
          other.goals == this.goals &&
          other.assists == this.assists &&
          other.yellowCards == this.yellowCards &&
          other.redCards == this.redCards &&
          other.season == this.season &&
          other.rating == this.rating);
}

class PerformancesCompanion extends UpdateCompanion<Performance> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> playerId;
  final Value<int> minutesPlayed;
  final Value<int> goals;
  final Value<int> assists;
  final Value<int> yellowCards;
  final Value<int> redCards;
  final Value<int> season;
  final Value<double> rating;
  const PerformancesCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.minutesPlayed = const Value.absent(),
    this.goals = const Value.absent(),
    this.assists = const Value.absent(),
    this.yellowCards = const Value.absent(),
    this.redCards = const Value.absent(),
    this.season = const Value.absent(),
    this.rating = const Value.absent(),
  });
  PerformancesCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int playerId,
    this.minutesPlayed = const Value.absent(),
    this.goals = const Value.absent(),
    this.assists = const Value.absent(),
    this.yellowCards = const Value.absent(),
    this.redCards = const Value.absent(),
    this.season = const Value.absent(),
    this.rating = const Value.absent(),
  }) : matchId = Value(matchId),
       playerId = Value(playerId);
  static Insertable<Performance> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? playerId,
    Expression<int>? minutesPlayed,
    Expression<int>? goals,
    Expression<int>? assists,
    Expression<int>? yellowCards,
    Expression<int>? redCards,
    Expression<int>? season,
    Expression<double>? rating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (playerId != null) 'player_id': playerId,
      if (minutesPlayed != null) 'minutes_played': minutesPlayed,
      if (goals != null) 'goals': goals,
      if (assists != null) 'assists': assists,
      if (yellowCards != null) 'yellow_cards': yellowCards,
      if (redCards != null) 'red_cards': redCards,
      if (season != null) 'season': season,
      if (rating != null) 'rating': rating,
    });
  }

  PerformancesCompanion copyWith({
    Value<int>? id,
    Value<int>? matchId,
    Value<int>? playerId,
    Value<int>? minutesPlayed,
    Value<int>? goals,
    Value<int>? assists,
    Value<int>? yellowCards,
    Value<int>? redCards,
    Value<int>? season,
    Value<double>? rating,
  }) {
    return PerformancesCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      minutesPlayed: minutesPlayed ?? this.minutesPlayed,
      goals: goals ?? this.goals,
      assists: assists ?? this.assists,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
      season: season ?? this.season,
      rating: rating ?? this.rating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (minutesPlayed.present) {
      map['minutes_played'] = Variable<int>(minutesPlayed.value);
    }
    if (goals.present) {
      map['goals'] = Variable<int>(goals.value);
    }
    if (assists.present) {
      map['assists'] = Variable<int>(assists.value);
    }
    if (yellowCards.present) {
      map['yellow_cards'] = Variable<int>(yellowCards.value);
    }
    if (redCards.present) {
      map['red_cards'] = Variable<int>(redCards.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PerformancesCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('playerId: $playerId, ')
          ..write('minutesPlayed: $minutesPlayed, ')
          ..write('goals: $goals, ')
          ..write('assists: $assists, ')
          ..write('yellowCards: $yellowCards, ')
          ..write('redCards: $redCards, ')
          ..write('season: $season, ')
          ..write('rating: $rating')
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
  late final $PlayersTable players = $PlayersTable(this);
  late final $AgentContractsTable agentContracts = $AgentContractsTable(this);
  late final $ClubContractsTable clubContracts = $ClubContractsTable(this);
  late final $TransfersTable transfers = $TransfersTable(this);
  late final $TransferNeedsTable transferNeeds = $TransferNeedsTable(this);
  late final $TransferOffersTable transferOffers = $TransferOffersTable(this);
  late final $ValueHistoriesTable valueHistories = $ValueHistoriesTable(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $CountriesTable countries = $CountriesTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $PerformancesTable performances = $PerformancesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    leagues,
    clubs,
    agents,
    players,
    agentContracts,
    clubContracts,
    transfers,
    transferNeeds,
    transferOffers,
    valueHistories,
    relationships,
    countries,
    matches,
    performances,
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

  static MultiTypedResultKey<$ClubContractsTable, List<ClubContract>>
  _clubContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.clubContracts,
    aliasName: $_aliasNameGenerator(db.clubs.id, db.clubContracts.clubId),
  );

  $$ClubContractsTableProcessedTableManager get clubContractsRefs {
    final manager = $$ClubContractsTableTableManager(
      $_db,
      $_db.clubContracts,
    ).filter((f) => f.clubId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_clubContractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransferNeedsTable, List<TransferNeed>>
  _transferNeedsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transferNeeds,
    aliasName: $_aliasNameGenerator(db.clubs.id, db.transferNeeds.clubId),
  );

  $$TransferNeedsTableProcessedTableManager get transferNeedsRefs {
    final manager = $$TransferNeedsTableTableManager(
      $_db,
      $_db.transferNeeds,
    ).filter((f) => f.clubId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transferNeedsRefsTable($_db));
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

  Expression<bool> clubContractsRefs(
    Expression<bool> Function($$ClubContractsTableFilterComposer f) f,
  ) {
    final $$ClubContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubContracts,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubContractsTableFilterComposer(
            $db: $db,
            $table: $db.clubContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transferNeedsRefs(
    Expression<bool> Function($$TransferNeedsTableFilterComposer f) f,
  ) {
    final $$TransferNeedsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableFilterComposer(
            $db: $db,
            $table: $db.transferNeeds,
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

  Expression<T> clubContractsRefs<T extends Object>(
    Expression<T> Function($$ClubContractsTableAnnotationComposer a) f,
  ) {
    final $$ClubContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubContracts,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transferNeedsRefs<T extends Object>(
    Expression<T> Function($$TransferNeedsTableAnnotationComposer a) f,
  ) {
    final $$TransferNeedsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.clubId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableAnnotationComposer(
            $db: $db,
            $table: $db.transferNeeds,
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
          PrefetchHooks Function({
            bool leagueId,
            bool playersRefs,
            bool clubContractsRefs,
            bool transferNeedsRefs,
          })
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
          prefetchHooksCallback:
              ({
                leagueId = false,
                playersRefs = false,
                clubContractsRefs = false,
                transferNeedsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playersRefs) db.players,
                    if (clubContractsRefs) db.clubContracts,
                    if (transferNeedsRefs) db.transferNeeds,
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
                          referencedTable: $$ClubsTableReferences
                              ._playersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClubsTableReferences(db, table, p0).playersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clubId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (clubContractsRefs)
                        await $_getPrefetchedData<
                          Club,
                          $ClubsTable,
                          ClubContract
                        >(
                          currentTable: table,
                          referencedTable: $$ClubsTableReferences
                              ._clubContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClubsTableReferences(
                                db,
                                table,
                                p0,
                              ).clubContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clubId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transferNeedsRefs)
                        await $_getPrefetchedData<
                          Club,
                          $ClubsTable,
                          TransferNeed
                        >(
                          currentTable: table,
                          referencedTable: $$ClubsTableReferences
                              ._transferNeedsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClubsTableReferences(
                                db,
                                table,
                                p0,
                              ).transferNeedsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clubId == item.id,
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
      PrefetchHooks Function({
        bool leagueId,
        bool playersRefs,
        bool clubContractsRefs,
        bool transferNeedsRefs,
      })
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

  static MultiTypedResultKey<$AgentContractsTable, List<AgentContract>>
  _agentContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.agentContracts,
    aliasName: $_aliasNameGenerator(db.agents.id, db.agentContracts.agentId),
  );

  $$AgentContractsTableProcessedTableManager get agentContractsRefs {
    final manager = $$AgentContractsTableTableManager(
      $_db,
      $_db.agentContracts,
    ).filter((f) => f.agentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_agentContractsRefsTable($_db));
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

  Expression<bool> agentContractsRefs(
    Expression<bool> Function($$AgentContractsTableFilterComposer f) f,
  ) {
    final $$AgentContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentContracts,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentContractsTableFilterComposer(
            $db: $db,
            $table: $db.agentContracts,
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

  Expression<T> agentContractsRefs<T extends Object>(
    Expression<T> Function($$AgentContractsTableAnnotationComposer a) f,
  ) {
    final $$AgentContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentContracts,
      getReferencedColumn: (t) => t.agentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentContracts,
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
          PrefetchHooks Function({bool playersRefs, bool agentContractsRefs})
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
              ({playersRefs = false, agentContractsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playersRefs) db.players,
                    if (agentContractsRefs) db.agentContracts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
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
                      if (agentContractsRefs)
                        await $_getPrefetchedData<
                          Agent,
                          $AgentsTable,
                          AgentContract
                        >(
                          currentTable: table,
                          referencedTable: $$AgentsTableReferences
                              ._agentContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AgentsTableReferences(
                                db,
                                table,
                                p0,
                              ).agentContractsRefs,
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
      PrefetchHooks Function({bool playersRefs, bool agentContractsRefs})
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

  static MultiTypedResultKey<$AgentContractsTable, List<AgentContract>>
  _agentContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.agentContracts,
    aliasName: $_aliasNameGenerator(db.players.id, db.agentContracts.playerId),
  );

  $$AgentContractsTableProcessedTableManager get agentContractsRefs {
    final manager = $$AgentContractsTableTableManager(
      $_db,
      $_db.agentContracts,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_agentContractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClubContractsTable, List<ClubContract>>
  _clubContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.clubContracts,
    aliasName: $_aliasNameGenerator(db.players.id, db.clubContracts.playerId),
  );

  $$ClubContractsTableProcessedTableManager get clubContractsRefs {
    final manager = $$ClubContractsTableTableManager(
      $_db,
      $_db.clubContracts,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_clubContractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  static MultiTypedResultKey<$TransferNeedsTable, List<TransferNeed>>
  _transferNeedsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transferNeeds,
    aliasName: $_aliasNameGenerator(
      db.players.id,
      db.transferNeeds.playerToSellId,
    ),
  );

  $$TransferNeedsTableProcessedTableManager get transferNeedsRefs {
    final manager = $$TransferNeedsTableTableManager(
      $_db,
      $_db.transferNeeds,
    ).filter((f) => f.playerToSellId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transferNeedsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransferOffersTable, List<TransferOffer>>
  _transferOffersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transferOffers,
    aliasName: $_aliasNameGenerator(db.players.id, db.transferOffers.playerId),
  );

  $$TransferOffersTableProcessedTableManager get transferOffersRefs {
    final manager = $$TransferOffersTableTableManager(
      $_db,
      $_db.transferOffers,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transferOffersRefsTable($_db));
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

  static MultiTypedResultKey<$PerformancesTable, List<Performance>>
  _performancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.performances,
    aliasName: $_aliasNameGenerator(db.players.id, db.performances.playerId),
  );

  $$PerformancesTableProcessedTableManager get performancesRefs {
    final manager = $$PerformancesTableTableManager(
      $_db,
      $_db.performances,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_performancesRefsTable($_db));
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

  Expression<bool> agentContractsRefs(
    Expression<bool> Function($$AgentContractsTableFilterComposer f) f,
  ) {
    final $$AgentContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentContracts,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentContractsTableFilterComposer(
            $db: $db,
            $table: $db.agentContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> clubContractsRefs(
    Expression<bool> Function($$ClubContractsTableFilterComposer f) f,
  ) {
    final $$ClubContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubContracts,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubContractsTableFilterComposer(
            $db: $db,
            $table: $db.clubContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  Expression<bool> transferNeedsRefs(
    Expression<bool> Function($$TransferNeedsTableFilterComposer f) f,
  ) {
    final $$TransferNeedsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.playerToSellId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableFilterComposer(
            $db: $db,
            $table: $db.transferNeeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transferOffersRefs(
    Expression<bool> Function($$TransferOffersTableFilterComposer f) f,
  ) {
    final $$TransferOffersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferOffers,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferOffersTableFilterComposer(
            $db: $db,
            $table: $db.transferOffers,
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

  Expression<bool> performancesRefs(
    Expression<bool> Function($$PerformancesTableFilterComposer f) f,
  ) {
    final $$PerformancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.performances,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerformancesTableFilterComposer(
            $db: $db,
            $table: $db.performances,
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

  Expression<T> agentContractsRefs<T extends Object>(
    Expression<T> Function($$AgentContractsTableAnnotationComposer a) f,
  ) {
    final $$AgentContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentContracts,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> clubContractsRefs<T extends Object>(
    Expression<T> Function($$ClubContractsTableAnnotationComposer a) f,
  ) {
    final $$ClubContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clubContracts,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClubContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.clubContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  Expression<T> transferNeedsRefs<T extends Object>(
    Expression<T> Function($$TransferNeedsTableAnnotationComposer a) f,
  ) {
    final $$TransferNeedsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.playerToSellId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableAnnotationComposer(
            $db: $db,
            $table: $db.transferNeeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transferOffersRefs<T extends Object>(
    Expression<T> Function($$TransferOffersTableAnnotationComposer a) f,
  ) {
    final $$TransferOffersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferOffers,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferOffersTableAnnotationComposer(
            $db: $db,
            $table: $db.transferOffers,
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

  Expression<T> performancesRefs<T extends Object>(
    Expression<T> Function($$PerformancesTableAnnotationComposer a) f,
  ) {
    final $$PerformancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.performances,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerformancesTableAnnotationComposer(
            $db: $db,
            $table: $db.performances,
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
            bool agentContractsRefs,
            bool clubContractsRefs,
            bool transfersRefs,
            bool transferNeedsRefs,
            bool transferOffersRefs,
            bool valueHistoriesRefs,
            bool performancesRefs,
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
                agentContractsRefs = false,
                clubContractsRefs = false,
                transfersRefs = false,
                transferNeedsRefs = false,
                transferOffersRefs = false,
                valueHistoriesRefs = false,
                performancesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (agentContractsRefs) db.agentContracts,
                    if (clubContractsRefs) db.clubContracts,
                    if (transfersRefs) db.transfers,
                    if (transferNeedsRefs) db.transferNeeds,
                    if (transferOffersRefs) db.transferOffers,
                    if (valueHistoriesRefs) db.valueHistories,
                    if (performancesRefs) db.performances,
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

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (agentContractsRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          AgentContract
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._agentContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).agentContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (clubContractsRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          ClubContract
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._clubContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).clubContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
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
                      if (transferNeedsRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TransferNeed
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._transferNeedsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).transferNeedsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerToSellId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transferOffersRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TransferOffer
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._transferOffersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).transferOffersRefs,
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
                      if (performancesRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          Performance
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._performancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).performancesRefs,
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
        bool agentContractsRefs,
        bool clubContractsRefs,
        bool transfersRefs,
        bool transferNeedsRefs,
        bool transferOffersRefs,
        bool valueHistoriesRefs,
        bool performancesRefs,
      })
    >;
typedef $$AgentContractsTableCreateCompanionBuilder =
    AgentContractsCompanion Function({
      Value<int> id,
      required int agentId,
      required int playerId,
      required DateTime startDate,
      required DateTime endDate,
      Value<double> feePercentage,
      required double wage,
      required double releaseClause,
      required String status,
    });
typedef $$AgentContractsTableUpdateCompanionBuilder =
    AgentContractsCompanion Function({
      Value<int> id,
      Value<int> agentId,
      Value<int> playerId,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<double> feePercentage,
      Value<double> wage,
      Value<double> releaseClause,
      Value<String> status,
    });

final class $$AgentContractsTableReferences
    extends BaseReferences<_$AppDatabase, $AgentContractsTable, AgentContract> {
  $$AgentContractsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AgentsTable _agentIdTable(_$AppDatabase db) => db.agents.createAlias(
    $_aliasNameGenerator(db.agentContracts.agentId, db.agents.id),
  );

  $$AgentsTableProcessedTableManager get agentId {
    final $_column = $_itemColumn<int>('agent_id')!;

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

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.agentContracts.playerId, db.players.id),
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

class $$AgentContractsTableFilterComposer
    extends Composer<_$AppDatabase, $AgentContractsTable> {
  $$AgentContractsTableFilterComposer({
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

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feePercentage => $composableBuilder(
    column: $table.feePercentage,
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

class $$AgentContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $AgentContractsTable> {
  $$AgentContractsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feePercentage => $composableBuilder(
    column: $table.feePercentage,
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

class $$AgentContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgentContractsTable> {
  $$AgentContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get feePercentage => $composableBuilder(
    column: $table.feePercentage,
    builder: (column) => column,
  );

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

class $$AgentContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgentContractsTable,
          AgentContract,
          $$AgentContractsTableFilterComposer,
          $$AgentContractsTableOrderingComposer,
          $$AgentContractsTableAnnotationComposer,
          $$AgentContractsTableCreateCompanionBuilder,
          $$AgentContractsTableUpdateCompanionBuilder,
          (AgentContract, $$AgentContractsTableReferences),
          AgentContract,
          PrefetchHooks Function({bool agentId, bool playerId})
        > {
  $$AgentContractsTableTableManager(
    _$AppDatabase db,
    $AgentContractsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> agentId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<double> feePercentage = const Value.absent(),
                Value<double> wage = const Value.absent(),
                Value<double> releaseClause = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => AgentContractsCompanion(
                id: id,
                agentId: agentId,
                playerId: playerId,
                startDate: startDate,
                endDate: endDate,
                feePercentage: feePercentage,
                wage: wage,
                releaseClause: releaseClause,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int agentId,
                required int playerId,
                required DateTime startDate,
                required DateTime endDate,
                Value<double> feePercentage = const Value.absent(),
                required double wage,
                required double releaseClause,
                required String status,
              }) => AgentContractsCompanion.insert(
                id: id,
                agentId: agentId,
                playerId: playerId,
                startDate: startDate,
                endDate: endDate,
                feePercentage: feePercentage,
                wage: wage,
                releaseClause: releaseClause,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AgentContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({agentId = false, playerId = false}) {
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
                    if (agentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.agentId,
                                referencedTable: $$AgentContractsTableReferences
                                    ._agentIdTable(db),
                                referencedColumn:
                                    $$AgentContractsTableReferences
                                        ._agentIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$AgentContractsTableReferences
                                    ._playerIdTable(db),
                                referencedColumn:
                                    $$AgentContractsTableReferences
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

typedef $$AgentContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgentContractsTable,
      AgentContract,
      $$AgentContractsTableFilterComposer,
      $$AgentContractsTableOrderingComposer,
      $$AgentContractsTableAnnotationComposer,
      $$AgentContractsTableCreateCompanionBuilder,
      $$AgentContractsTableUpdateCompanionBuilder,
      (AgentContract, $$AgentContractsTableReferences),
      AgentContract,
      PrefetchHooks Function({bool agentId, bool playerId})
    >;
typedef $$ClubContractsTableCreateCompanionBuilder =
    ClubContractsCompanion Function({
      Value<int> id,
      required int clubId,
      required int playerId,
      required int weeklySalary,
      Value<int?> releaseClause,
      required DateTime startDate,
      required DateTime endDate,
      Value<String> status,
    });
typedef $$ClubContractsTableUpdateCompanionBuilder =
    ClubContractsCompanion Function({
      Value<int> id,
      Value<int> clubId,
      Value<int> playerId,
      Value<int> weeklySalary,
      Value<int?> releaseClause,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> status,
    });

final class $$ClubContractsTableReferences
    extends BaseReferences<_$AppDatabase, $ClubContractsTable, ClubContract> {
  $$ClubContractsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClubsTable _clubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.clubContracts.clubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get clubId {
    final $_column = $_itemColumn<int>('club_id')!;

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

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.clubContracts.playerId, db.players.id),
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

class $$ClubContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ClubContractsTable> {
  $$ClubContractsTableFilterComposer({
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

  ColumnFilters<int> get weeklySalary => $composableBuilder(
    column: $table.weeklySalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
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

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
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

class $$ClubContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClubContractsTable> {
  $$ClubContractsTableOrderingComposer({
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

  ColumnOrderings<int> get weeklySalary => $composableBuilder(
    column: $table.weeklySalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
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

class $$ClubContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClubContractsTable> {
  $$ClubContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weeklySalary => $composableBuilder(
    column: $table.weeklySalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get releaseClause => $composableBuilder(
    column: $table.releaseClause,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

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

class $$ClubContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClubContractsTable,
          ClubContract,
          $$ClubContractsTableFilterComposer,
          $$ClubContractsTableOrderingComposer,
          $$ClubContractsTableAnnotationComposer,
          $$ClubContractsTableCreateCompanionBuilder,
          $$ClubContractsTableUpdateCompanionBuilder,
          (ClubContract, $$ClubContractsTableReferences),
          ClubContract,
          PrefetchHooks Function({bool clubId, bool playerId})
        > {
  $$ClubContractsTableTableManager(_$AppDatabase db, $ClubContractsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClubContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClubContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClubContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clubId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> weeklySalary = const Value.absent(),
                Value<int?> releaseClause = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => ClubContractsCompanion(
                id: id,
                clubId: clubId,
                playerId: playerId,
                weeklySalary: weeklySalary,
                releaseClause: releaseClause,
                startDate: startDate,
                endDate: endDate,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clubId,
                required int playerId,
                required int weeklySalary,
                Value<int?> releaseClause = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                Value<String> status = const Value.absent(),
              }) => ClubContractsCompanion.insert(
                id: id,
                clubId: clubId,
                playerId: playerId,
                weeklySalary: weeklySalary,
                releaseClause: releaseClause,
                startDate: startDate,
                endDate: endDate,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClubContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clubId = false, playerId = false}) {
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
                    if (clubId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clubId,
                                referencedTable: $$ClubContractsTableReferences
                                    ._clubIdTable(db),
                                referencedColumn: $$ClubContractsTableReferences
                                    ._clubIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$ClubContractsTableReferences
                                    ._playerIdTable(db),
                                referencedColumn: $$ClubContractsTableReferences
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

typedef $$ClubContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClubContractsTable,
      ClubContract,
      $$ClubContractsTableFilterComposer,
      $$ClubContractsTableOrderingComposer,
      $$ClubContractsTableAnnotationComposer,
      $$ClubContractsTableCreateCompanionBuilder,
      $$ClubContractsTableUpdateCompanionBuilder,
      (ClubContract, $$ClubContractsTableReferences),
      ClubContract,
      PrefetchHooks Function({bool clubId, bool playerId})
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
      Value<int> season,
      Value<int> week,
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
      Value<int> season,
      Value<int> week,
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

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get week => $composableBuilder(
    column: $table.week,
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

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get week => $composableBuilder(
    column: $table.week,
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

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get week =>
      $composableBuilder(column: $table.week, builder: (column) => column);

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
                Value<int> season = const Value.absent(),
                Value<int> week = const Value.absent(),
              }) => TransfersCompanion(
                id: id,
                playerId: playerId,
                fromClubId: fromClubId,
                toClubId: toClubId,
                date: date,
                feeAmount: feeAmount,
                type: type,
                season: season,
                week: week,
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
                Value<int> season = const Value.absent(),
                Value<int> week = const Value.absent(),
              }) => TransfersCompanion.insert(
                id: id,
                playerId: playerId,
                fromClubId: fromClubId,
                toClubId: toClubId,
                date: date,
                feeAmount: feeAmount,
                type: type,
                season: season,
                week: week,
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
typedef $$TransferNeedsTableCreateCompanionBuilder =
    TransferNeedsCompanion Function({
      Value<int> id,
      required int clubId,
      required String type,
      Value<String?> targetPosition,
      Value<int?> minAge,
      Value<int?> maxAge,
      Value<int?> minCa,
      Value<int?> maxTransferBudget,
      Value<int?> maxWeeklySalary,
      Value<int?> playerToSellId,
      Value<int?> minimumFee,
      Value<bool> isFulfilled,
    });
typedef $$TransferNeedsTableUpdateCompanionBuilder =
    TransferNeedsCompanion Function({
      Value<int> id,
      Value<int> clubId,
      Value<String> type,
      Value<String?> targetPosition,
      Value<int?> minAge,
      Value<int?> maxAge,
      Value<int?> minCa,
      Value<int?> maxTransferBudget,
      Value<int?> maxWeeklySalary,
      Value<int?> playerToSellId,
      Value<int?> minimumFee,
      Value<bool> isFulfilled,
    });

final class $$TransferNeedsTableReferences
    extends BaseReferences<_$AppDatabase, $TransferNeedsTable, TransferNeed> {
  $$TransferNeedsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClubsTable _clubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.transferNeeds.clubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get clubId {
    final $_column = $_itemColumn<int>('club_id')!;

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

  static $PlayersTable _playerToSellIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.transferNeeds.playerToSellId, db.players.id),
      );

  $$PlayersTableProcessedTableManager? get playerToSellId {
    final $_column = $_itemColumn<int>('player_to_sell_id');
    if ($_column == null) return null;
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerToSellIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransferOffersTable, List<TransferOffer>>
  _transferOffersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transferOffers,
    aliasName: $_aliasNameGenerator(
      db.transferNeeds.id,
      db.transferOffers.needId,
    ),
  );

  $$TransferOffersTableProcessedTableManager get transferOffersRefs {
    final manager = $$TransferOffersTableTableManager(
      $_db,
      $_db.transferOffers,
    ).filter((f) => f.needId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transferOffersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransferNeedsTableFilterComposer
    extends Composer<_$AppDatabase, $TransferNeedsTable> {
  $$TransferNeedsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetPosition => $composableBuilder(
    column: $table.targetPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minAge => $composableBuilder(
    column: $table.minAge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAge => $composableBuilder(
    column: $table.maxAge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minCa => $composableBuilder(
    column: $table.minCa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTransferBudget => $composableBuilder(
    column: $table.maxTransferBudget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxWeeklySalary => $composableBuilder(
    column: $table.maxWeeklySalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minimumFee => $composableBuilder(
    column: $table.minimumFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFulfilled => $composableBuilder(
    column: $table.isFulfilled,
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

  $$PlayersTableFilterComposer get playerToSellId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerToSellId,
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

  Expression<bool> transferOffersRefs(
    Expression<bool> Function($$TransferOffersTableFilterComposer f) f,
  ) {
    final $$TransferOffersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferOffers,
      getReferencedColumn: (t) => t.needId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferOffersTableFilterComposer(
            $db: $db,
            $table: $db.transferOffers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransferNeedsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransferNeedsTable> {
  $$TransferNeedsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetPosition => $composableBuilder(
    column: $table.targetPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minAge => $composableBuilder(
    column: $table.minAge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAge => $composableBuilder(
    column: $table.maxAge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minCa => $composableBuilder(
    column: $table.minCa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTransferBudget => $composableBuilder(
    column: $table.maxTransferBudget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxWeeklySalary => $composableBuilder(
    column: $table.maxWeeklySalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimumFee => $composableBuilder(
    column: $table.minimumFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFulfilled => $composableBuilder(
    column: $table.isFulfilled,
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

  $$PlayersTableOrderingComposer get playerToSellId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerToSellId,
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

class $$TransferNeedsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransferNeedsTable> {
  $$TransferNeedsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get targetPosition => $composableBuilder(
    column: $table.targetPosition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minAge =>
      $composableBuilder(column: $table.minAge, builder: (column) => column);

  GeneratedColumn<int> get maxAge =>
      $composableBuilder(column: $table.maxAge, builder: (column) => column);

  GeneratedColumn<int> get minCa =>
      $composableBuilder(column: $table.minCa, builder: (column) => column);

  GeneratedColumn<int> get maxTransferBudget => $composableBuilder(
    column: $table.maxTransferBudget,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxWeeklySalary => $composableBuilder(
    column: $table.maxWeeklySalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minimumFee => $composableBuilder(
    column: $table.minimumFee,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFulfilled => $composableBuilder(
    column: $table.isFulfilled,
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

  $$PlayersTableAnnotationComposer get playerToSellId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerToSellId,
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

  Expression<T> transferOffersRefs<T extends Object>(
    Expression<T> Function($$TransferOffersTableAnnotationComposer a) f,
  ) {
    final $$TransferOffersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferOffers,
      getReferencedColumn: (t) => t.needId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferOffersTableAnnotationComposer(
            $db: $db,
            $table: $db.transferOffers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransferNeedsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransferNeedsTable,
          TransferNeed,
          $$TransferNeedsTableFilterComposer,
          $$TransferNeedsTableOrderingComposer,
          $$TransferNeedsTableAnnotationComposer,
          $$TransferNeedsTableCreateCompanionBuilder,
          $$TransferNeedsTableUpdateCompanionBuilder,
          (TransferNeed, $$TransferNeedsTableReferences),
          TransferNeed,
          PrefetchHooks Function({
            bool clubId,
            bool playerToSellId,
            bool transferOffersRefs,
          })
        > {
  $$TransferNeedsTableTableManager(_$AppDatabase db, $TransferNeedsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransferNeedsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransferNeedsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransferNeedsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clubId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> targetPosition = const Value.absent(),
                Value<int?> minAge = const Value.absent(),
                Value<int?> maxAge = const Value.absent(),
                Value<int?> minCa = const Value.absent(),
                Value<int?> maxTransferBudget = const Value.absent(),
                Value<int?> maxWeeklySalary = const Value.absent(),
                Value<int?> playerToSellId = const Value.absent(),
                Value<int?> minimumFee = const Value.absent(),
                Value<bool> isFulfilled = const Value.absent(),
              }) => TransferNeedsCompanion(
                id: id,
                clubId: clubId,
                type: type,
                targetPosition: targetPosition,
                minAge: minAge,
                maxAge: maxAge,
                minCa: minCa,
                maxTransferBudget: maxTransferBudget,
                maxWeeklySalary: maxWeeklySalary,
                playerToSellId: playerToSellId,
                minimumFee: minimumFee,
                isFulfilled: isFulfilled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clubId,
                required String type,
                Value<String?> targetPosition = const Value.absent(),
                Value<int?> minAge = const Value.absent(),
                Value<int?> maxAge = const Value.absent(),
                Value<int?> minCa = const Value.absent(),
                Value<int?> maxTransferBudget = const Value.absent(),
                Value<int?> maxWeeklySalary = const Value.absent(),
                Value<int?> playerToSellId = const Value.absent(),
                Value<int?> minimumFee = const Value.absent(),
                Value<bool> isFulfilled = const Value.absent(),
              }) => TransferNeedsCompanion.insert(
                id: id,
                clubId: clubId,
                type: type,
                targetPosition: targetPosition,
                minAge: minAge,
                maxAge: maxAge,
                minCa: minCa,
                maxTransferBudget: maxTransferBudget,
                maxWeeklySalary: maxWeeklySalary,
                playerToSellId: playerToSellId,
                minimumFee: minimumFee,
                isFulfilled: isFulfilled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransferNeedsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clubId = false,
                playerToSellId = false,
                transferOffersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transferOffersRefs) db.transferOffers,
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
                                    referencedTable:
                                        $$TransferNeedsTableReferences
                                            ._clubIdTable(db),
                                    referencedColumn:
                                        $$TransferNeedsTableReferences
                                            ._clubIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerToSellId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerToSellId,
                                    referencedTable:
                                        $$TransferNeedsTableReferences
                                            ._playerToSellIdTable(db),
                                    referencedColumn:
                                        $$TransferNeedsTableReferences
                                            ._playerToSellIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transferOffersRefs)
                        await $_getPrefetchedData<
                          TransferNeed,
                          $TransferNeedsTable,
                          TransferOffer
                        >(
                          currentTable: table,
                          referencedTable: $$TransferNeedsTableReferences
                              ._transferOffersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransferNeedsTableReferences(
                                db,
                                table,
                                p0,
                              ).transferOffersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.needId == item.id,
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

typedef $$TransferNeedsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransferNeedsTable,
      TransferNeed,
      $$TransferNeedsTableFilterComposer,
      $$TransferNeedsTableOrderingComposer,
      $$TransferNeedsTableAnnotationComposer,
      $$TransferNeedsTableCreateCompanionBuilder,
      $$TransferNeedsTableUpdateCompanionBuilder,
      (TransferNeed, $$TransferNeedsTableReferences),
      TransferNeed,
      PrefetchHooks Function({
        bool clubId,
        bool playerToSellId,
        bool transferOffersRefs,
      })
    >;
typedef $$TransferOffersTableCreateCompanionBuilder =
    TransferOffersCompanion Function({
      Value<int> id,
      required int fromClubId,
      required int toClubId,
      required int playerId,
      required int needId,
      required int offerAmount,
      required int proposedSalary,
      required int contractYears,
      Value<int> season,
      required int createdAtWeek,
      Value<String> status,
    });
typedef $$TransferOffersTableUpdateCompanionBuilder =
    TransferOffersCompanion Function({
      Value<int> id,
      Value<int> fromClubId,
      Value<int> toClubId,
      Value<int> playerId,
      Value<int> needId,
      Value<int> offerAmount,
      Value<int> proposedSalary,
      Value<int> contractYears,
      Value<int> season,
      Value<int> createdAtWeek,
      Value<String> status,
    });

final class $$TransferOffersTableReferences
    extends BaseReferences<_$AppDatabase, $TransferOffersTable, TransferOffer> {
  $$TransferOffersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClubsTable _fromClubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.transferOffers.fromClubId, db.clubs.id),
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
    $_aliasNameGenerator(db.transferOffers.toClubId, db.clubs.id),
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

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.transferOffers.playerId, db.players.id),
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

  static $TransferNeedsTable _needIdTable(_$AppDatabase db) =>
      db.transferNeeds.createAlias(
        $_aliasNameGenerator(db.transferOffers.needId, db.transferNeeds.id),
      );

  $$TransferNeedsTableProcessedTableManager get needId {
    final $_column = $_itemColumn<int>('need_id')!;

    final manager = $$TransferNeedsTableTableManager(
      $_db,
      $_db.transferNeeds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_needIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransferOffersTableFilterComposer
    extends Composer<_$AppDatabase, $TransferOffersTable> {
  $$TransferOffersTableFilterComposer({
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

  ColumnFilters<int> get offerAmount => $composableBuilder(
    column: $table.offerAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proposedSalary => $composableBuilder(
    column: $table.proposedSalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contractYears => $composableBuilder(
    column: $table.contractYears,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtWeek => $composableBuilder(
    column: $table.createdAtWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

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

  $$TransferNeedsTableFilterComposer get needId {
    final $$TransferNeedsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.needId,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableFilterComposer(
            $db: $db,
            $table: $db.transferNeeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferOffersTableOrderingComposer
    extends Composer<_$AppDatabase, $TransferOffersTable> {
  $$TransferOffersTableOrderingComposer({
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

  ColumnOrderings<int> get offerAmount => $composableBuilder(
    column: $table.offerAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proposedSalary => $composableBuilder(
    column: $table.proposedSalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contractYears => $composableBuilder(
    column: $table.contractYears,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtWeek => $composableBuilder(
    column: $table.createdAtWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

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

  $$TransferNeedsTableOrderingComposer get needId {
    final $$TransferNeedsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.needId,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableOrderingComposer(
            $db: $db,
            $table: $db.transferNeeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferOffersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransferOffersTable> {
  $$TransferOffersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get offerAmount => $composableBuilder(
    column: $table.offerAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get proposedSalary => $composableBuilder(
    column: $table.proposedSalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contractYears => $composableBuilder(
    column: $table.contractYears,
    builder: (column) => column,
  );

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get createdAtWeek => $composableBuilder(
    column: $table.createdAtWeek,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

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

  $$TransferNeedsTableAnnotationComposer get needId {
    final $$TransferNeedsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.needId,
      referencedTable: $db.transferNeeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferNeedsTableAnnotationComposer(
            $db: $db,
            $table: $db.transferNeeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferOffersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransferOffersTable,
          TransferOffer,
          $$TransferOffersTableFilterComposer,
          $$TransferOffersTableOrderingComposer,
          $$TransferOffersTableAnnotationComposer,
          $$TransferOffersTableCreateCompanionBuilder,
          $$TransferOffersTableUpdateCompanionBuilder,
          (TransferOffer, $$TransferOffersTableReferences),
          TransferOffer,
          PrefetchHooks Function({
            bool fromClubId,
            bool toClubId,
            bool playerId,
            bool needId,
          })
        > {
  $$TransferOffersTableTableManager(
    _$AppDatabase db,
    $TransferOffersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransferOffersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransferOffersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransferOffersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fromClubId = const Value.absent(),
                Value<int> toClubId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> needId = const Value.absent(),
                Value<int> offerAmount = const Value.absent(),
                Value<int> proposedSalary = const Value.absent(),
                Value<int> contractYears = const Value.absent(),
                Value<int> season = const Value.absent(),
                Value<int> createdAtWeek = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => TransferOffersCompanion(
                id: id,
                fromClubId: fromClubId,
                toClubId: toClubId,
                playerId: playerId,
                needId: needId,
                offerAmount: offerAmount,
                proposedSalary: proposedSalary,
                contractYears: contractYears,
                season: season,
                createdAtWeek: createdAtWeek,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fromClubId,
                required int toClubId,
                required int playerId,
                required int needId,
                required int offerAmount,
                required int proposedSalary,
                required int contractYears,
                Value<int> season = const Value.absent(),
                required int createdAtWeek,
                Value<String> status = const Value.absent(),
              }) => TransferOffersCompanion.insert(
                id: id,
                fromClubId: fromClubId,
                toClubId: toClubId,
                playerId: playerId,
                needId: needId,
                offerAmount: offerAmount,
                proposedSalary: proposedSalary,
                contractYears: contractYears,
                season: season,
                createdAtWeek: createdAtWeek,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransferOffersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fromClubId = false,
                toClubId = false,
                playerId = false,
                needId = false,
              }) {
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
                        if (fromClubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromClubId,
                                    referencedTable:
                                        $$TransferOffersTableReferences
                                            ._fromClubIdTable(db),
                                    referencedColumn:
                                        $$TransferOffersTableReferences
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
                                    referencedTable:
                                        $$TransferOffersTableReferences
                                            ._toClubIdTable(db),
                                    referencedColumn:
                                        $$TransferOffersTableReferences
                                            ._toClubIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable:
                                        $$TransferOffersTableReferences
                                            ._playerIdTable(db),
                                    referencedColumn:
                                        $$TransferOffersTableReferences
                                            ._playerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (needId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.needId,
                                    referencedTable:
                                        $$TransferOffersTableReferences
                                            ._needIdTable(db),
                                    referencedColumn:
                                        $$TransferOffersTableReferences
                                            ._needIdTable(db)
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

typedef $$TransferOffersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransferOffersTable,
      TransferOffer,
      $$TransferOffersTableFilterComposer,
      $$TransferOffersTableOrderingComposer,
      $$TransferOffersTableAnnotationComposer,
      $$TransferOffersTableCreateCompanionBuilder,
      $$TransferOffersTableUpdateCompanionBuilder,
      (TransferOffer, $$TransferOffersTableReferences),
      TransferOffer,
      PrefetchHooks Function({
        bool fromClubId,
        bool toClubId,
        bool playerId,
        bool needId,
      })
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
typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      required int homeClubId,
      required int awayClubId,
      Value<int?> homeScore,
      Value<int?> awayScore,
      required int season,
      required int week,
      Value<bool> isPlayed,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      Value<int> homeClubId,
      Value<int> awayClubId,
      Value<int?> homeScore,
      Value<int?> awayScore,
      Value<int> season,
      Value<int> week,
      Value<bool> isPlayed,
    });

final class $$MatchesTableReferences
    extends BaseReferences<_$AppDatabase, $MatchesTable, Matche> {
  $$MatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClubsTable _homeClubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.matches.homeClubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get homeClubId {
    final $_column = $_itemColumn<int>('home_club_id')!;

    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_homeClubIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClubsTable _awayClubIdTable(_$AppDatabase db) => db.clubs.createAlias(
    $_aliasNameGenerator(db.matches.awayClubId, db.clubs.id),
  );

  $$ClubsTableProcessedTableManager get awayClubId {
    final $_column = $_itemColumn<int>('away_club_id')!;

    final manager = $$ClubsTableTableManager(
      $_db,
      $_db.clubs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_awayClubIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PerformancesTable, List<Performance>>
  _performancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.performances,
    aliasName: $_aliasNameGenerator(db.matches.id, db.performances.matchId),
  );

  $$PerformancesTableProcessedTableManager get performancesRefs {
    final manager = $$PerformancesTableTableManager(
      $_db,
      $_db.performances,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_performancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatchesTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableFilterComposer({
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

  ColumnFilters<int> get homeScore => $composableBuilder(
    column: $table.homeScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awayScore => $composableBuilder(
    column: $table.awayScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get week => $composableBuilder(
    column: $table.week,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPlayed => $composableBuilder(
    column: $table.isPlayed,
    builder: (column) => ColumnFilters(column),
  );

  $$ClubsTableFilterComposer get homeClubId {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeClubId,
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

  $$ClubsTableFilterComposer get awayClubId {
    final $$ClubsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayClubId,
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

  Expression<bool> performancesRefs(
    Expression<bool> Function($$PerformancesTableFilterComposer f) f,
  ) {
    final $$PerformancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.performances,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerformancesTableFilterComposer(
            $db: $db,
            $table: $db.performances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableOrderingComposer({
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

  ColumnOrderings<int> get homeScore => $composableBuilder(
    column: $table.homeScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awayScore => $composableBuilder(
    column: $table.awayScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get week => $composableBuilder(
    column: $table.week,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPlayed => $composableBuilder(
    column: $table.isPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClubsTableOrderingComposer get homeClubId {
    final $$ClubsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeClubId,
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

  $$ClubsTableOrderingComposer get awayClubId {
    final $$ClubsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayClubId,
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

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get homeScore =>
      $composableBuilder(column: $table.homeScore, builder: (column) => column);

  GeneratedColumn<int> get awayScore =>
      $composableBuilder(column: $table.awayScore, builder: (column) => column);

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get week =>
      $composableBuilder(column: $table.week, builder: (column) => column);

  GeneratedColumn<bool> get isPlayed =>
      $composableBuilder(column: $table.isPlayed, builder: (column) => column);

  $$ClubsTableAnnotationComposer get homeClubId {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeClubId,
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

  $$ClubsTableAnnotationComposer get awayClubId {
    final $$ClubsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayClubId,
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

  Expression<T> performancesRefs<T extends Object>(
    Expression<T> Function($$PerformancesTableAnnotationComposer a) f,
  ) {
    final $$PerformancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.performances,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PerformancesTableAnnotationComposer(
            $db: $db,
            $table: $db.performances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchesTable,
          Matche,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (Matche, $$MatchesTableReferences),
          Matche,
          PrefetchHooks Function({
            bool homeClubId,
            bool awayClubId,
            bool performancesRefs,
          })
        > {
  $$MatchesTableTableManager(_$AppDatabase db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> homeClubId = const Value.absent(),
                Value<int> awayClubId = const Value.absent(),
                Value<int?> homeScore = const Value.absent(),
                Value<int?> awayScore = const Value.absent(),
                Value<int> season = const Value.absent(),
                Value<int> week = const Value.absent(),
                Value<bool> isPlayed = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                homeClubId: homeClubId,
                awayClubId: awayClubId,
                homeScore: homeScore,
                awayScore: awayScore,
                season: season,
                week: week,
                isPlayed: isPlayed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int homeClubId,
                required int awayClubId,
                Value<int?> homeScore = const Value.absent(),
                Value<int?> awayScore = const Value.absent(),
                required int season,
                required int week,
                Value<bool> isPlayed = const Value.absent(),
              }) => MatchesCompanion.insert(
                id: id,
                homeClubId: homeClubId,
                awayClubId: awayClubId,
                homeScore: homeScore,
                awayScore: awayScore,
                season: season,
                week: week,
                isPlayed: isPlayed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                homeClubId = false,
                awayClubId = false,
                performancesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (performancesRefs) db.performances,
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
                        if (homeClubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.homeClubId,
                                    referencedTable: $$MatchesTableReferences
                                        ._homeClubIdTable(db),
                                    referencedColumn: $$MatchesTableReferences
                                        ._homeClubIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (awayClubId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.awayClubId,
                                    referencedTable: $$MatchesTableReferences
                                        ._awayClubIdTable(db),
                                    referencedColumn: $$MatchesTableReferences
                                        ._awayClubIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (performancesRefs)
                        await $_getPrefetchedData<
                          Matche,
                          $MatchesTable,
                          Performance
                        >(
                          currentTable: table,
                          referencedTable: $$MatchesTableReferences
                              ._performancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).performancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matchId == item.id,
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

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchesTable,
      Matche,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (Matche, $$MatchesTableReferences),
      Matche,
      PrefetchHooks Function({
        bool homeClubId,
        bool awayClubId,
        bool performancesRefs,
      })
    >;
typedef $$PerformancesTableCreateCompanionBuilder =
    PerformancesCompanion Function({
      Value<int> id,
      required int matchId,
      required int playerId,
      Value<int> minutesPlayed,
      Value<int> goals,
      Value<int> assists,
      Value<int> yellowCards,
      Value<int> redCards,
      Value<int> season,
      Value<double> rating,
    });
typedef $$PerformancesTableUpdateCompanionBuilder =
    PerformancesCompanion Function({
      Value<int> id,
      Value<int> matchId,
      Value<int> playerId,
      Value<int> minutesPlayed,
      Value<int> goals,
      Value<int> assists,
      Value<int> yellowCards,
      Value<int> redCards,
      Value<int> season,
      Value<double> rating,
    });

final class $$PerformancesTableReferences
    extends BaseReferences<_$AppDatabase, $PerformancesTable, Performance> {
  $$PerformancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$AppDatabase db) =>
      db.matches.createAlias(
        $_aliasNameGenerator(db.performances.matchId, db.matches.id),
      );

  $$MatchesTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<int>('match_id')!;

    final manager = $$MatchesTableTableManager(
      $_db,
      $_db.matches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.performances.playerId, db.players.id),
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

class $$PerformancesTableFilterComposer
    extends Composer<_$AppDatabase, $PerformancesTable> {
  $$PerformancesTableFilterComposer({
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

  ColumnFilters<int> get minutesPlayed => $composableBuilder(
    column: $table.minutesPlayed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assists => $composableBuilder(
    column: $table.assists,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yellowCards => $composableBuilder(
    column: $table.yellowCards,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get redCards => $composableBuilder(
    column: $table.redCards,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableFilterComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$PerformancesTableOrderingComposer
    extends Composer<_$AppDatabase, $PerformancesTable> {
  $$PerformancesTableOrderingComposer({
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

  ColumnOrderings<int> get minutesPlayed => $composableBuilder(
    column: $table.minutesPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assists => $composableBuilder(
    column: $table.assists,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yellowCards => $composableBuilder(
    column: $table.yellowCards,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get redCards => $composableBuilder(
    column: $table.redCards,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableOrderingComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$PerformancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PerformancesTable> {
  $$PerformancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get minutesPlayed => $composableBuilder(
    column: $table.minutesPlayed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goals =>
      $composableBuilder(column: $table.goals, builder: (column) => column);

  GeneratedColumn<int> get assists =>
      $composableBuilder(column: $table.assists, builder: (column) => column);

  GeneratedColumn<int> get yellowCards => $composableBuilder(
    column: $table.yellowCards,
    builder: (column) => column,
  );

  GeneratedColumn<int> get redCards =>
      $composableBuilder(column: $table.redCards, builder: (column) => column);

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$PerformancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PerformancesTable,
          Performance,
          $$PerformancesTableFilterComposer,
          $$PerformancesTableOrderingComposer,
          $$PerformancesTableAnnotationComposer,
          $$PerformancesTableCreateCompanionBuilder,
          $$PerformancesTableUpdateCompanionBuilder,
          (Performance, $$PerformancesTableReferences),
          Performance,
          PrefetchHooks Function({bool matchId, bool playerId})
        > {
  $$PerformancesTableTableManager(_$AppDatabase db, $PerformancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PerformancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PerformancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PerformancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matchId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> minutesPlayed = const Value.absent(),
                Value<int> goals = const Value.absent(),
                Value<int> assists = const Value.absent(),
                Value<int> yellowCards = const Value.absent(),
                Value<int> redCards = const Value.absent(),
                Value<int> season = const Value.absent(),
                Value<double> rating = const Value.absent(),
              }) => PerformancesCompanion(
                id: id,
                matchId: matchId,
                playerId: playerId,
                minutesPlayed: minutesPlayed,
                goals: goals,
                assists: assists,
                yellowCards: yellowCards,
                redCards: redCards,
                season: season,
                rating: rating,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matchId,
                required int playerId,
                Value<int> minutesPlayed = const Value.absent(),
                Value<int> goals = const Value.absent(),
                Value<int> assists = const Value.absent(),
                Value<int> yellowCards = const Value.absent(),
                Value<int> redCards = const Value.absent(),
                Value<int> season = const Value.absent(),
                Value<double> rating = const Value.absent(),
              }) => PerformancesCompanion.insert(
                id: id,
                matchId: matchId,
                playerId: playerId,
                minutesPlayed: minutesPlayed,
                goals: goals,
                assists: assists,
                yellowCards: yellowCards,
                redCards: redCards,
                season: season,
                rating: rating,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PerformancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false, playerId = false}) {
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
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable: $$PerformancesTableReferences
                                    ._matchIdTable(db),
                                referencedColumn: $$PerformancesTableReferences
                                    ._matchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$PerformancesTableReferences
                                    ._playerIdTable(db),
                                referencedColumn: $$PerformancesTableReferences
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

typedef $$PerformancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PerformancesTable,
      Performance,
      $$PerformancesTableFilterComposer,
      $$PerformancesTableOrderingComposer,
      $$PerformancesTableAnnotationComposer,
      $$PerformancesTableCreateCompanionBuilder,
      $$PerformancesTableUpdateCompanionBuilder,
      (Performance, $$PerformancesTableReferences),
      Performance,
      PrefetchHooks Function({bool matchId, bool playerId})
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
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$AgentContractsTableTableManager get agentContracts =>
      $$AgentContractsTableTableManager(_db, _db.agentContracts);
  $$ClubContractsTableTableManager get clubContracts =>
      $$ClubContractsTableTableManager(_db, _db.clubContracts);
  $$TransfersTableTableManager get transfers =>
      $$TransfersTableTableManager(_db, _db.transfers);
  $$TransferNeedsTableTableManager get transferNeeds =>
      $$TransferNeedsTableTableManager(_db, _db.transferNeeds);
  $$TransferOffersTableTableManager get transferOffers =>
      $$TransferOffersTableTableManager(_db, _db.transferOffers);
  $$ValueHistoriesTableTableManager get valueHistories =>
      $$ValueHistoriesTableTableManager(_db, _db.valueHistories);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$CountriesTableTableManager get countries =>
      $$CountriesTableTableManager(_db, _db.countries);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$PerformancesTableTableManager get performances =>
      $$PerformancesTableTableManager(_db, _db.performances);
}
