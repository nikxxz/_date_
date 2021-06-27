import 'package:flutter/material.dart';
import 'package:date_/models/user.dart';

class DetailPage extends StatelessWidget {
  final User user;

  const DetailPage({this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 300),
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          user.gender +
                              ', ' +
                              (DateTime.now().year - user.age.toDate().year)
                                  .toString(),
                          style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        SizedBox(height: 32),
                        Text(
                          'desc',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 32),
                        Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 25,
                        color: const Color(0xff47455f),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(left: 32.0),
                    child: ListView.builder(
                        // itemCount: user.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  user.photo,
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.05),
                child: Hero(
                  tag: user.uid,
                  child: Card(
                    elevation: size.width * 0.15,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.black87, width: 5)),
                    child: CircleAvatar(
                        radius: size.width * 0.3,
                        backgroundImage: NetworkImage(
                          user.photo,
                        )),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   child: Text(
            //     user.name,
            //     style: TextStyle(
            //       fontSize: 247,
            //       color: Colors.black87.withOpacity(0.2),
            //       fontWeight: FontWeight.w900,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
