// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qso_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQsoLogCollection on Isar {
  IsarCollection<QsoLog> get qsoLogs => this.collection();
}

const QsoLogSchema = CollectionSchema(
  name: r'QsoLog',
  id: -7413302992659315564,
  properties: {
    r'band': PropertySchema(id: 0, name: r'band', type: IsarType.string),
    r'callsign': PropertySchema(
      id: 1,
      name: r'callsign',
      type: IsarType.string,
    ),
    r'comment': PropertySchema(id: 2, name: r'comment', type: IsarType.string),
    r'gridSquare': PropertySchema(
      id: 3,
      name: r'gridSquare',
      type: IsarType.string,
    ),
    r'mode': PropertySchema(id: 4, name: r'mode', type: IsarType.string),
    r'mySig': PropertySchema(id: 5, name: r'mySig', type: IsarType.string),
    r'mySigInfo': PropertySchema(
      id: 6,
      name: r'mySigInfo',
      type: IsarType.string,
    ),
    r'operatorCallsign': PropertySchema(
      id: 7,
      name: r'operatorCallsign',
      type: IsarType.string,
    ),
    r'qsoDate': PropertySchema(
      id: 8,
      name: r'qsoDate',
      type: IsarType.dateTime,
    ),
    r'rstRcvd': PropertySchema(id: 9, name: r'rstRcvd', type: IsarType.string),
    r'rstSent': PropertySchema(id: 10, name: r'rstSent', type: IsarType.string),
    r'sig': PropertySchema(id: 11, name: r'sig', type: IsarType.string),
    r'sigInfo': PropertySchema(id: 12, name: r'sigInfo', type: IsarType.string),
    r'stationCallsign': PropertySchema(
      id: 13,
      name: r'stationCallsign',
      type: IsarType.string,
    ),
    r'timeOn': PropertySchema(id: 14, name: r'timeOn', type: IsarType.string),
    r'txPower': PropertySchema(id: 15, name: r'txPower', type: IsarType.long),
  },

  estimateSize: _qsoLogEstimateSize,
  serialize: _qsoLogSerialize,
  deserialize: _qsoLogDeserialize,
  deserializeProp: _qsoLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'callsign': IndexSchema(
      id: -1116449868755944675,
      name: r'callsign',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'callsign',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'qsoDate': IndexSchema(
      id: 1635251594755366315,
      name: r'qsoDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'qsoDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'band': IndexSchema(
      id: -3988149110696219656,
      name: r'band',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'band',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'mode': IndexSchema(
      id: 7416084707875161816,
      name: r'mode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'mode',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'mySigInfo': IndexSchema(
      id: -6694106093553799622,
      name: r'mySigInfo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'mySigInfo',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _qsoLogGetId,
  getLinks: _qsoLogGetLinks,
  attach: _qsoLogAttach,
  version: '3.3.2',
);

int _qsoLogEstimateSize(
  QsoLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.band.length * 3;
  bytesCount += 3 + object.callsign.length * 3;
  {
    final value = object.comment;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gridSquare;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mode.length * 3;
  bytesCount += 3 + object.mySig.length * 3;
  bytesCount += 3 + object.mySigInfo.length * 3;
  bytesCount += 3 + object.operatorCallsign.length * 3;
  {
    final value = object.rstRcvd;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rstSent;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sig;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sigInfo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.stationCallsign.length * 3;
  bytesCount += 3 + object.timeOn.length * 3;
  return bytesCount;
}

void _qsoLogSerialize(
  QsoLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.band);
  writer.writeString(offsets[1], object.callsign);
  writer.writeString(offsets[2], object.comment);
  writer.writeString(offsets[3], object.gridSquare);
  writer.writeString(offsets[4], object.mode);
  writer.writeString(offsets[5], object.mySig);
  writer.writeString(offsets[6], object.mySigInfo);
  writer.writeString(offsets[7], object.operatorCallsign);
  writer.writeDateTime(offsets[8], object.qsoDate);
  writer.writeString(offsets[9], object.rstRcvd);
  writer.writeString(offsets[10], object.rstSent);
  writer.writeString(offsets[11], object.sig);
  writer.writeString(offsets[12], object.sigInfo);
  writer.writeString(offsets[13], object.stationCallsign);
  writer.writeString(offsets[14], object.timeOn);
  writer.writeLong(offsets[15], object.txPower);
}

QsoLog _qsoLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QsoLog();
  object.band = reader.readString(offsets[0]);
  object.callsign = reader.readString(offsets[1]);
  object.comment = reader.readStringOrNull(offsets[2]);
  object.gridSquare = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.mode = reader.readString(offsets[4]);
  object.mySig = reader.readString(offsets[5]);
  object.mySigInfo = reader.readString(offsets[6]);
  object.operatorCallsign = reader.readString(offsets[7]);
  object.qsoDate = reader.readDateTime(offsets[8]);
  object.rstRcvd = reader.readStringOrNull(offsets[9]);
  object.rstSent = reader.readStringOrNull(offsets[10]);
  object.sig = reader.readStringOrNull(offsets[11]);
  object.sigInfo = reader.readStringOrNull(offsets[12]);
  object.stationCallsign = reader.readString(offsets[13]);
  object.timeOn = reader.readString(offsets[14]);
  object.txPower = reader.readLongOrNull(offsets[15]);
  return object;
}

P _qsoLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _qsoLogGetId(QsoLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _qsoLogGetLinks(QsoLog object) {
  return [];
}

void _qsoLogAttach(IsarCollection<dynamic> col, Id id, QsoLog object) {
  object.id = id;
}

extension QsoLogQueryWhereSort on QueryBuilder<QsoLog, QsoLog, QWhere> {
  QueryBuilder<QsoLog, QsoLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhere> anyCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'callsign'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhere> anyQsoDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'qsoDate'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhere> anyMySigInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'mySigInfo'),
      );
    });
  }
}

