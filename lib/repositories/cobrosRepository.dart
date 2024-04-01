import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:san_juan/models/cobro.dart';
import 'package:path/path.dart' as path;
import '../models/estatus.dart';

Future<Database> _getDatabase() async {
  // openDatabase(path, onCreate:_createDb, onUpgrade: onUpgrade,version:_DB_VERSION);
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'cobros.db'),
    onCreate: (db, version) async {
      print("borrando tablas");
      await db.execute("DROP TABLE IF EXISTS cobros");
      print("creando tablas");
      await db.execute(
          'CREATE TABLE cobros(idCuenta  INT PRIMARY KEY,idCobrador INT,idContrato INT,idCliente INT,claveCuenta TEXT,fechaVenta TEXT,idTipoPago INT,diaPago TEXT,diaPagoA INT,diaPagoB INT,fechaProximoPago TEXT,idPersona INT,nombreCliente TEXT,idDireccion INT,calle TEXT,noExt TEXT,noInt TEXT,colonia TEXT,delegacion TEXT,municipio TEXT,referencias TEXT,cp TEXT,orden INT,cobrado INT,subido INT,recibo INT,fotoIdentificacion TEXT,fotoFachada TEXT,montoCobradoEnVisita REAL,fechaSiguientePago TEXT,nota TEXT,visitado INT,montoTotal REAL,montoAbonoAcordado REAL,fechaPrimerPago TEXT,fechaTerminacionCredito TEXT,saldo REAL,porcentajePagado TEXT,pagosAtrasados INT,saldoAtrasado INT,productos TEXT,prontoPago TEXT,relacionPagos TEXT)');
      print("terminado de inicializacion de base de datos");
      //return true;
    },
    //onUpgrade: _upgradeTablas(),
    version: 1,
  );
  return db;
}

_inicializar() async {
  // obtener el path donde esta la base
  final dbPath = await sql.getDatabasesPath();
  // abrir la base cobros
  Database db = await sql.openDatabase(
    path.join(dbPath, 'cobros.db'),
    onCreate: (db, version) {},
    version: 1,
  );
  //tabla estatus
  print("inicializacion de estatus");
  // borrar
  print("borrado de estatus");
  await db.execute("DROP TABLE IF EXISTS estatus");
  // crear
  print("creacion de estatus");
  await db.execute(
      'CREATE TABLE estatus(id INT PRIMARY KEY,usuario TEXT, cargado INT)');
  // poner un registro
  print("insercion de registro en estatus");
  await db.insert('estatus', {'id': 1, 'usuario': '', 'cargado': 0});

  //tabla cobros
  // borrar tabla
  print("inicializacion de cobros");
  print("borrado de cobros");
  await db.execute("DROP TABLE IF EXISTS cobros");
  // crear
  print("creacion de cobros");
  await db.execute(
      'CREATE TABLE cobros(idCuenta  INT PRIMARY KEY,idCobrador INT,idContrato INT,idCliente INT,claveCuenta TEXT,fechaVenta TEXT,idTipoPago INT,diaPago TEXT,diaPagoA INT,diaPagoB INT,fechaProximoPago TEXT,idPersona INT,nombreCliente TEXT,idDireccion INT,calle TEXT,noExt TEXT,noInt TEXT,colonia TEXT,delegacion TEXT,municipio TEXT,referencias TEXT,cp TEXT,orden INT,cobrado INT,subido INT,fotoIdentificacion TEXT,fotoFachada TEXT,montoCobradoEnVisita REAL,fechaSiguientePago TEXT,nota TEXT,visitado INT,montoTotal REAL,montoAbonoAcordado REAL,fechaPrimerPago TEXT,fechaTerminacionCredito TEXT,saldo REAL,porcentajePagado TEXT,pagosAtrasados INT,saldoAtrasado INT,productos TEXT,prontoPago TEXT,relacionPagos TEXT)');
}

