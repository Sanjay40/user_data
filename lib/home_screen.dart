
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Api_Utils.dart';
import 'http_service.dart';
import 'modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HttpService httpService  = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Text("Random Data",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                  ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                onFieldSubmitted: (val){
                  setState(() {
                    ApiUtils.person = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder(
                  future: httpService.getUserDataResponse(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData)
                    {
                      List<Result> dataList = snapshot.data!;
                      //print("ob ${da}")
                      return ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context,index){
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              leading: CircleAvatar(backgroundImage: NetworkImage("${dataList[index].picture!.large}"),),
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${dataList[index].name!.title} ${dataList[index].name!.first} ${dataList[index].name!.last}", style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),),
                              subtitle: Text("${dataList[index].email}", style: GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone No : ${dataList[index].phone} / ${dataList[index].cell}",style: ApiUtils.txt,),
                                Text("Gender : ${dataList[index].gender}",style: ApiUtils.txt),
                                Text("DOB : ${dataList[index].dob!.date}",style: ApiUtils.txt),
                                Text("Age : ${dataList[index].dob!.age}",style: ApiUtils.txt),
                                Text("Nationality : ${dataList[index].nat}",style: ApiUtils.txt),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Location :: "),
                                    Expanded(child: Text("${dataList[index].location!.street!.number}, ${dataList[index].location!.street!.name}, "
                                        "${dataList[index].location!.city}, ${dataList[index].location!.state}, "
                                        "${dataList[index].location!.country}, ${dataList[index].location!.postcode}, "),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