extension QsoLogQueryWhere on QueryBuilder<QsoLog, QsoLog, QWhereClause> {
  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignEqualTo(
    String callsign,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'callsign', value: [callsign]),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignNotEqualTo(
    String callsign,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'callsign',
                lower: [],
                upper: [callsign],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'callsign',
                lower: [callsign],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'callsign',
                lower: [callsign],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'callsign',
                lower: [],
                upper: [callsign],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignGreaterThan(
    String callsign, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'callsign',
          lower: [callsign],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignLessThan(
    String callsign, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'callsign',
          lower: [],
          upper: [callsign],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignBetween(
    String lowerCallsign,
    String upperCallsign, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'callsign',
          lower: [lowerCallsign],
          includeLower: includeLower,
          upper: [upperCallsign],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignStartsWith(
    String CallsignPrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'callsign',
          lower: [CallsignPrefix],
          upper: ['$CallsignPrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'callsign', value: ['']),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> callsignIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'callsign', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'callsign', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'callsign', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'callsign', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> qsoDateEqualTo(
    DateTime qsoDate,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'qsoDate', value: [qsoDate]),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> qsoDateNotEqualTo(
    DateTime qsoDate,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'qsoDate',
                lower: [],
                upper: [qsoDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'qsoDate',
                lower: [qsoDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'qsoDate',
                lower: [qsoDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'qsoDate',
                lower: [],
                upper: [qsoDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> qsoDateGreaterThan(
    DateTime qsoDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'qsoDate',
          lower: [qsoDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> qsoDateLessThan(
    DateTime qsoDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'qsoDate',
          lower: [],
          upper: [qsoDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> qsoDateBetween(
    DateTime lowerQsoDate,
    DateTime upperQsoDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'qsoDate',
          lower: [lowerQsoDate],
          includeLower: includeLower,
          upper: [upperQsoDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> bandEqualTo(String band) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'band', value: [band]),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> bandNotEqualTo(String band) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'band',
                lower: [],
                upper: [band],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'band',
                lower: [band],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'band',
                lower: [band],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'band',
                lower: [],
                upper: [band],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> modeEqualTo(String mode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'mode', value: [mode]),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> modeNotEqualTo(String mode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mode',
                lower: [],
                upper: [mode],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mode',
                lower: [mode],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mode',
                lower: [mode],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mode',
                lower: [],
                upper: [mode],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoEqualTo(
    String mySigInfo,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'mySigInfo', value: [mySigInfo]),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoNotEqualTo(
    String mySigInfo,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mySigInfo',
                lower: [],
                upper: [mySigInfo],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mySigInfo',
                lower: [mySigInfo],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mySigInfo',
                lower: [mySigInfo],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'mySigInfo',
                lower: [],
                upper: [mySigInfo],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoGreaterThan(
    String mySigInfo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'mySigInfo',
          lower: [mySigInfo],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoLessThan(
    String mySigInfo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'mySigInfo',
          lower: [],
          upper: [mySigInfo],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoBetween(
    String lowerMySigInfo,
    String upperMySigInfo, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'mySigInfo',
          lower: [lowerMySigInfo],
          includeLower: includeLower,
          upper: [upperMySigInfo],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoStartsWith(
    String MySigInfoPrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'mySigInfo',
          lower: [MySigInfoPrefix],
          upper: ['$MySigInfoPrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'mySigInfo', value: ['']),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterWhereClause> mySigInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'mySigInfo', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'mySigInfo',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'mySigInfo',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'mySigInfo', upper: ['']),
            );
      }
    });
  }
}

extension QsoLogQueryFilter on QueryBuilder<QsoLog, QsoLog, QFilterCondition> {
  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'band',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'band',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'band',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'band', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> bandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'band', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'callsign',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'callsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'callsign',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'callsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> callsignIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'callsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'comment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'comment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> commentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gridSquare'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gridSquare'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gridSquare',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'gridSquare',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'gridSquare',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gridSquare', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> gridSquareIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'gridSquare', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mode', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> modeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mode', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mySig',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mySig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mySig',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mySig', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mySig', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mySigInfo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mySigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mySigInfo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mySigInfo', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> mySigInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mySigInfo', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  operatorCallsignGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'operatorCallsign',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  operatorCallsignStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'operatorCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> operatorCallsignMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'operatorCallsign',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  operatorCallsignIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'operatorCallsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  operatorCallsignIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'operatorCallsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> qsoDateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qsoDate', value: value),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> qsoDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qsoDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> qsoDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qsoDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> qsoDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qsoDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rstRcvd'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rstRcvd'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rstRcvd',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'rstRcvd',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'rstRcvd',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rstRcvd', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstRcvdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'rstRcvd', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rstSent'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rstSent'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rstSent',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'rstSent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'rstSent',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rstSent', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> rstSentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'rstSent', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sig'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sig'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sig',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sig',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sig',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sig', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sig', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sigInfo'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sigInfo'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sigInfo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sigInfo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sigInfo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sigInfo', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> sigInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sigInfo', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  stationCallsignGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stationCallsign',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'stationCallsign',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'stationCallsign',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> stationCallsignIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stationCallsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition>
  stationCallsignIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'stationCallsign', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeOn',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeOn',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeOn',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeOn', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> timeOnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timeOn', value: ''),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'txPower'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'txPower'),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'txPower', value: value),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'txPower',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'txPower',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterFilterCondition> txPowerBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'txPower',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QsoLogQueryObject on QueryBuilder<QsoLog, QsoLog, QFilterCondition> {}

extension QsoLogQueryLinks on QueryBuilder<QsoLog, QsoLog, QFilterCondition> {}

extension QsoLogQuerySortBy on QueryBuilder<QsoLog, QsoLog, QSortBy> {
  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByBand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'band', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByBandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'band', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByGridSquare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridSquare', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByGridSquareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridSquare', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByMySig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySig', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByMySigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySig', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByMySigInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySigInfo', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByMySigInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySigInfo', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByOperatorCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorCallsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByOperatorCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorCallsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByQsoDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qsoDate', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByQsoDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qsoDate', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByRstRcvd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstRcvd', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByRstRcvdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstRcvd', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByRstSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstSent', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByRstSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstSent', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortBySig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sig', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortBySigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sig', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortBySigInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigInfo', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortBySigInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigInfo', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByStationCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationCallsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByStationCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationCallsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByTimeOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOn', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByTimeOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOn', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByTxPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txPower', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> sortByTxPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txPower', Sort.desc);
    });
  }
}

extension QsoLogQuerySortThenBy on QueryBuilder<QsoLog, QsoLog, QSortThenBy> {
  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByBand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'band', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByBandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'band', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByGridSquare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridSquare', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByGridSquareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridSquare', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByMySig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySig', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByMySigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySig', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByMySigInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySigInfo', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByMySigInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mySigInfo', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByOperatorCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorCallsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByOperatorCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operatorCallsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByQsoDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qsoDate', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByQsoDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qsoDate', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByRstRcvd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstRcvd', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByRstRcvdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstRcvd', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByRstSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstSent', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByRstSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rstSent', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenBySig() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sig', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenBySigDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sig', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenBySigInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigInfo', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenBySigInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigInfo', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByStationCallsign() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationCallsign', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByStationCallsignDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationCallsign', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByTimeOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOn', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByTimeOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOn', Sort.desc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByTxPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txPower', Sort.asc);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QAfterSortBy> thenByTxPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txPower', Sort.desc);
    });
  }
}

extension QsoLogQueryWhereDistinct on QueryBuilder<QsoLog, QsoLog, QDistinct> {
  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByBand({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'band', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByCallsign({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callsign', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByComment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByGridSquare({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gridSquare', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByMode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByMySig({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mySig', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByMySigInfo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mySigInfo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByOperatorCallsign({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'operatorCallsign',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByQsoDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qsoDate');
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByRstRcvd({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rstRcvd', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByRstSent({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rstSent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctBySig({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sig', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctBySigInfo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sigInfo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByStationCallsign({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'stationCallsign',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByTimeOn({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeOn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QsoLog, QsoLog, QDistinct> distinctByTxPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txPower');
    });
  }
}

extension QsoLogQueryProperty on QueryBuilder<QsoLog, QsoLog, QQueryProperty> {
  QueryBuilder<QsoLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> bandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'band');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> callsignProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callsign');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comment');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> gridSquareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gridSquare');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> modeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mode');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> mySigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mySig');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> mySigInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mySigInfo');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> operatorCallsignProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operatorCallsign');
    });
  }

  QueryBuilder<QsoLog, DateTime, QQueryOperations> qsoDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qsoDate');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> rstRcvdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rstRcvd');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> rstSentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rstSent');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> sigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sig');
    });
  }

  QueryBuilder<QsoLog, String?, QQueryOperations> sigInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sigInfo');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> stationCallsignProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stationCallsign');
    });
  }

  QueryBuilder<QsoLog, String, QQueryOperations> timeOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeOn');
    });
  }

  QueryBuilder<QsoLog, int?, QQueryOperations> txPowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txPower');
    });
  }
}
