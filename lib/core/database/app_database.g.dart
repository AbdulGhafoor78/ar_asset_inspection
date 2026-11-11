// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $InspectionsTable extends Inspections
    with TableInfo<$InspectionsTable, Inspection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineerIdMeta = const VerificationMeta(
    'engineerId',
  );
  @override
  late final GeneratedColumn<String> engineerId = GeneratedColumn<String>(
    'engineer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _inspectionDateMeta = const VerificationMeta(
    'inspectionDate',
  );
  @override
  late final GeneratedColumn<DateTime> inspectionDate =
      GeneratedColumn<DateTime>(
        'inspection_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    assetId,
    engineerId,
    status,
    inspectionDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Inspection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('engineer_id')) {
      context.handle(
        _engineerIdMeta,
        engineerId.isAcceptableOrUnknown(data['engineer_id']!, _engineerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_engineerIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('inspection_date')) {
      context.handle(
        _inspectionDateMeta,
        inspectionDate.isAcceptableOrUnknown(
          data['inspection_date']!,
          _inspectionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inspection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inspection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}asset_id'],
      )!,
      engineerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engineer_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      inspectionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inspection_date'],
      )!,
    );
  }

  @override
  $InspectionsTable createAlias(String alias) {
    return $InspectionsTable(attachedDatabase, alias);
  }
}

