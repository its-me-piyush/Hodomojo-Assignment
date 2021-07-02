import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/api_data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The following variable is used for giving circular loding indicator
  // while the app fetches the data from the api.
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<ApiDataProvider>(context, listen: false)
        .fetchData()
        .then((value) {
      setState(() {
        _isInit = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    // or everytime this "HomePage" class is called, for instance as done
    // on the main.dart file.

    // Getting data from the provider folder
    final data = Provider.of<ApiDataProvider>(context).items;
    // Defigning scrollController for displaying scrollbar.
    final scrollController = ScrollController(initialScrollOffset: 0);
    return Scaffold(
      // Simple app bar which display title only and the background
      // color is controlled by the theme.
      appBar: AppBar(
        title: Text('Flutter Assignment'),
        centerTitle: true,
      ),
      body: _isInit
          ? Center(
              // This will put child in the center of the screen.
              child: CircularProgressIndicator(),
            )
          : data.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scrollbar(
                  // Defining the scrollbar properties.
                  radius: Radius.circular(50),
                  thickness: 10,
                  isAlwaysShown: true,
                  controller: scrollController,
                  child: ListView.builder(
                    // This widget displays the design as excepted for the
                    // assignment.
                    itemCount: data.length - 1,
                    itemBuilder: (context, index) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // The following container contains the header information,
                          // and the rest of the text part and image part for the assignment.
                          Container(
                            alignment: Alignment.bottomLeft,
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                onError: (exception, stackTrace) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  data[0].headerImage,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                data[0].headerTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            data[index].textTitle,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.125,
                            child: SizedBox(
                              child: Text(
                                data[index].textDescription,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  data[index].imageUrl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