_upgradeTablas() async {
  // obtener el path donde esta la base
  final dbPath = await sql.getDatabasesPath();
  // abrir la base cobros
  Database db = await sql.openDatabase(
    path.join(dbPath, 'cobros.db'),
    onCreate: (db, version) {},
    version: 2,
  );
  //tabla estatus
  print("inicializacion de estatus");
  // borrar
  print("borrado de estatus");
  await db.execute("DROP TABLE IF EXISTS estatus");
  // crear
  print("creacion de estatus");
  await db.execute(
      'CREATE TABLE estatus(id INT PRIMARY KEY,usuario TEXT, cargado INT)');
  // poner un registro
  print("insercion de registro en estatus");
  await db.insert('estatus', {'id': 1, 'usuario': '', 'cargado': 0});

  //tabla cobros
  // borrar tabla
  print("inicializacion de cobros");
  print("borrado de cobros");
  await db.execute("DROP TABLE IF EXISTS cobros");
  // crear
  print("creacion de cobros");
  await db.execute(
      'CREATE TABLE cobros(idCuenta  INT PRIMARY KEY,idCobrador INT,idContrato INT,idCliente INT,claveCuenta TEXT,fechaVenta TEXT,idTipoPago INT,diaPago TEXT,diaPagoA INT,diaPagoB INT,fechaProximoPago TEXT,idPersona INT,nombreCliente TEXT,idDireccion INT,calle TEXT,noExt TEXT,noInt TEXT,colonia TEXT,delegacion TEXT,municipio TEXT,referencias TEXT,cp TEXT,orden INT,cobrado INT,subido INT,fotoIdentificacion TEXT,fotoFachada TEXT,montoCobradoEnVisita REAL,fechaSiguientePago TEXT,nota TEXT,visitado INT,montoTotal REAL,montoAbonoAcordado REAL,fechaPrimerPago TEXT,fechaTerminacionCredito TEXT,saldo REAL,porcentajePagado TEXT,pagosAtrasados INT,saldoAtrasado INT,productos TEXT,prontoPago TEXT,relacionPagos TEXT)');
}

Future<Database> _getDatabaseEstatus() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'estatus.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE estatus('
          'id INT PRIMARY KEY, '
          'usuario TEXT, '
          'cargado INT)');
    },
    version: 1,
  );
  return db;
}

/*Future<Database> _dropTableIfExistsThenReCreate() async {
  //here we get the Database object by calling the openDatabase method
  //which receives the path and onCreate function and all the good stuff
  final dbPath = await sql.getDatabasesPath();
  Database db = await sql.openDatabase(
    path.join(dbPath, 'cobros.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE cobros('
          'idCuenta  INT PRIMARY KEY,'
          'idCobrador INT,'
          'idContrato INT, '
          'idCliente INT,'
          'claveCuenta TEXT, '
          'idTipoPago INT, '
          'diaPago TEXT,'
          'diaPagoA INT, '
          'diaPagoB INT,'
          'montoTotal TEXT, '
          'abono TEXT, '
          'totalPagado TEXT, '
          'idPersona INT, '
          'nombreCliente TEXT,'
          'idDireccion INT,'
          'calle TEXT, '
          'noExt TEXT,'
          'noInt TEXT, '
          'colonia TEXT,'
          'delegacion TEXT, '
          'municipio TEXT, '
          'referencias TEXT, '
          'cp TEXT,'
          'orden INT, '
          'cobrado INT,'
          'subido INT, '
          'fotoIdentificacion TEXT,'
          'fotoFachada TEXT,'
          'montoPagado INT,'
          'fechaSiguientePago TEXT,'
          'nota TEXT)');
    },
    version: 1,
  );
  // Database db = await openDatabase(path,onCreate: ...);

  //here we execute a query to drop the table if exists which is called "tableName"
  //and could be given as method's input parameter too
  await db.execute("DROP TABLE IF EXISTS cobros");

  //and finally here we recreate our beloved "tableName" again which needs
  //some columns initialization
  await db.execute(
      'CREATE TABLE cobros(idCuenta  INT PRIMARY KEY,idCobrador INT,idContrato INT, idCliente INT,claveCuenta TEXT, idTipoPago INT, diaPago TEXT,diaPagoA INT, diaPagoB INT,montoTotal TEXT, abono TEXT,totalPagado TEXT, idPersona INT,nombreCliente TEXT,idDireccion INT,calle TEXT, noExt TEXT,noInt TEXT, colonia TEXT,delegacion TEXT, municipio TEXT, referencias TEXT, cp TEXT,orden INT, cobrado INT,subido INT, fotoIdentificacion TEXT,fotoFachada TEXT,montoPagado INT,fechaSiguientePago TEXT,nota TEXT)');
  return db;
}*/