class Inspection extends DataClass implements Insertable<Inspection> {
  final int id;
  final int assetId;
  final String engineerId;
  final String status;
  final DateTime inspectionDate;
  const Inspection({
    required this.id,
    required this.assetId,
    required this.engineerId,
    required this.status,
    required this.inspectionDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['asset_id'] = Variable<int>(assetId);
    map['engineer_id'] = Variable<String>(engineerId);
    map['status'] = Variable<String>(status);
    map['inspection_date'] = Variable<DateTime>(inspectionDate);
    return map;
  }

  InspectionsCompanion toCompanion(bool nullToAbsent) {
    return InspectionsCompanion(
      id: Value(id),
      assetId: Value(assetId),
      engineerId: Value(engineerId),
      status: Value(status),
      inspectionDate: Value(inspectionDate),
    );
  }

  factory Inspection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inspection(
      id: serializer.fromJson<int>(json['id']),
      assetId: serializer.fromJson<int>(json['assetId']),
      engineerId: serializer.fromJson<String>(json['engineerId']),
      status: serializer.fromJson<String>(json['status']),
      inspectionDate: serializer.fromJson<DateTime>(json['inspectionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assetId': serializer.toJson<int>(assetId),
      'engineerId': serializer.toJson<String>(engineerId),
      'status': serializer.toJson<String>(status),
      'inspectionDate': serializer.toJson<DateTime>(inspectionDate),
    };
  }

  Inspection copyWith({
    int? id,
    int? assetId,
    String? engineerId,
    String? status,
    DateTime? inspectionDate,
  }) => Inspection(
    id: id ?? this.id,
    assetId: assetId ?? this.assetId,
    engineerId: engineerId ?? this.engineerId,
    status: status ?? this.status,
    inspectionDate: inspectionDate ?? this.inspectionDate,
  );
  Inspection copyWithCompanion(InspectionsCompanion data) {
    return Inspection(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      engineerId: data.engineerId.present
          ? data.engineerId.value
          : this.engineerId,
      status: data.status.present ? data.status.value : this.status,
      inspectionDate: data.inspectionDate.present
          ? data.inspectionDate.value
          : this.inspectionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inspection(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('engineerId: $engineerId, ')
          ..write('status: $status, ')
          ..write('inspectionDate: $inspectionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, assetId, engineerId, status, inspectionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inspection &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.engineerId == this.engineerId &&
          other.status == this.status &&
          other.inspectionDate == this.inspectionDate);
}

class InspectionsCompanion extends UpdateCompanion<Inspection> {
  final Value<int> id;
  final Value<int> assetId;
  final Value<String> engineerId;
  final Value<String> status;
  final Value<DateTime> inspectionDate;
  const InspectionsCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.engineerId = const Value.absent(),
    this.status = const Value.absent(),
    this.inspectionDate = const Value.absent(),
  });
  InspectionsCompanion.insert({
    this.id = const Value.absent(),
    required int assetId,
    required String engineerId,
    required String status,
    required DateTime inspectionDate,
  }) : assetId = Value(assetId),
       engineerId = Value(engineerId),
       status = Value(status),
       inspectionDate = Value(inspectionDate);
  static Insertable<Inspection> custom({
    Expression<int>? id,
    Expression<int>? assetId,
    Expression<String>? engineerId,
    Expression<String>? status,
    Expression<DateTime>? inspectionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (engineerId != null) 'engineer_id': engineerId,
      if (status != null) 'status': status,
      if (inspectionDate != null) 'inspection_date': inspectionDate,
    });
  }

  InspectionsCompanion copyWith({
    Value<int>? id,
    Value<int>? assetId,
    Value<String>? engineerId,
    Value<String>? status,
    Value<DateTime>? inspectionDate,
  }) {
    return InspectionsCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      engineerId: engineerId ?? this.engineerId,
      status: status ?? this.status,
      inspectionDate: inspectionDate ?? this.inspectionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (engineerId.present) {
      map['engineer_id'] = Variable<String>(engineerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (inspectionDate.present) {
      map['inspection_date'] = Variable<DateTime>(inspectionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('engineerId: $engineerId, ')
          ..write('status: $status, ')
          ..write('inspectionDate: $inspectionDate')
          ..write(')'))
        .toString();
  }
}

class $InspectionChecklistItemsTable extends InspectionChecklistItems
    with TableInfo<$InspectionChecklistItemsTable, InspectionChecklistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionChecklistItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inspectionIdMeta = const VerificationMeta(
    'inspectionId',
  );
  @override
  late final GeneratedColumn<int> inspectionId = GeneratedColumn<int>(
    'inspection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPassedMeta = const VerificationMeta(
    'isPassed',
  );
  @override
  late final GeneratedColumn<bool> isPassed = GeneratedColumn<bool>(
    'is_passed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_passed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionId,
    title,
    isPassed,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_checklist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionChecklistItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_id')) {
      context.handle(
        _inspectionIdMeta,
        inspectionId.isAcceptableOrUnknown(
          data['inspection_id']!,
          _inspectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_passed')) {
      context.handle(
        _isPassedMeta,
        isPassed.isAcceptableOrUnknown(data['is_passed']!, _isPassedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionChecklistItem map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionChecklistItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inspection_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isPassed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_passed'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $InspectionChecklistItemsTable createAlias(String alias) {
    return $InspectionChecklistItemsTable(attachedDatabase, alias);
  }
}

class InspectionChecklistItem extends DataClass
    implements Insertable<InspectionChecklistItem> {
  final int id;
  final int inspectionId;
  final String title;
  final bool isPassed;
  final String? notes;
  const InspectionChecklistItem({
    required this.id,
    required this.inspectionId,
    required this.title,
    required this.isPassed,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inspection_id'] = Variable<int>(inspectionId);
    map['title'] = Variable<String>(title);
    map['is_passed'] = Variable<bool>(isPassed);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  InspectionChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return InspectionChecklistItemsCompanion(
      id: Value(id),
      inspectionId: Value(inspectionId),
      title: Value(title),
      isPassed: Value(isPassed),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory InspectionChecklistItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionChecklistItem(
      id: serializer.fromJson<int>(json['id']),
      inspectionId: serializer.fromJson<int>(json['inspectionId']),
      title: serializer.fromJson<String>(json['title']),
      isPassed: serializer.fromJson<bool>(json['isPassed']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionId': serializer.toJson<int>(inspectionId),
      'title': serializer.toJson<String>(title),
      'isPassed': serializer.toJson<bool>(isPassed),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  InspectionChecklistItem copyWith({
    int? id,
    int? inspectionId,
    String? title,
    bool? isPassed,
    Value<String?> notes = const Value.absent(),
  }) => InspectionChecklistItem(
    id: id ?? this.id,
    inspectionId: inspectionId ?? this.inspectionId,
    title: title ?? this.title,
    isPassed: isPassed ?? this.isPassed,
    notes: notes.present ? notes.value : this.notes,
  );
  InspectionChecklistItem copyWithCompanion(
    InspectionChecklistItemsCompanion data,
  ) {
    return InspectionChecklistItem(
      id: data.id.present ? data.id.value : this.id,
      inspectionId: data.inspectionId.present
          ? data.inspectionId.value
          : this.inspectionId,
      title: data.title.present ? data.title.value : this.title,
      isPassed: data.isPassed.present ? data.isPassed.value : this.isPassed,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionChecklistItem(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('title: $title, ')
          ..write('isPassed: $isPassed, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, inspectionId, title, isPassed, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionChecklistItem &&
          other.id == this.id &&
          other.inspectionId == this.inspectionId &&
          other.title == this.title &&
          other.isPassed == this.isPassed &&
          other.notes == this.notes);
}

class InspectionChecklistItemsCompanion
    extends UpdateCompanion<InspectionChecklistItem> {
  final Value<int> id;
  final Value<int> inspectionId;
  final Value<String> title;
  final Value<bool> isPassed;
  final Value<String?> notes;
  const InspectionChecklistItemsCompanion({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    this.title = const Value.absent(),
    this.isPassed = const Value.absent(),
    this.notes = const Value.absent(),
  });
  InspectionChecklistItemsCompanion.insert({
    this.id = const Value.absent(),
    required int inspectionId,
    required String title,
    this.isPassed = const Value.absent(),
    this.notes = const Value.absent(),
  }) : inspectionId = Value(inspectionId),
       title = Value(title);
  static Insertable<InspectionChecklistItem> custom({
    Expression<int>? id,
    Expression<int>? inspectionId,
    Expression<String>? title,
    Expression<bool>? isPassed,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionId != null) 'inspection_id': inspectionId,
      if (title != null) 'title': title,
      if (isPassed != null) 'is_passed': isPassed,
      if (notes != null) 'notes': notes,
    });
  }

  InspectionChecklistItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? inspectionId,
    Value<String>? title,
    Value<bool>? isPassed,
    Value<String?>? notes,
  }) {
    return InspectionChecklistItemsCompanion(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      title: title ?? this.title,
      isPassed: isPassed ?? this.isPassed,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionId.present) {
      map['inspection_id'] = Variable<int>(inspectionId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isPassed.present) {
      map['is_passed'] = Variable<bool>(isPassed.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('title: $title, ')
          ..write('isPassed: $isPassed, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $InspectionEvidenceRecordsTable extends InspectionEvidenceRecords
    with TableInfo<$InspectionEvidenceRecordsTable, InspectionEvidenceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionEvidenceRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inspectionIdMeta = const VerificationMeta(
    'inspectionId',
  );
  @override
  late final GeneratedColumn<int> inspectionId = GeneratedColumn<int>(
    'inspection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checklistItemIdMeta = const VerificationMeta(
    'checklistItemId',
  );
  @override
  late final GeneratedColumn<int> checklistItemId = GeneratedColumn<int>(
    'checklist_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageBytesMeta = const VerificationMeta(
    'imageBytes',
  );
  @override
  late final GeneratedColumn<Uint8List> imageBytes = GeneratedColumn<Uint8List>(
    'image_bytes',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionId,
    checklistItemId,
    imagePath,
    imageBytes,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_evidence_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionEvidenceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_id')) {
      context.handle(
        _inspectionIdMeta,
        inspectionId.isAcceptableOrUnknown(
          data['inspection_id']!,
          _inspectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionIdMeta);
    }
    if (data.containsKey('checklist_item_id')) {
      context.handle(
        _checklistItemIdMeta,
        checklistItemId.isAcceptableOrUnknown(
          data['checklist_item_id']!,
          _checklistItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checklistItemIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('image_bytes')) {
      context.handle(
        _imageBytesMeta,
        imageBytes.isAcceptableOrUnknown(data['image_bytes']!, _imageBytesMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionEvidenceRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionEvidenceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inspection_id'],
      )!,
      checklistItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}checklist_item_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      imageBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_bytes'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InspectionEvidenceRecordsTable createAlias(String alias) {
    return $InspectionEvidenceRecordsTable(attachedDatabase, alias);
  }
}

class InspectionEvidenceRecord extends DataClass
    implements Insertable<InspectionEvidenceRecord> {
  final int id;
  final int inspectionId;
  final int checklistItemId;
  final String imagePath;
  final Uint8List? imageBytes;
  final String? description;
  final DateTime createdAt;
  const InspectionEvidenceRecord({
    required this.id,
    required this.inspectionId,
    required this.checklistItemId,
    required this.imagePath,
    this.imageBytes,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inspection_id'] = Variable<int>(inspectionId);
    map['checklist_item_id'] = Variable<int>(checklistItemId);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || imageBytes != null) {
      map['image_bytes'] = Variable<Uint8List>(imageBytes);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InspectionEvidenceRecordsCompanion toCompanion(bool nullToAbsent) {
    return InspectionEvidenceRecordsCompanion(
      id: Value(id),
      inspectionId: Value(inspectionId),
      checklistItemId: Value(checklistItemId),
      imagePath: Value(imagePath),
      imageBytes: imageBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(imageBytes),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory InspectionEvidenceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionEvidenceRecord(
      id: serializer.fromJson<int>(json['id']),
      inspectionId: serializer.fromJson<int>(json['inspectionId']),
      checklistItemId: serializer.fromJson<int>(json['checklistItemId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      imageBytes: serializer.fromJson<Uint8List?>(json['imageBytes']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionId': serializer.toJson<int>(inspectionId),
      'checklistItemId': serializer.toJson<int>(checklistItemId),
      'imagePath': serializer.toJson<String>(imagePath),
      'imageBytes': serializer.toJson<Uint8List?>(imageBytes),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InspectionEvidenceRecord copyWith({
    int? id,
    int? inspectionId,
    int? checklistItemId,
    String? imagePath,
    Value<Uint8List?> imageBytes = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => InspectionEvidenceRecord(
    id: id ?? this.id,
    inspectionId: inspectionId ?? this.inspectionId,
    checklistItemId: checklistItemId ?? this.checklistItemId,
    imagePath: imagePath ?? this.imagePath,
    imageBytes: imageBytes.present ? imageBytes.value : this.imageBytes,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  InspectionEvidenceRecord copyWithCompanion(
    InspectionEvidenceRecordsCompanion data,
  ) {
    return InspectionEvidenceRecord(
      id: data.id.present ? data.id.value : this.id,
      inspectionId: data.inspectionId.present
          ? data.inspectionId.value
          : this.inspectionId,
      checklistItemId: data.checklistItemId.present
          ? data.checklistItemId.value
          : this.checklistItemId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      imageBytes: data.imageBytes.present
          ? data.imageBytes.value
          : this.imageBytes,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionEvidenceRecord(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('checklistItemId: $checklistItemId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageBytes: $imageBytes, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inspectionId,
    checklistItemId,
    imagePath,
    $driftBlobEquality.hash(imageBytes),
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionEvidenceRecord &&
          other.id == this.id &&
          other.inspectionId == this.inspectionId &&
          other.checklistItemId == this.checklistItemId &&
          other.imagePath == this.imagePath &&
          $driftBlobEquality.equals(other.imageBytes, this.imageBytes) &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class InspectionEvidenceRecordsCompanion
    extends UpdateCompanion<InspectionEvidenceRecord> {
  final Value<int> id;
  final Value<int> inspectionId;
  final Value<int> checklistItemId;
  final Value<String> imagePath;
  final Value<Uint8List?> imageBytes;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const InspectionEvidenceRecordsCompanion({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    this.checklistItemId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageBytes = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InspectionEvidenceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int inspectionId,
    required int checklistItemId,
    required String imagePath,
    this.imageBytes = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime createdAt,
  }) : inspectionId = Value(inspectionId),
       checklistItemId = Value(checklistItemId),
       imagePath = Value(imagePath),
       createdAt = Value(createdAt);
  static Insertable<InspectionEvidenceRecord> custom({
    Expression<int>? id,
    Expression<int>? inspectionId,
    Expression<int>? checklistItemId,
    Expression<String>? imagePath,
    Expression<Uint8List>? imageBytes,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionId != null) 'inspection_id': inspectionId,
      if (checklistItemId != null) 'checklist_item_id': checklistItemId,
      if (imagePath != null) 'image_path': imagePath,
      if (imageBytes != null) 'image_bytes': imageBytes,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InspectionEvidenceRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? inspectionId,
    Value<int>? checklistItemId,
    Value<String>? imagePath,
    Value<Uint8List?>? imageBytes,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return InspectionEvidenceRecordsCompanion(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      checklistItemId: checklistItemId ?? this.checklistItemId,
      imagePath: imagePath ?? this.imagePath,
      imageBytes: imageBytes ?? this.imageBytes,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionId.present) {
      map['inspection_id'] = Variable<int>(inspectionId.value);
    }
    if (checklistItemId.present) {
      map['checklist_item_id'] = Variable<int>(checklistItemId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (imageBytes.present) {
      map['image_bytes'] = Variable<Uint8List>(imageBytes.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionEvidenceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('checklistItemId: $checklistItemId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageBytes: $imageBytes, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ArInspectionRecordsTable extends ArInspectionRecords
    with TableInfo<$ArInspectionRecordsTable, ArInspectionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArInspectionRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inspectionIdMeta = const VerificationMeta(
    'inspectionId',
  );
  @override
  late final GeneratedColumn<int> inspectionId = GeneratedColumn<int>(
    'inspection_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetNameMeta = const VerificationMeta(
    'assetName',
  );
  @override
  late final GeneratedColumn<String> assetName = GeneratedColumn<String>(
    'asset_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetCodeMeta = const VerificationMeta(
    'assetCode',
  );
  @override
  late final GeneratedColumn<String> assetCode = GeneratedColumn<String>(
    'asset_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArAvailableMeta = const VerificationMeta(
    'isArAvailable',
  );
  @override
  late final GeneratedColumn<bool> isArAvailable = GeneratedColumn<bool>(
    'is_ar_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ar_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _resultSummaryMeta = const VerificationMeta(
    'resultSummary',
  );
  @override
  late final GeneratedColumn<String> resultSummary = GeneratedColumn<String>(
    'result_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionId,
    assetId,
    assetName,
    assetCode,
    isArAvailable,
    status,
    resultSummary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ar_inspection_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArInspectionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_id')) {
      context.handle(
        _inspectionIdMeta,
        inspectionId.isAcceptableOrUnknown(
          data['inspection_id']!,
          _inspectionIdMeta,
        ),
      );
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('asset_name')) {
      context.handle(
        _assetNameMeta,
        assetName.isAcceptableOrUnknown(data['asset_name']!, _assetNameMeta),
      );
    } else if (isInserting) {
      context.missing(_assetNameMeta);
    }
    if (data.containsKey('asset_code')) {
      context.handle(
        _assetCodeMeta,
        assetCode.isAcceptableOrUnknown(data['asset_code']!, _assetCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_assetCodeMeta);
    }
    if (data.containsKey('is_ar_available')) {
      context.handle(
        _isArAvailableMeta,
        isArAvailable.isAcceptableOrUnknown(
          data['is_ar_available']!,
          _isArAvailableMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('result_summary')) {
      context.handle(
        _resultSummaryMeta,
        resultSummary.isAcceptableOrUnknown(
          data['result_summary']!,
          _resultSummaryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArInspectionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArInspectionRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inspection_id'],
      ),
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}asset_id'],
      )!,
      assetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_name'],
      )!,
      assetCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_code'],
      )!,
      isArAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_ar_available'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      resultSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_summary'],
      ),
    );
  }

  @override
  $ArInspectionRecordsTable createAlias(String alias) {
    return $ArInspectionRecordsTable(attachedDatabase, alias);
  }
}

class ArInspectionRecord extends DataClass
    implements Insertable<ArInspectionRecord> {
  final int id;
  final int? inspectionId;
  final int assetId;
  final String assetName;
  final String assetCode;
  final bool isArAvailable;
  final String status;
  final String? resultSummary;
  const ArInspectionRecord({
    required this.id,
    this.inspectionId,
    required this.assetId,
    required this.assetName,
    required this.assetCode,
    required this.isArAvailable,
    required this.status,
    this.resultSummary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || inspectionId != null) {
      map['inspection_id'] = Variable<int>(inspectionId);
    }
    map['asset_id'] = Variable<int>(assetId);
    map['asset_name'] = Variable<String>(assetName);
    map['asset_code'] = Variable<String>(assetCode);
    map['is_ar_available'] = Variable<bool>(isArAvailable);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || resultSummary != null) {
      map['result_summary'] = Variable<String>(resultSummary);
    }
    return map;
  }

  ArInspectionRecordsCompanion toCompanion(bool nullToAbsent) {
    return ArInspectionRecordsCompanion(
      id: Value(id),
      inspectionId: inspectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(inspectionId),
      assetId: Value(assetId),
      assetName: Value(assetName),
      assetCode: Value(assetCode),
      isArAvailable: Value(isArAvailable),
      status: Value(status),
      resultSummary: resultSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(resultSummary),
    );
  }

  factory ArInspectionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArInspectionRecord(
      id: serializer.fromJson<int>(json['id']),
      inspectionId: serializer.fromJson<int?>(json['inspectionId']),
      assetId: serializer.fromJson<int>(json['assetId']),
      assetName: serializer.fromJson<String>(json['assetName']),
      assetCode: serializer.fromJson<String>(json['assetCode']),
      isArAvailable: serializer.fromJson<bool>(json['isArAvailable']),
      status: serializer.fromJson<String>(json['status']),
      resultSummary: serializer.fromJson<String?>(json['resultSummary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionId': serializer.toJson<int?>(inspectionId),
      'assetId': serializer.toJson<int>(assetId),
      'assetName': serializer.toJson<String>(assetName),
      'assetCode': serializer.toJson<String>(assetCode),
      'isArAvailable': serializer.toJson<bool>(isArAvailable),
      'status': serializer.toJson<String>(status),
      'resultSummary': serializer.toJson<String?>(resultSummary),
    };
  }

  ArInspectionRecord copyWith({
    int? id,
    Value<int?> inspectionId = const Value.absent(),
    int? assetId,
    String? assetName,
    String? assetCode,
    bool? isArAvailable,
    String? status,
    Value<String?> resultSummary = const Value.absent(),
  }) => ArInspectionRecord(
    id: id ?? this.id,
    inspectionId: inspectionId.present ? inspectionId.value : this.inspectionId,
    assetId: assetId ?? this.assetId,
    assetName: assetName ?? this.assetName,
    assetCode: assetCode ?? this.assetCode,
    isArAvailable: isArAvailable ?? this.isArAvailable,
    status: status ?? this.status,
    resultSummary: resultSummary.present
        ? resultSummary.value
        : this.resultSummary,
  );
  ArInspectionRecord copyWithCompanion(ArInspectionRecordsCompanion data) {
    return ArInspectionRecord(
      id: data.id.present ? data.id.value : this.id,
      inspectionId: data.inspectionId.present
          ? data.inspectionId.value
          : this.inspectionId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      assetName: data.assetName.present ? data.assetName.value : this.assetName,
      assetCode: data.assetCode.present ? data.assetCode.value : this.assetCode,
      isArAvailable: data.isArAvailable.present
          ? data.isArAvailable.value
          : this.isArAvailable,
      status: data.status.present ? data.status.value : this.status,
      resultSummary: data.resultSummary.present
          ? data.resultSummary.value
          : this.resultSummary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArInspectionRecord(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('assetId: $assetId, ')
          ..write('assetName: $assetName, ')
          ..write('assetCode: $assetCode, ')
          ..write('isArAvailable: $isArAvailable, ')
          ..write('status: $status, ')
          ..write('resultSummary: $resultSummary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inspectionId,
    assetId,
    assetName,
    assetCode,
    isArAvailable,
    status,
    resultSummary,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArInspectionRecord &&
          other.id == this.id &&
          other.inspectionId == this.inspectionId &&
          other.assetId == this.assetId &&
          other.assetName == this.assetName &&
          other.assetCode == this.assetCode &&
          other.isArAvailable == this.isArAvailable &&
          other.status == this.status &&
          other.resultSummary == this.resultSummary);
}

class ArInspectionRecordsCompanion extends UpdateCompanion<ArInspectionRecord> {
  final Value<int> id;
  final Value<int?> inspectionId;
  final Value<int> assetId;
  final Value<String> assetName;
  final Value<String> assetCode;
  final Value<bool> isArAvailable;
  final Value<String> status;
  final Value<String?> resultSummary;
  const ArInspectionRecordsCompanion({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.assetName = const Value.absent(),
    this.assetCode = const Value.absent(),
    this.isArAvailable = const Value.absent(),
    this.status = const Value.absent(),
    this.resultSummary = const Value.absent(),
  });
  ArInspectionRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    required int assetId,
    required String assetName,
    required String assetCode,
    this.isArAvailable = const Value.absent(),
    required String status,
    this.resultSummary = const Value.absent(),
  }) : assetId = Value(assetId),
       assetName = Value(assetName),
       assetCode = Value(assetCode),
       status = Value(status);
  static Insertable<ArInspectionRecord> custom({
    Expression<int>? id,
    Expression<int>? inspectionId,
    Expression<int>? assetId,
    Expression<String>? assetName,
    Expression<String>? assetCode,
    Expression<bool>? isArAvailable,
    Expression<String>? status,
    Expression<String>? resultSummary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionId != null) 'inspection_id': inspectionId,
      if (assetId != null) 'asset_id': assetId,
      if (assetName != null) 'asset_name': assetName,
      if (assetCode != null) 'asset_code': assetCode,
      if (isArAvailable != null) 'is_ar_available': isArAvailable,
      if (status != null) 'status': status,
      if (resultSummary != null) 'result_summary': resultSummary,
    });
  }

  ArInspectionRecordsCompanion copyWith({
    Value<int>? id,
    Value<int?>? inspectionId,
    Value<int>? assetId,
    Value<String>? assetName,
    Value<String>? assetCode,
    Value<bool>? isArAvailable,
    Value<String>? status,
    Value<String?>? resultSummary,
  }) {
    return ArInspectionRecordsCompanion(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      assetId: assetId ?? this.assetId,
      assetName: assetName ?? this.assetName,
      assetCode: assetCode ?? this.assetCode,
      isArAvailable: isArAvailable ?? this.isArAvailable,
      status: status ?? this.status,
      resultSummary: resultSummary ?? this.resultSummary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionId.present) {
      map['inspection_id'] = Variable<int>(inspectionId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (assetName.present) {
      map['asset_name'] = Variable<String>(assetName.value);
    }
    if (assetCode.present) {
      map['asset_code'] = Variable<String>(assetCode.value);
    }
    if (isArAvailable.present) {
      map['is_ar_available'] = Variable<bool>(isArAvailable.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (resultSummary.present) {
      map['result_summary'] = Variable<String>(resultSummary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArInspectionRecordsCompanion(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('assetId: $assetId, ')
          ..write('assetName: $assetName, ')
          ..write('assetCode: $assetCode, ')
          ..write('isArAvailable: $isArAvailable, ')
          ..write('status: $status, ')
          ..write('resultSummary: $resultSummary')
          ..write(')'))
        .toString();
  }
}

class $ArInspectionResultRecordsTable extends ArInspectionResultRecords
    with TableInfo<$ArInspectionResultRecordsTable, ArInspectionResultRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArInspectionResultRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _arInspectionIdMeta = const VerificationMeta(
    'arInspectionId',
  );
  @override
  late final GeneratedColumn<int> arInspectionId = GeneratedColumn<int>(
    'ar_inspection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inspectionPointMeta = const VerificationMeta(
    'inspectionPoint',
  );
  @override
  late final GeneratedColumn<String> inspectionPoint = GeneratedColumn<String>(
    'inspection_point',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPassedMeta = const VerificationMeta(
    'isPassed',
  );
  @override
  late final GeneratedColumn<bool> isPassed = GeneratedColumn<bool>(
    'is_passed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_passed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    arInspectionId,
    inspectionPoint,
    isPassed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ar_inspection_result_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArInspectionResultRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ar_inspection_id')) {
      context.handle(
        _arInspectionIdMeta,
        arInspectionId.isAcceptableOrUnknown(
          data['ar_inspection_id']!,
          _arInspectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arInspectionIdMeta);
    }
    if (data.containsKey('inspection_point')) {
      context.handle(
        _inspectionPointMeta,
        inspectionPoint.isAcceptableOrUnknown(
          data['inspection_point']!,
          _inspectionPointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionPointMeta);
    }
    if (data.containsKey('is_passed')) {
      context.handle(
        _isPassedMeta,
        isPassed.isAcceptableOrUnknown(data['is_passed']!, _isPassedMeta),
      );
    } else if (isInserting) {
      context.missing(_isPassedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArInspectionResultRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArInspectionResultRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      arInspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ar_inspection_id'],
      )!,
      inspectionPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inspection_point'],
      )!,
      isPassed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_passed'],
      )!,
    );
  }

  @override
  $ArInspectionResultRecordsTable createAlias(String alias) {
    return $ArInspectionResultRecordsTable(attachedDatabase, alias);
  }
}

class ArInspectionResultRecord extends DataClass
    implements Insertable<ArInspectionResultRecord> {
  final int id;
  final int arInspectionId;
  final String inspectionPoint;
  final bool isPassed;
  const ArInspectionResultRecord({
    required this.id,
    required this.arInspectionId,
    required this.inspectionPoint,
    required this.isPassed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ar_inspection_id'] = Variable<int>(arInspectionId);
    map['inspection_point'] = Variable<String>(inspectionPoint);
    map['is_passed'] = Variable<bool>(isPassed);
    return map;
  }

  ArInspectionResultRecordsCompanion toCompanion(bool nullToAbsent) {
    return ArInspectionResultRecordsCompanion(
      id: Value(id),
      arInspectionId: Value(arInspectionId),
      inspectionPoint: Value(inspectionPoint),
      isPassed: Value(isPassed),
    );
  }

  factory ArInspectionResultRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArInspectionResultRecord(
      id: serializer.fromJson<int>(json['id']),
      arInspectionId: serializer.fromJson<int>(json['arInspectionId']),
      inspectionPoint: serializer.fromJson<String>(json['inspectionPoint']),
      isPassed: serializer.fromJson<bool>(json['isPassed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'arInspectionId': serializer.toJson<int>(arInspectionId),
      'inspectionPoint': serializer.toJson<String>(inspectionPoint),
      'isPassed': serializer.toJson<bool>(isPassed),
    };
  }

  ArInspectionResultRecord copyWith({
    int? id,
    int? arInspectionId,
    String? inspectionPoint,
    bool? isPassed,
  }) => ArInspectionResultRecord(
    id: id ?? this.id,
    arInspectionId: arInspectionId ?? this.arInspectionId,
    inspectionPoint: inspectionPoint ?? this.inspectionPoint,
    isPassed: isPassed ?? this.isPassed,
  );
  ArInspectionResultRecord copyWithCompanion(
    ArInspectionResultRecordsCompanion data,
  ) {
    return ArInspectionResultRecord(
      id: data.id.present ? data.id.value : this.id,
      arInspectionId: data.arInspectionId.present
          ? data.arInspectionId.value
          : this.arInspectionId,
      inspectionPoint: data.inspectionPoint.present
          ? data.inspectionPoint.value
          : this.inspectionPoint,
      isPassed: data.isPassed.present ? data.isPassed.value : this.isPassed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArInspectionResultRecord(')
          ..write('id: $id, ')
          ..write('arInspectionId: $arInspectionId, ')
          ..write('inspectionPoint: $inspectionPoint, ')
          ..write('isPassed: $isPassed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, arInspectionId, inspectionPoint, isPassed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArInspectionResultRecord &&
          other.id == this.id &&
          other.arInspectionId == this.arInspectionId &&
          other.inspectionPoint == this.inspectionPoint &&
          other.isPassed == this.isPassed);
}

class ArInspectionResultRecordsCompanion
    extends UpdateCompanion<ArInspectionResultRecord> {
  final Value<int> id;
  final Value<int> arInspectionId;
  final Value<String> inspectionPoint;
  final Value<bool> isPassed;
  const ArInspectionResultRecordsCompanion({
    this.id = const Value.absent(),
    this.arInspectionId = const Value.absent(),
    this.inspectionPoint = const Value.absent(),
    this.isPassed = const Value.absent(),
  });
  ArInspectionResultRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int arInspectionId,
    required String inspectionPoint,
    required bool isPassed,
  }) : arInspectionId = Value(arInspectionId),
       inspectionPoint = Value(inspectionPoint),
       isPassed = Value(isPassed);
  static Insertable<ArInspectionResultRecord> custom({
    Expression<int>? id,
    Expression<int>? arInspectionId,
    Expression<String>? inspectionPoint,
    Expression<bool>? isPassed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (arInspectionId != null) 'ar_inspection_id': arInspectionId,
      if (inspectionPoint != null) 'inspection_point': inspectionPoint,
      if (isPassed != null) 'is_passed': isPassed,
    });
  }

  ArInspectionResultRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? arInspectionId,
    Value<String>? inspectionPoint,
    Value<bool>? isPassed,
  }) {
    return ArInspectionResultRecordsCompanion(
      id: id ?? this.id,
      arInspectionId: arInspectionId ?? this.arInspectionId,
      inspectionPoint: inspectionPoint ?? this.inspectionPoint,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (arInspectionId.present) {
      map['ar_inspection_id'] = Variable<int>(arInspectionId.value);
    }
    if (inspectionPoint.present) {
      map['inspection_point'] = Variable<String>(inspectionPoint.value);
    }
    if (isPassed.present) {
      map['is_passed'] = Variable<bool>(isPassed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArInspectionResultRecordsCompanion(')
          ..write('id: $id, ')
          ..write('arInspectionId: $arInspectionId, ')
          ..write('inspectionPoint: $inspectionPoint, ')
          ..write('isPassed: $isPassed')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceRecordsTable extends MaintenanceRecords
    with TableInfo<$MaintenanceRecordsTable, MaintenanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inspectionIdMeta = const VerificationMeta(
    'inspectionId',
  );
  @override
  late final GeneratedColumn<int> inspectionId = GeneratedColumn<int>(
    'inspection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issueMeta = const VerificationMeta('issue');
  @override
  late final GeneratedColumn<String> issue = GeneratedColumn<String>(
    'issue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionId,
    issue,
    description,
    priority,
    status,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_id')) {
      context.handle(
        _inspectionIdMeta,
        inspectionId.isAcceptableOrUnknown(
          data['inspection_id']!,
          _inspectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionIdMeta);
    }
    if (data.containsKey('issue')) {
      context.handle(
        _issueMeta,
        issue.isAcceptableOrUnknown(data['issue']!, _issueMeta),
      );
    } else if (isInserting) {
      context.missing(_issueMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inspection_id'],
      )!,
      issue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issue'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $MaintenanceRecordsTable createAlias(String alias) {
    return $MaintenanceRecordsTable(attachedDatabase, alias);
  }
}

class MaintenanceRecord extends DataClass
    implements Insertable<MaintenanceRecord> {
  final int id;
  final int inspectionId;
  final String issue;
  final String description;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  const MaintenanceRecord({
    required this.id,
    required this.inspectionId,
    required this.issue,
    required this.description,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inspection_id'] = Variable<int>(inspectionId);
    map['issue'] = Variable<String>(issue);
    map['description'] = Variable<String>(description);
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  MaintenanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceRecordsCompanion(
      id: Value(id),
      inspectionId: Value(inspectionId),
      issue: Value(issue),
      description: Value(description),
      priority: Value(priority),
      status: Value(status),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory MaintenanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceRecord(
      id: serializer.fromJson<int>(json['id']),
      inspectionId: serializer.fromJson<int>(json['inspectionId']),
      issue: serializer.fromJson<String>(json['issue']),
      description: serializer.fromJson<String>(json['description']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionId': serializer.toJson<int>(inspectionId),
      'issue': serializer.toJson<String>(issue),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  MaintenanceRecord copyWith({
    int? id,
    int? inspectionId,
    String? issue,
    String? description,
    String? priority,
    String? status,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => MaintenanceRecord(
    id: id ?? this.id,
    inspectionId: inspectionId ?? this.inspectionId,
    issue: issue ?? this.issue,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  MaintenanceRecord copyWithCompanion(MaintenanceRecordsCompanion data) {
    return MaintenanceRecord(
      id: data.id.present ? data.id.value : this.id,
      inspectionId: data.inspectionId.present
          ? data.inspectionId.value
          : this.inspectionId,
      issue: data.issue.present ? data.issue.value : this.issue,
      description: data.description.present
          ? data.description.value
          : this.description,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecord(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('issue: $issue, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inspectionId,
    issue,
    description,
    priority,
    status,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceRecord &&
          other.id == this.id &&
          other.inspectionId == this.inspectionId &&
          other.issue == this.issue &&
          other.description == this.description &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class MaintenanceRecordsCompanion extends UpdateCompanion<MaintenanceRecord> {
  final Value<int> id;
  final Value<int> inspectionId;
  final Value<String> issue;
  final Value<String> description;
  final Value<String> priority;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  const MaintenanceRecordsCompanion({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    this.issue = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  MaintenanceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int inspectionId,
    required String issue,
    required String description,
    required String priority,
    required String status,
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
  }) : inspectionId = Value(inspectionId),
       issue = Value(issue),
       description = Value(description),
       priority = Value(priority),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<MaintenanceRecord> custom({
    Expression<int>? id,
    Expression<int>? inspectionId,
    Expression<String>? issue,
    Expression<String>? description,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionId != null) 'inspection_id': inspectionId,
      if (issue != null) 'issue': issue,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  MaintenanceRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? inspectionId,
    Value<String>? issue,
    Value<String>? description,
    Value<String>? priority,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
  }) {
    return MaintenanceRecordsCompanion(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      issue: issue ?? this.issue,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionId.present) {
      map['inspection_id'] = Variable<int>(inspectionId.value);
    }
    if (issue.present) {
      map['issue'] = Variable<String>(issue.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('issue: $issue, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncOperationsTable extends SyncOperations
    with TableInfo<$SyncOperationsTable, SyncOperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOperationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    operationType,
    payload,
    status,
    createdAt,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOperation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOperation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncOperationsTable createAlias(String alias) {
    return $SyncOperationsTable(attachedDatabase, alias);
  }
}

class SyncOperation extends DataClass implements Insertable<SyncOperation> {
  final int id;
  final String operationType;
  final String payload;
  final String status;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;
  const SyncOperation({
    required this.id,
    required this.operationType,
    required this.payload,
    required this.status,
    required this.createdAt,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncOperationsCompanion toCompanion(bool nullToAbsent) {
    return SyncOperationsCompanion(
      id: Value(id),
      operationType: Value(operationType),
      payload: Value(payload),
      status: Value(status),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncOperation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOperation(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncOperation copyWith({
    int? id,
    String? operationType,
    String? payload,
    String? status,
    DateTime? createdAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncOperation(
    id: id ?? this.id,
    operationType: operationType ?? this.operationType,
    payload: payload ?? this.payload,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncOperation copyWithCompanion(SyncOperationsCompanion data) {
    return SyncOperation(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOperation(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    operationType,
    payload,
    status,
    createdAt,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOperation &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class SyncOperationsCompanion extends UpdateCompanion<SyncOperation> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> payload;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  const SyncOperationsCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncOperationsCompanion.insert({
    this.id = const Value.absent(),
    required String operationType,
    required String payload,
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : operationType = Value(operationType),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncOperation> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncOperationsCompanion copyWith({
    Value<int>? id,
    Value<String>? operationType,
    Value<String>? payload,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
  }) {
    return SyncOperationsCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOperationsCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $InspectionsTable inspections = $InspectionsTable(this);
  late final $InspectionChecklistItemsTable inspectionChecklistItems =
      $InspectionChecklistItemsTable(this);
  late final $InspectionEvidenceRecordsTable inspectionEvidenceRecords =
      $InspectionEvidenceRecordsTable(this);
  late final $ArInspectionRecordsTable arInspectionRecords =
      $ArInspectionRecordsTable(this);
  late final $ArInspectionResultRecordsTable arInspectionResultRecords =
      $ArInspectionResultRecordsTable(this);
  late final $MaintenanceRecordsTable maintenanceRecords =
      $MaintenanceRecordsTable(this);
  late final $SyncOperationsTable syncOperations = $SyncOperationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    inspections,
    inspectionChecklistItems,
    inspectionEvidenceRecords,
    arInspectionRecords,
    arInspectionResultRecords,
    maintenanceRecords,
    syncOperations,
  ];
}

typedef $$InspectionsTableCreateCompanionBuilder =
    InspectionsCompanion Function({
      Value<int> id,
      required int assetId,
      required String engineerId,
      required String status,
      required DateTime inspectionDate,
    });
typedef $$InspectionsTableUpdateCompanionBuilder =
    InspectionsCompanion Function({
      Value<int> id,
      Value<int> assetId,
      Value<String> engineerId,
      Value<String> status,
      Value<DateTime> inspectionDate,
    });

class $$InspectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableFilterComposer({
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

  ColumnFilters<int> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineerId => $composableBuilder(
    column: $table.engineerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableOrderingComposer({
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

  ColumnOrderings<int> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineerId => $composableBuilder(
    column: $table.engineerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get engineerId => $composableBuilder(
    column: $table.engineerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get inspectionDate => $composableBuilder(
    column: $table.inspectionDate,
    builder: (column) => column,
  );
}

class $$InspectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionsTable,
          Inspection,
          $$InspectionsTableFilterComposer,
          $$InspectionsTableOrderingComposer,
          $$InspectionsTableAnnotationComposer,
          $$InspectionsTableCreateCompanionBuilder,
          $$InspectionsTableUpdateCompanionBuilder,
          (
            Inspection,
            BaseReferences<_$AppDatabase, $InspectionsTable, Inspection>,
          ),
          Inspection,
          PrefetchHooks Function()
        > {
  $$InspectionsTableTableManager(_$AppDatabase db, $InspectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> assetId = const Value.absent(),
                Value<String> engineerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> inspectionDate = const Value.absent(),
              }) => InspectionsCompanion(
                id: id,
                assetId: assetId,
                engineerId: engineerId,
                status: status,
                inspectionDate: inspectionDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int assetId,
                required String engineerId,
                required String status,
                required DateTime inspectionDate,
              }) => InspectionsCompanion.insert(
                id: id,
                assetId: assetId,
                engineerId: engineerId,
                status: status,
                inspectionDate: inspectionDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionsTable,
      Inspection,
      $$InspectionsTableFilterComposer,
      $$InspectionsTableOrderingComposer,
      $$InspectionsTableAnnotationComposer,
      $$InspectionsTableCreateCompanionBuilder,
      $$InspectionsTableUpdateCompanionBuilder,
      (
        Inspection,
        BaseReferences<_$AppDatabase, $InspectionsTable, Inspection>,
      ),
      Inspection,
      PrefetchHooks Function()
    >;
typedef $$InspectionChecklistItemsTableCreateCompanionBuilder =
    InspectionChecklistItemsCompanion Function({
      Value<int> id,
      required int inspectionId,
      required String title,
      Value<bool> isPassed,
      Value<String?> notes,
    });
typedef $$InspectionChecklistItemsTableUpdateCompanionBuilder =
    InspectionChecklistItemsCompanion Function({
      Value<int> id,
      Value<int> inspectionId,
      Value<String> title,
      Value<bool> isPassed,
      Value<String?> notes,
    });

class $$InspectionChecklistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionChecklistItemsTable> {
  $$InspectionChecklistItemsTableFilterComposer({
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

  ColumnFilters<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPassed => $composableBuilder(
    column: $table.isPassed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionChecklistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionChecklistItemsTable> {
  $$InspectionChecklistItemsTableOrderingComposer({
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

  ColumnOrderings<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPassed => $composableBuilder(
    column: $table.isPassed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionChecklistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionChecklistItemsTable> {
  $$InspectionChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isPassed =>
      $composableBuilder(column: $table.isPassed, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$InspectionChecklistItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionChecklistItemsTable,
          InspectionChecklistItem,
          $$InspectionChecklistItemsTableFilterComposer,
          $$InspectionChecklistItemsTableOrderingComposer,
          $$InspectionChecklistItemsTableAnnotationComposer,
          $$InspectionChecklistItemsTableCreateCompanionBuilder,
          $$InspectionChecklistItemsTableUpdateCompanionBuilder,
          (
            InspectionChecklistItem,
            BaseReferences<
              _$AppDatabase,
              $InspectionChecklistItemsTable,
              InspectionChecklistItem
            >,
          ),
          InspectionChecklistItem,
          PrefetchHooks Function()
        > {
  $$InspectionChecklistItemsTableTableManager(
    _$AppDatabase db,
    $InspectionChecklistItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionChecklistItemsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InspectionChecklistItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InspectionChecklistItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> inspectionId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> isPassed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => InspectionChecklistItemsCompanion(
                id: id,
                inspectionId: inspectionId,
                title: title,
                isPassed: isPassed,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int inspectionId,
                required String title,
                Value<bool> isPassed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => InspectionChecklistItemsCompanion.insert(
                id: id,
                inspectionId: inspectionId,
                title: title,
                isPassed: isPassed,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionChecklistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionChecklistItemsTable,
      InspectionChecklistItem,
      $$InspectionChecklistItemsTableFilterComposer,
      $$InspectionChecklistItemsTableOrderingComposer,
      $$InspectionChecklistItemsTableAnnotationComposer,
      $$InspectionChecklistItemsTableCreateCompanionBuilder,
      $$InspectionChecklistItemsTableUpdateCompanionBuilder,
      (
        InspectionChecklistItem,
        BaseReferences<
          _$AppDatabase,
          $InspectionChecklistItemsTable,
          InspectionChecklistItem
        >,
      ),
      InspectionChecklistItem,
      PrefetchHooks Function()
    >;
typedef $$InspectionEvidenceRecordsTableCreateCompanionBuilder =
    InspectionEvidenceRecordsCompanion Function({
      Value<int> id,
      required int inspectionId,
      required int checklistItemId,
      required String imagePath,
      Value<Uint8List?> imageBytes,
      Value<String?> description,
      required DateTime createdAt,
    });
typedef $$InspectionEvidenceRecordsTableUpdateCompanionBuilder =
    InspectionEvidenceRecordsCompanion Function({
      Value<int> id,
      Value<int> inspectionId,
      Value<int> checklistItemId,
      Value<String> imagePath,
      Value<Uint8List?> imageBytes,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

class $$InspectionEvidenceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionEvidenceRecordsTable> {
  $$InspectionEvidenceRecordsTableFilterComposer({
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

  ColumnFilters<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checklistItemId => $composableBuilder(
    column: $table.checklistItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get imageBytes => $composableBuilder(
    column: $table.imageBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionEvidenceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionEvidenceRecordsTable> {
  $$InspectionEvidenceRecordsTableOrderingComposer({
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

  ColumnOrderings<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checklistItemId => $composableBuilder(
    column: $table.checklistItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get imageBytes => $composableBuilder(
    column: $table.imageBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionEvidenceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionEvidenceRecordsTable> {
  $$InspectionEvidenceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checklistItemId => $composableBuilder(
    column: $table.checklistItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<Uint8List> get imageBytes => $composableBuilder(
    column: $table.imageBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InspectionEvidenceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionEvidenceRecordsTable,
          InspectionEvidenceRecord,
          $$InspectionEvidenceRecordsTableFilterComposer,
          $$InspectionEvidenceRecordsTableOrderingComposer,
          $$InspectionEvidenceRecordsTableAnnotationComposer,
          $$InspectionEvidenceRecordsTableCreateCompanionBuilder,
          $$InspectionEvidenceRecordsTableUpdateCompanionBuilder,
          (
            InspectionEvidenceRecord,
            BaseReferences<
              _$AppDatabase,
              $InspectionEvidenceRecordsTable,
              InspectionEvidenceRecord
            >,
          ),
          InspectionEvidenceRecord,
          PrefetchHooks Function()
        > {
  $$InspectionEvidenceRecordsTableTableManager(
    _$AppDatabase db,
    $InspectionEvidenceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionEvidenceRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InspectionEvidenceRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InspectionEvidenceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> inspectionId = const Value.absent(),
                Value<int> checklistItemId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<Uint8List?> imageBytes = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InspectionEvidenceRecordsCompanion(
                id: id,
                inspectionId: inspectionId,
                checklistItemId: checklistItemId,
                imagePath: imagePath,
                imageBytes: imageBytes,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int inspectionId,
                required int checklistItemId,
                required String imagePath,
                Value<Uint8List?> imageBytes = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
              }) => InspectionEvidenceRecordsCompanion.insert(
                id: id,
                inspectionId: inspectionId,
                checklistItemId: checklistItemId,
                imagePath: imagePath,
                imageBytes: imageBytes,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionEvidenceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionEvidenceRecordsTable,
      InspectionEvidenceRecord,
      $$InspectionEvidenceRecordsTableFilterComposer,
      $$InspectionEvidenceRecordsTableOrderingComposer,
      $$InspectionEvidenceRecordsTableAnnotationComposer,
      $$InspectionEvidenceRecordsTableCreateCompanionBuilder,
      $$InspectionEvidenceRecordsTableUpdateCompanionBuilder,
      (
        InspectionEvidenceRecord,
        BaseReferences<
          _$AppDatabase,
          $InspectionEvidenceRecordsTable,
          InspectionEvidenceRecord
        >,
      ),
      InspectionEvidenceRecord,
      PrefetchHooks Function()
    >;
typedef $$ArInspectionRecordsTableCreateCompanionBuilder =
    ArInspectionRecordsCompanion Function({
      Value<int> id,
      Value<int?> inspectionId,
      required int assetId,
      required String assetName,
      required String assetCode,
      Value<bool> isArAvailable,
      required String status,
      Value<String?> resultSummary,
    });
typedef $$ArInspectionRecordsTableUpdateCompanionBuilder =
    ArInspectionRecordsCompanion Function({
      Value<int> id,
      Value<int?> inspectionId,
      Value<int> assetId,
      Value<String> assetName,
      Value<String> assetCode,
      Value<bool> isArAvailable,
      Value<String> status,
      Value<String?> resultSummary,
    });

class $$ArInspectionRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ArInspectionRecordsTable> {
  $$ArInspectionRecordsTableFilterComposer({
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

  ColumnFilters<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArAvailable => $composableBuilder(
    column: $table.isArAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultSummary => $composableBuilder(
    column: $table.resultSummary,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArInspectionRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArInspectionRecordsTable> {
  $$ArInspectionRecordsTableOrderingComposer({
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

  ColumnOrderings<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArAvailable => $composableBuilder(
    column: $table.isArAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultSummary => $composableBuilder(
    column: $table.resultSummary,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArInspectionRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArInspectionRecordsTable> {
  $$ArInspectionRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get assetName =>
      $composableBuilder(column: $table.assetName, builder: (column) => column);

  GeneratedColumn<String> get assetCode =>
      $composableBuilder(column: $table.assetCode, builder: (column) => column);

  GeneratedColumn<bool> get isArAvailable => $composableBuilder(
    column: $table.isArAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get resultSummary => $composableBuilder(
    column: $table.resultSummary,
    builder: (column) => column,
  );
}

class $$ArInspectionRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArInspectionRecordsTable,
          ArInspectionRecord,
          $$ArInspectionRecordsTableFilterComposer,
          $$ArInspectionRecordsTableOrderingComposer,
          $$ArInspectionRecordsTableAnnotationComposer,
          $$ArInspectionRecordsTableCreateCompanionBuilder,
          $$ArInspectionRecordsTableUpdateCompanionBuilder,
          (
            ArInspectionRecord,
            BaseReferences<
              _$AppDatabase,
              $ArInspectionRecordsTable,
              ArInspectionRecord
            >,
          ),
          ArInspectionRecord,
          PrefetchHooks Function()
        > {
  $$ArInspectionRecordsTableTableManager(
    _$AppDatabase db,
    $ArInspectionRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArInspectionRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArInspectionRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ArInspectionRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> inspectionId = const Value.absent(),
                Value<int> assetId = const Value.absent(),
                Value<String> assetName = const Value.absent(),
                Value<String> assetCode = const Value.absent(),
                Value<bool> isArAvailable = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> resultSummary = const Value.absent(),
              }) => ArInspectionRecordsCompanion(
                id: id,
                inspectionId: inspectionId,
                assetId: assetId,
                assetName: assetName,
                assetCode: assetCode,
                isArAvailable: isArAvailable,
                status: status,
                resultSummary: resultSummary,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> inspectionId = const Value.absent(),
                required int assetId,
                required String assetName,
                required String assetCode,
                Value<bool> isArAvailable = const Value.absent(),
                required String status,
                Value<String?> resultSummary = const Value.absent(),
              }) => ArInspectionRecordsCompanion.insert(
                id: id,
                inspectionId: inspectionId,
                assetId: assetId,
                assetName: assetName,
                assetCode: assetCode,
                isArAvailable: isArAvailable,
                status: status,
                resultSummary: resultSummary,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArInspectionRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArInspectionRecordsTable,
      ArInspectionRecord,
      $$ArInspectionRecordsTableFilterComposer,
      $$ArInspectionRecordsTableOrderingComposer,
      $$ArInspectionRecordsTableAnnotationComposer,
      $$ArInspectionRecordsTableCreateCompanionBuilder,
      $$ArInspectionRecordsTableUpdateCompanionBuilder,
      (
        ArInspectionRecord,
        BaseReferences<
          _$AppDatabase,
          $ArInspectionRecordsTable,
          ArInspectionRecord
        >,
      ),
      ArInspectionRecord,
      PrefetchHooks Function()
    >;
typedef $$ArInspectionResultRecordsTableCreateCompanionBuilder =
    ArInspectionResultRecordsCompanion Function({
      Value<int> id,
      required int arInspectionId,
      required String inspectionPoint,
      required bool isPassed,
    });
typedef $$ArInspectionResultRecordsTableUpdateCompanionBuilder =
    ArInspectionResultRecordsCompanion Function({
      Value<int> id,
      Value<int> arInspectionId,
      Value<String> inspectionPoint,
      Value<bool> isPassed,
    });

class $$ArInspectionResultRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ArInspectionResultRecordsTable> {
  $$ArInspectionResultRecordsTableFilterComposer({
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

  ColumnFilters<int> get arInspectionId => $composableBuilder(
    column: $table.arInspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inspectionPoint => $composableBuilder(
    column: $table.inspectionPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPassed => $composableBuilder(
    column: $table.isPassed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArInspectionResultRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArInspectionResultRecordsTable> {
  $$ArInspectionResultRecordsTableOrderingComposer({
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

  ColumnOrderings<int> get arInspectionId => $composableBuilder(
    column: $table.arInspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inspectionPoint => $composableBuilder(
    column: $table.inspectionPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPassed => $composableBuilder(
    column: $table.isPassed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArInspectionResultRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArInspectionResultRecordsTable> {
  $$ArInspectionResultRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get arInspectionId => $composableBuilder(
    column: $table.arInspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inspectionPoint => $composableBuilder(
    column: $table.inspectionPoint,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPassed =>
      $composableBuilder(column: $table.isPassed, builder: (column) => column);
}

class $$ArInspectionResultRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArInspectionResultRecordsTable,
          ArInspectionResultRecord,
          $$ArInspectionResultRecordsTableFilterComposer,
          $$ArInspectionResultRecordsTableOrderingComposer,
          $$ArInspectionResultRecordsTableAnnotationComposer,
          $$ArInspectionResultRecordsTableCreateCompanionBuilder,
          $$ArInspectionResultRecordsTableUpdateCompanionBuilder,
          (
            ArInspectionResultRecord,
            BaseReferences<
              _$AppDatabase,
              $ArInspectionResultRecordsTable,
              ArInspectionResultRecord
            >,
          ),
          ArInspectionResultRecord,
          PrefetchHooks Function()
        > {
  $$ArInspectionResultRecordsTableTableManager(
    _$AppDatabase db,
    $ArInspectionResultRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArInspectionResultRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ArInspectionResultRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ArInspectionResultRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> arInspectionId = const Value.absent(),
                Value<String> inspectionPoint = const Value.absent(),
                Value<bool> isPassed = const Value.absent(),
              }) => ArInspectionResultRecordsCompanion(
                id: id,
                arInspectionId: arInspectionId,
                inspectionPoint: inspectionPoint,
                isPassed: isPassed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int arInspectionId,
                required String inspectionPoint,
                required bool isPassed,
              }) => ArInspectionResultRecordsCompanion.insert(
                id: id,
                arInspectionId: arInspectionId,
                inspectionPoint: inspectionPoint,
                isPassed: isPassed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArInspectionResultRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArInspectionResultRecordsTable,
      ArInspectionResultRecord,
      $$ArInspectionResultRecordsTableFilterComposer,
      $$ArInspectionResultRecordsTableOrderingComposer,
      $$ArInspectionResultRecordsTableAnnotationComposer,
      $$ArInspectionResultRecordsTableCreateCompanionBuilder,
      $$ArInspectionResultRecordsTableUpdateCompanionBuilder,
      (
        ArInspectionResultRecord,
        BaseReferences<
          _$AppDatabase,
          $ArInspectionResultRecordsTable,
          ArInspectionResultRecord
        >,
      ),
      ArInspectionResultRecord,
      PrefetchHooks Function()
    >;
typedef $$MaintenanceRecordsTableCreateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      Value<int> id,
      required int inspectionId,
      required String issue,
      required String description,
      required String priority,
      required String status,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
    });
typedef $$MaintenanceRecordsTableUpdateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      Value<int> id,
      Value<int> inspectionId,
      Value<String> issue,
      Value<String> description,
      Value<String> priority,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });

class $$MaintenanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableFilterComposer({
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

  ColumnFilters<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issue => $composableBuilder(
    column: $table.issue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MaintenanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableOrderingComposer({
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

  ColumnOrderings<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issue => $composableBuilder(
    column: $table.issue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaintenanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get inspectionId => $composableBuilder(
    column: $table.inspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issue =>
      $composableBuilder(column: $table.issue, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$MaintenanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecord,
          $$MaintenanceRecordsTableFilterComposer,
          $$MaintenanceRecordsTableOrderingComposer,
          $$MaintenanceRecordsTableAnnotationComposer,
          $$MaintenanceRecordsTableCreateCompanionBuilder,
          $$MaintenanceRecordsTableUpdateCompanionBuilder,
          (
            MaintenanceRecord,
            BaseReferences<
              _$AppDatabase,
              $MaintenanceRecordsTable,
              MaintenanceRecord
            >,
          ),
          MaintenanceRecord,
          PrefetchHooks Function()
        > {
  $$MaintenanceRecordsTableTableManager(
    _$AppDatabase db,
    $MaintenanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> inspectionId = const Value.absent(),
                Value<String> issue = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => MaintenanceRecordsCompanion(
                id: id,
                inspectionId: inspectionId,
                issue: issue,
                description: description,
                priority: priority,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int inspectionId,
                required String issue,
                required String description,
                required String priority,
                required String status,
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
              }) => MaintenanceRecordsCompanion.insert(
                id: id,
                inspectionId: inspectionId,
                issue: issue,
                description: description,
                priority: priority,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaintenanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceRecordsTable,
      MaintenanceRecord,
      $$MaintenanceRecordsTableFilterComposer,
      $$MaintenanceRecordsTableOrderingComposer,
      $$MaintenanceRecordsTableAnnotationComposer,
      $$MaintenanceRecordsTableCreateCompanionBuilder,
      $$MaintenanceRecordsTableUpdateCompanionBuilder,
      (
        MaintenanceRecord,
        BaseReferences<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecord
        >,
      ),
      MaintenanceRecord,
      PrefetchHooks Function()
    >;
typedef $$SyncOperationsTableCreateCompanionBuilder =
    SyncOperationsCompanion Function({
      Value<int> id,
      required String operationType,
      required String payload,
      Value<String> status,
      required DateTime createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
    });
typedef $$SyncOperationsTableUpdateCompanionBuilder =
    SyncOperationsCompanion Function({
      Value<int> id,
      Value<String> operationType,
      Value<String> payload,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
    });

class $$SyncOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableFilterComposer({
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

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableOrderingComposer({
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

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOperationsTable,
          SyncOperation,
          $$SyncOperationsTableFilterComposer,
          $$SyncOperationsTableOrderingComposer,
          $$SyncOperationsTableAnnotationComposer,
          $$SyncOperationsTableCreateCompanionBuilder,
          $$SyncOperationsTableUpdateCompanionBuilder,
          (
            SyncOperation,
            BaseReferences<_$AppDatabase, $SyncOperationsTable, SyncOperation>,
          ),
          SyncOperation,
          PrefetchHooks Function()
        > {
  $$SyncOperationsTableTableManager(
    _$AppDatabase db,
    $SyncOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOperationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOperationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOperationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncOperationsCompanion(
                id: id,
                operationType: operationType,
                payload: payload,
                status: status,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String operationType,
                required String payload,
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncOperationsCompanion.insert(
                id: id,
                operationType: operationType,
                payload: payload,
                status: status,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOperationsTable,
      SyncOperation,
      $$SyncOperationsTableFilterComposer,
      $$SyncOperationsTableOrderingComposer,
      $$SyncOperationsTableAnnotationComposer,
      $$SyncOperationsTableCreateCompanionBuilder,
      $$SyncOperationsTableUpdateCompanionBuilder,
      (
        SyncOperation,
        BaseReferences<_$AppDatabase, $SyncOperationsTable, SyncOperation>,
      ),
      SyncOperation,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$InspectionsTableTableManager get inspections =>
      $$InspectionsTableTableManager(_db, _db.inspections);
  $$InspectionChecklistItemsTableTableManager get inspectionChecklistItems =>
      $$InspectionChecklistItemsTableTableManager(
        _db,
        _db.inspectionChecklistItems,
      );
  $$InspectionEvidenceRecordsTableTableManager get inspectionEvidenceRecords =>
      $$InspectionEvidenceRecordsTableTableManager(
        _db,
        _db.inspectionEvidenceRecords,
      );
  $$ArInspectionRecordsTableTableManager get arInspectionRecords =>
      $$ArInspectionRecordsTableTableManager(_db, _db.arInspectionRecords);
  $$ArInspectionResultRecordsTableTableManager get arInspectionResultRecords =>
      $$ArInspectionResultRecordsTableTableManager(
        _db,
        _db.arInspectionResultRecords,
      );
  $$MaintenanceRecordsTableTableManager get maintenanceRecords =>
      $$MaintenanceRecordsTableTableManager(_db, _db.maintenanceRecords);
  $$SyncOperationsTableTableManager get syncOperations =>
      $$SyncOperationsTableTableManager(_db, _db.syncOperations);
}
