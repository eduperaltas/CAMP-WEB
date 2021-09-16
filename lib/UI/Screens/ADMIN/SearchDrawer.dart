import 'package:camp_web/repository/Firestore_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class SearchDrawer extends StatefulWidget {
  const SearchDrawer({
    Key key,
  }) : super(key: key);

  @override
  _SearchDrawerState createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
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
            prefixIcon: Icon(FontAwesomeIcons.search,color: Colors.black26,),
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

  List<int> dataperPage(int i){
    List <int> x=[];
    int dec=i~/10;
    for(int i=0;i<dec;i++){
      x.add(10);
    }
    if(i%10!=0)
      x.add(i%10);
    return x;
  }

  Widget BuscaPublicaciones(){
    List<int> y;
    y=dataperPage(2);
    print('object lista');
    print(y.toString());
    return Container(
      width: MediaQuery.of(context).size.width*0.57,
      // height: MediaQuery.of(context).size.height*0.7,
      child: StreamBuilder(
        stream: (TxtSearch != "" && TxtSearch != null)
            ? FirestoreAPI(search: 1,Txtabuscar: TxtSearch).publicacionesDataRow
            : FirestoreAPI().publicacionesDataRow,
        builder: (context, snapshot) {
          List<DataRow> lstPubs=snapshot.data;
          tableRow=new TableRow(lstRowsData: lstPubs);

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

            return PaginatedDataTable(
                header: Text("Publicaciones"),
                rowsPerPage: lstPubs.length,
                columns: [
                  DataColumn(label: Text('Titulo')),
                  DataColumn(label: Text('Autor')),
                  DataColumn(label: Text('Fecha')),
                ],
                source: tableRow,

            );
          }
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: screenSize.width*0.6,
      child: Drawer(
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: FormBusqueda("Buscar...",screenSize.width*0.3,screenSize.height*0.08),
            ),
            BuscaPublicaciones()
          ],
        )
      ),
    );
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
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => lstRowsData.length;

  @override
  int get selectedRowCount => 0;
}