// si se requiere activar actualizar estructura de tablas
Future<Database> _inicializarTablas() async {
  print("inicio de inicializacion de tablas");
  // obtener el path donde esta la base
  final dbPath = await sql.getDatabasesPath();
  // abrir la base cobros
  Database db = await sql.openDatabase(
    path.join(dbPath, 'cobros.db'),
    onCreate: (db, version) {},
    version: 1,
  );
  print("inicializacion de estatus");
  // borrar tabla estatus
  print("borrado de estatus");
  await db.execute("DROP TABLE IF EXISTS estatus");
  // creat tabla estatus
  print("creacion de estatus");
  await db.execute(
      'CREATE TABLE estatus(id INT PRIMARY KEY,usuario TEXT, cargado INT)');
  // poner un registro en estatus
  print("insercion de registro en estatus");
  await db.insert('estatus', {'id': 1, 'usuario': '', 'cargado': 0});
  // borrar tabla cobros
  print("inicializacion de cobros");
  print("borrado de cobros");
  await db.execute("DROP TABLE IF EXISTS cobros");
  // creat tabla cobros
  print("creacion de cobros");
  await db.execute('CREATE TABLE cobros('
      'idCuenta  INT PRIMARY KEY,'
      'idCobrador INT,'
      'idContrato INT, '
      'idCliente INT,'
      'claveCuenta TEXT, '
      'idTipoPago INT, '
      'diaPago TEXT,'
      'diaPagoA INT, '
      'diaPagoB INT,'
      'montoTotal TEXT, '
      'abono TEXT, '
      'totalPagado TEXT, '
      'saldo INT, '
      'idPersona INT, '
      'nombreCliente TEXT,'
      'idDireccion INT,'
      'calle TEXT, '
      'noExt TEXT,'
      'noInt TEXT, '
      'colonia TEXT,'
      'delegacion TEXT, '
      'municipio TEXT, '
      'referencias TEXT, '
      'cp TEXT,'
      'orden INT, '
      'cobrado INT,'
      'subido INT, '
      'recibo INT, '
      'fotoIdentificacion TEXT,'
      'fotoFachada TEXT,'
      'montoPagado INT,'
      'fechaSiguientePago TEXT,'
      'nota TEXT,'
      'visitado INT )');
  return db;
}

class CobrosRepository {
  //Future<List<Cobro>> get cobros => null;

  // para tabla estatus
  Future<List<Estatus>> getDatosStatus() async {
    // descomentar si se quiere reinicializar las tablas
    // en un dispositivo con otra estructura
    // final db = await _inicializarTablas();
    final db = await _getDatabase();
    var estatus;
    print('select registro 1 de estatus');
    final data = await db.query('estatus', where: "id=1");
    if (data.isEmpty) {
      print('no se encotro el registro de estatus');
      await db.insert('estatus', {'id': 1, 'usuario': '', 'cargado': 0});
      estatus = data
          .map((row) => Estatus(
                id: 1,
                usuario: '' as String,
                cargado: 0,
              ))
          .toList();
    } else {
      print('SI se encotro el registro de estatus');
      estatus = data
          .map((row) => Estatus(
                id: row['id'] as int,
                usuario: row['usuario'] as String,
                cargado: row['cargado'] as int,
              ))
          .toList();
    }
    return estatus;
  }

  Future<int> ponerCargado() async {
    final db = await _getDatabase();
    final resultado = await db.update(
      'estatus',
      {'id': 1, 'usuario': '', 'cargado': 1},
      where: "id = ?",
      whereArgs: [1],
    );
    if (await resultado == 1) {
      return 1;
    }
    return 0;
  }

