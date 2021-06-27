import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:_date_/Payments.dart';
import 'package:_date_/bloc/message/message_bloc.dart';
import 'package:_date_/bloc/message/message_event.dart';
import 'package:_date_/bloc/message/message_state.dart';
import 'package:_date_/repositories/messageRepository.dart';
import 'package:_date_/ui/pages/userProfile.dart';
import 'package:_date_/ui/widgets/chat.dart';

class Messages extends StatefulWidget {
  final String userId;

  Messages({this.userId});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  MessageRepository _messagesRepository = MessageRepository();
  MessageBloc _messageBloc;
  DateTime expiry = DateTime.now().subtract(Duration(days: 1));
  Razorpay _razorpay;

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_wlttW6y3ig7DQH',
      'amount': 100,
      'name': 'Matchmaker',
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    SnackBar(content: Text('Succesful ' + response.paymentId));
    Payments(userId: widget.userId)
        .updatePaymentInfo(DateTime.now().add(Duration(days: 1)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SnackBar(
        content: Text(
            'ERROR ! ' + response.code.toString() + " - " + response.message));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SnackBar(content: Text('External Wallet ' + response.walletName));
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _messageBloc = MessageBloc(messageRepository: _messagesRepository);
    checkExpiry();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return expiry.isAfter(DateTime.now())
        ? BlocBuilder<MessageBloc, MessageState>(
            bloc: _messageBloc,
            builder: (BuildContext context, MessageState state) {
              if (state is MessageInitialState) {
                _messageBloc.add(ChatStreamEvent(currentUserId: widget.userId));
              }
              if (state is ChatLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ChatLoadedState) {
                Stream<QuerySnapshot> chatStream = state.chatStream;

                return StreamBuilder<QuerySnapshot>(
                  stream: chatStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("No data");
                    }

                    if (snapshot.data.docs.isNotEmpty) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatWidget(
                              creationTime:
                                  snapshot.data.docs[index]['timestamp'],
                              userId: widget.userId,
                              selectedUserId: snapshot.data.docs[index].id,
                            );
                          },
                        );
                      }
                    } else
                      return Center(
                        child: Text(
                          " You don't have any conversations",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      );
                  },
                );
              }
              return Container();
            },
          )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Become a premeium member now to avail messaging features',
                ),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50),
                  height: 50.0,
                  child: BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 4.0,
                    onPressed: () {},
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      shadowColor: Colors.red,
                      color: Colors.red[400],
                      elevation: 10.0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          openCheckout();
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  FlutterIcons.unlock_ant,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Get Premium Access',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  checkExpiry() async {
    Timestamp expiryDate;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          expiryDate = documentSnapshot['expiryDate'];
          expiry = expiryDate.toDate();
        });
      } else {}
    });
  }
}
