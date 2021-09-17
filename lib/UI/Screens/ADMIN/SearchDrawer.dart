import 'package:camp_web/Provider/AdminInfo.dart';
import 'package:camp_web/model/Publicacion.dart';
import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class SearchDialog extends StatefulWidget {
  final int i;
  const SearchDialog({
    Key key,
    this.i
  }) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  _showDialog() async{
    var screenSize = MediaQuery.of(context).size;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('Selecciona una Publicación'),
          content: new SingleChildScrollView(
              child: new Material(
                child:  Container(
                    width: screenSize.width*0.6,
                    height: screenSize.height*0.8,
                    child: new MyDialogContent(i:this.widget.i)),
              ),
            ),

        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){_showDialog();});
  }
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class TableRow extends DataTableSource {
  List<DataRow> lstRowsData;
  TableRow({this.lstRowsData});

  @override
  DataRow getRow(int index) {
    return lstRowsData[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => lstRowsData.length;

  @override
  int get selectedRowCount => 0;
}


class MyDialogContent extends StatefulWidget {
  final int i;
  MyDialogContent({
    Key key,
    this.i
  }): super(key: key);

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  String TxtSearch;
  var tableRow;

  Widget FormBusqueda(String lbl,double sw,double sh){
    return Container(
      width: sw,
      height: sh,
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: lbl,
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.black26, ),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: Icon(FontAwesomeIcons.search,color: Colors.black26,size: 14,),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.black26,  ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onChanged: (input) {
            setState(() => TxtSearch=input);
            // print(_ADMPageProvider.Gsearch);
          }

      ),
    );
  }


  void _generateRowData(List<Publicacion> lst){
    final _PubsProvider =
    Provider.of<AdmInfoProvider>(context, listen: true);

    List<DataRow>lstDataRows=lst.map((e) {
      return DataRow(
          selected: false,
          onSelectChanged: (bool selected) {
            if (selected) {
              print('row-selected: ${e.titulo}');
              _PubsProvider.updateCards(e,this.widget.i);
            }
          },
          cells: [
            DataCell(Container(
                width: 150,
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.titulo,maxLines: 2,overflow: TextOverflow.ellipsis,)))),
            DataCell(Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(e.Autorfoto)
                        ),
                      ),)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: Container(
                      width: 150,
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            e.Autorname,maxLines: 2,overflow: TextOverflow.ellipsis),
                      )),
                ),
              ],
            )),
            DataCell(Text(e.fecha.substring(0,10))),
          ]);
    }).toList();

    tableRow=new TableRow(lstRowsData: lstDataRows);
  }

  Widget BuscaPublicaciones(){
    return Container(
      width: MediaQuery.of(context).size.width*0.57,
      child: StreamBuilder(
        stream: (TxtSearch != "" && TxtSearch != null)
            ? FirestoreAPI(search: 1,Txtabuscar: TxtSearch,filtro: 'Aprobado').publicacionesData
            : FirestoreAPI(filtro: 'Aprobado').publicacionesData,
        builder: (context, snapshot) {
          List<Publicacion> lstPubs=snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(
                alignment: Alignment.center,
                child: Center(child: CircularProgressIndicator()));
          else
          if(lstPubs.length==0) {
            return Container(
                alignment: Alignment.center,

                child: Text('Busqueda sin resultados'));
          }else {
            _generateRowData(lstPubs);
            return PaginatedDataTable(
              header: Text("Publicaciones"),
              rowsPerPage:  lstPubs.length >6 ? 6 : lstPubs.length,
              columns: [
                DataColumn(label: Text('Titulo')),
                DataColumn(label: Text('Autor')),
                DataColumn(label: Text('Fecha')),
              ],
              source: tableRow,
              showCheckboxColumn: false,

            );
          }
        },
      ),
    );

  }

  @override
  void initState(){
    super.initState();
  }

  _getContent(){
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: new Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: FormBusqueda("Buscar...",screenSize.width*0.3,screenSize.height*0.05),
          ),
          BuscaPublicaciones()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}