  // para tabla cobros
  Future<bool> ponerCobros(List<Cobro> listaCobros) async {
    print("inicio de grabado de cobros");
    final db = await _getDatabase();
    // final db = await _dropTableIfExistsThenReCreate();
    db.delete('cobros');
    for (int index = 0; index < listaCobros.length; index++) {
      Cobro cobro = listaCobros[index];
      db.insert('cobros', {
        'idCuenta': cobro.idCuenta,
        'idCobrador': cobro.idCobrador,
        'idContrato': cobro.idContrato,
        'idCliente': cobro.idCliente,
        'claveCuenta': cobro.claveCuenta,
        'fechaVenta': cobro.fechaVenta,
        'idTipoPago': cobro.idTipoPago,
        'diaPago': cobro.diaPago,
        'diaPagoA': cobro.diaPagoA,
        'diaPagoB': cobro.diaPagoB,
        'fechaProximoPago': cobro.fechaProximoPago,
        'idPersona': cobro.idPersona,
        'nombreCliente': cobro.nombreCliente,
        'idDireccion': cobro.idDireccion,
        'calle': cobro.calle,
        'noExt': cobro.noExt,
        'noInt': cobro.noInt,
        'colonia': cobro.colonia,
        'delegacion': cobro.delegacion,
        'municipio': cobro.municipio,
        'referencias': cobro.referencias,
        'cp': cobro.cp,
        'orden': cobro.orden,
        'cobrado': cobro.cobrado,
        'subido': cobro.subido,
        'recibo': cobro.recibo,
        'fotoIdentificacion': cobro.fotoIdentificacion,
        'fotoFachada': cobro.fotoFachada,
        'montoCobradoEnVisita': cobro.montoCobradoEnVisita,
        'fechaSiguientePago': cobro.fechaSiguientePago,
        'nota': cobro.nota,
        'visitado': cobro.visitado,
        'montoTotal': cobro.montoTotal,
        'montoAbonoAcordado': cobro.montoAbonoAcordado,
        'fechaPrimerPago': cobro.fechaPrimerPago,
        'fechaTerminacionCredito': cobro.fechaTerminacionCredito,
        'saldo': cobro.saldo,
        'porcentajePagado': cobro.porcentajePagado,
        'pagosAtrasados': cobro.pagosAtrasados,
        'saldoAtrasado': cobro.saldoAtrasado,
        'productos': cobro.productos,
        'prontoPago': cobro.prontoPago,
        'relacionPagos': cobro.relacionPagos
      });
    }
    print("se termino grabado de cobros");
    return true;
  }

  Future<List<Cobro>> leerCobros() async {
    final db = await _getDatabase();
    final data =
        await db.query('cobros', where: 'visitado=0', orderBy: 'orden');
    final cobros = data
        .map(
          (row) => Cobro(
            idCuenta: row['idCuenta'] as int,
            idCobrador: row['idCobrador'] as int,
            idContrato: row['idContrato'] as int,
            idCliente: row['idCliente'] as int,
            claveCuenta: row['claveCuenta'] as String,
            fechaVenta: row['fechaVenta'] as String,
            idTipoPago: row['idTipoPago'] as int,
            diaPago: row['diaPago'] as String,
            diaPagoA: row['diaPagoA'] as int,
            diaPagoB: row['diaPagoB'] as int,
            fechaProximoPago: row['fechaProximoPago'] as String,
            idPersona: row['idPersona'] as int,
            nombreCliente: row['nombreCliente'] as String,
            idDireccion: row['idDireccion'] as int,
            calle: row['calle'] as String,
            noExt: row['noExt'] as String,
            noInt: row['noInt'] as String,
            colonia: row['colonia'] as String,
            delegacion: row['delegacion'] as String,
            municipio: row['municipio'] as String,
            referencias: row['referencias'] as String,
            cp: row['cp'] as String,
            orden: row['orden'] as int,
            cobrado: row['cobrado'] as int,
            subido: row['subido'] as int,
            recibo: row['recibo'] as int,
            fotoIdentificacion: row['fotoIdentificacion'] as String,
            fotoFachada: row['fotoFachada'] as String,
            montoCobradoEnVisita: row['montoCobradoEnVisita'] as double,
            fechaSiguientePago: row['fechaSiguientePago'] as String,
            nota: row['nota'] as String,
            visitado: row['visitado'] as int,
            montoTotal: row['montoTotal'] as double,
            montoAbonoAcordado: row['montoAbonoAcordado'] as double,
            fechaPrimerPago: row['fechaPrimerPago'] as String,
            fechaTerminacionCredito: row['fechaTerminacionCredito'] as String,
            saldo: row['saldo'] as double,
            porcentajePagado: row['porcentajePagado'] as String,
            pagosAtrasados: row['pagosAtrasados'] as int,
            saldoAtrasado: row['saldoAtrasado'] as int,
            productos: row['productos'] as String,
            prontoPago: row['prontoPago'] as String,
            relacionPagos: row['relacionPagos'] as String,
          ),
        )
        .toList();
    return cobros;
  }

  Future<int> apuntarCobro(Cobro cobro) async {
    final db = await _getDatabase();
    return await db.rawUpdate(
        'UPDATE cobros SET '
        'montoCobradoEnVisita = ?, '
        'fechaSiguientePago = ?,'
        'nota = ?,'
        'recibo = ?,'
        'orden = ?,'
        'visitado = ? WHERE idCuenta = ${cobro.idCuenta}',
        [
          cobro.montoCobradoEnVisita,
          cobro.fechaSiguientePago,
          cobro.nota,
          cobro.recibo,
          cobro.orden,
          cobro.visitado
        ]);
  }

  /*Future<void> addCobro(idCuenta, cobro) async {
    final db = await _getDatabase();
    final resultado = await db.update(
      'cobros',
      {
        'idCuenta': cobro.idCuenta,
        'idCobrador': cobro.idCobrador,
        'idContrato': cobro.idContrato,
        'idCliente': cobro.idCliente,
        'claveCuenta': cobro.claveCuenta,
        'idTipoPago': cobro.idTipoPago,
        'diaPago': cobro.diaPago,
        'diaPagoA': cobro.diaPagoA,
        'diaPagoB': cobro.diaPagoB,
        'montoTotal': cobro.montoTotal,
        'abono': cobro.abono,
        'totalPagado': cobro.totalPagado,
        'saldo': cobro.saldo,
        'idPersona': cobro.idPersona,
        'nombreCliente': cobro.nombreCliente,
        'idDireccion': cobro.idDireccion,
        'calle': cobro.calle,
        'noExt': cobro.noExt,
        'noInt': cobro.noInt,
        'colonia': cobro.colonia,
        'delegacion': cobro.delegacion,
        'municipio': cobro.municipio,
        'referencias': cobro.referencias,
        'cp': cobro.cp,
        'orden': cobro.orden,
        'cobrado': cobro.cobrado,
        'subido': cobro.subido,
        'fotoIdentificacion': cobro.fotoIdentificacion,
        'fotoFachada': cobro.fotoFachada,
        'montoPagado': cobro.montoPagado,
        'fechaSiguientePago': cobro.fechaSiguientePago,
        'nota': cobro.nota,
        'visitado': 1
      },
      where: "idCuenta = ?",
      whereArgs: [cobro.idCuenta],
    );
    if (resultado == true) {
      final jom = 'yes';
    }
  }*/

  // pagos
  Future<List<Cobro>> leerPagos() async {
    //var pagos = null;
    final db = await _getDatabase();
    final data = await db.query('cobros', where: 'visitado=1');
    // if (data != null) {
    final pagos = data
        .map(
          (row) => Cobro(
              idCuenta: row['idCuenta'] as int,
              idCobrador: row['idCobrador'] as int,
              idContrato: row['idContrato'] as int,
              idCliente: row['idCliente'] as int,
              claveCuenta: row['claveCuenta'] as String,
              fechaVenta: row['fechaVenta'] as String,
              idTipoPago: row['idTipoPago'] as int,
              diaPago: row['diaPago'] as String,
              diaPagoA: row['diaPagoA'] as int,
              diaPagoB: row['diaPagoB'] as int,
              fechaProximoPago: row['fechaProximoPago'] as String,
              idPersona: row['idPersona'] as int,
              nombreCliente: row['nombreCliente'] as String,
              idDireccion: row['idDireccion'] as int,
              calle: row['calle'] as String,
              noExt: row['noExt'] as String,
              noInt: row['noInt'] as String,
              colonia: row['colonia'] as String,
              delegacion: row['delegacion'] as String,
              municipio: row['municipio'] as String,
              referencias: row['referencias'] as String,
              cp: row['cp'] as String,
              orden: row['orden'] as int,
              cobrado: row['cobrado'] as int,
              subido: row['subido'] as int,
              recibo: row['recibo'] as int,
              fotoIdentificacion: row['fotoIdentificacion'] as String,
              fotoFachada: row['fotoFachada'] as String,
              montoCobradoEnVisita: row['montoCobradoEnVisita'] as double,
              fechaSiguientePago: row['fechaSiguientePago'] as String,
              nota: row['nota'] as String,
              visitado: row['visitado'] as int,
              montoTotal: row['montoTotal'] as double,
              montoAbonoAcordado: row['montoAbonoAcordado'] as double,
              fechaPrimerPago: row['fechaPrimerPago'] as String,
              fechaTerminacionCredito: row['fechaTerminacionCredito'] as String,
              saldo: row['saldo'] as double,
              porcentajePagado: row['porcentajePagado'] as String,
              pagosAtrasados: row['pagosAtrasados'] as int,
              saldoAtrasado: row['saldoAtrasado'] as int,
              productos: row['productos'] as String,
              relacionPagos: row['relacionPagos'] as String,
              prontoPago: row['prontoPago'] as String),
        )
        .toList();
    // }
    return pagos;
  }

  void borrarTransferidos(pagosTransferidos) async {
    final db = await _getDatabase();
    for (int index = 0; index < pagosTransferidos.length; index++) {
      var pago = pagosTransferidos[index];
      if (pago['grabado'] == true) {
        final cuenta = pago['idCuenta'];
        db.delete('cobros', where: 'idCuenta = ?', whereArgs: [cuenta]);
      }
    }
  }

  Future<List<Cobro>> buscarCobros(nombre, direccion, cuenta) async {
    String? textoWhere;
    String conector = ' or ';
    //if (nombre != "" || cuenta != ""  || direccion != ""){
    final arreglo = [];
    if (nombre != "") {
      textoWhere = ' nombreCliente like ? ';
      arreglo.add("%${nombre}%");
    }
    if (cuenta != "") {
      if (textoWhere != null && textoWhere!.isNotEmpty) {
        textoWhere = textoWhere! + conector + ' claveCuenta like ? ';
      } else {
        textoWhere = ' claveCuenta like ? ';
      }
      arreglo.add("%${cuenta}%");
    }
    if (direccion != "") {
      if (textoWhere != null && textoWhere!.isNotEmpty) {
        textoWhere = textoWhere! +
            conector +
            ' calle like ? or noExt like ? or noInt like ? or colonia like ? or delegacion like ? or municipio like ? or referencias like ? or cp like ? ';
      } else {
        textoWhere =
            ' calle like ? or noExt like ? or noInt like ? or colonia like ? or delegacion like ? or municipio like ? or referencias like ? or cp like ? ';
      }
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
      arreglo.add("%${direccion}%");
    }
    final db = await _getDatabase();
    final data =
        await db.query('cobros', where: textoWhere, whereArgs: arreglo);
    // if (data.isEmpty) {
    //   cobros = Future(() => []);
    // } else {
    final cobros = data
        .map(
          (row) => Cobro(
            idCuenta: row['idCuenta'] as int,
            idCobrador: row['idCobrador'] as int,
            idContrato: row['idContrato'] as int,
            idCliente: row['idCliente'] as int,
            claveCuenta: row['claveCuenta'] as String,
            fechaVenta: row['fechaVenta'] as String,
            idTipoPago: row['idTipoPago'] as int,
            diaPago: row['diaPago'] as String,
            diaPagoA: row['diaPagoA'] as int,
            diaPagoB: row['diaPagoB'] as int,
            fechaProximoPago: row['fechaProximoPago'] as String,
            idPersona: row['idPersona'] as int,
            nombreCliente: row['nombreCliente'] as String,
            idDireccion: row['idDireccion'] as int,
            calle: row['calle'] as String,
            noExt: row['noExt'] as String,
            noInt: row['noInt'] as String,
            colonia: row['colonia'] as String,
            delegacion: row['delegacion'] as String,
            municipio: row['municipio'] as String,
            referencias: row['referencias'] as String,
            cp: row['cp'] as String,
            orden: row['orden'] as int,
            cobrado: row['cobrado'] as int,
            subido: row['subido'] as int,
            recibo: row['recibo'] as int,
            fotoIdentificacion: row['fotoIdentificacion'] as String,
            fotoFachada: row['fotoFachada'] as String,
            montoCobradoEnVisita: row['montoCobradoEnVisita'] as double,
            fechaSiguientePago: row['fechaSiguientePago'] as String,
            nota: row['nota'] as String,
            visitado: row['visitado'] as int,
            montoTotal: row['montoTotal'] as double,
            montoAbonoAcordado: row['montoAbonoAcordado'] as double,
            fechaPrimerPago: row['fechaPrimerPago'] as String,
            fechaTerminacionCredito: row['fechaTerminacionCredito'] as String,
            saldo: row['saldo'] as double,
            porcentajePagado: row['porcentajePagado'] as String,
            pagosAtrasados: row['pagosAtrasados'] as int,
            saldoAtrasado: row['saldoAtrasado'] as int,
            productos: row['productos'] as String,
            prontoPago: row['prontoPago'] as String,
            relacionPagos: row['relacionPagos'] as String,
          ),
        )
        .toList();
    return cobros;
  }

  // reordenar
  Future<int> reordenar(renglon) async {
    final db = await _getDatabase();
    //for (final renglon in listaNuevoOrden) {
    print(renglon.cliente);
    print(renglon.idCuenta);
    print('de:');
    print(renglon.ordenInicial);
    print('a:');
    print(renglon.ordenFinal);

    final resultado = await db.rawUpdate(
        'UPDATE cobros SET '
        'orden = ? WHERE idCuenta = ${renglon.idCuenta}',
        [renglon.ordenFinal]);
    return (resultado);
  }
}
