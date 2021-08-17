import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class SendOrderBloc extends Bloc<SendOrderEvent, SendOrderState> {
  final Repository repository;

  SendOrderBloc({required this.repository}) : super(InitialSendOrder());

  @override
  Stream<SendOrderState> mapEventToState(SendOrderEvent event) async* {
    if (event is LoadSendOrder) {
      yield* loadSendOrderToState(event.email, event.domainName);
    }
  }

  Stream<SendOrderState> loadSendOrderToState(String email, String domainName,) async* {
    try {
      yield LoadingSendOrder();

      String jsonString =  jsonEncode({
          "order": {
            "domains": [
              {
                "name": "vadym.crypto",
                "owner": {
                  "address": "0x033dc48B5dB4CA62861643e9D2C411D9eb6D1975"
                },
                "resolution": {
                  "crypto": {
                    "ZIL": {
                      "address": "0xe568f2BB42A77F6508911290d581B3Af107b1e4B"
                    },
                    "ETH": {
                      "address": "0x20B4564DEB7AF89ece828d843D0Ac2c16934a23e"
                    }
                  }
                }
              }
            ],
            "payment": {
              "type": "coinbase"
            }
          }
      });

      var order = await repository.sendOrderNumber("unstoppabledomains", "nischal@unstoppabledomains.com", jsonStringParse(domainName));

      if (order.toString().isEmpty) {
        yield NoDataSendOrder("Data Not Found");
      } else {
        yield HasDataSendOrder(order);
      }
    } on DioError {}
  }

  String jsonStringParse(String name){
    String jsonString =  jsonEncode({
      "order": {
        "domains": [
          {
            "name": "$name",
            "owner": {
              "address": "0x033dc48B5dB4CA62861643e9D2C411D9eb6D1975"
            },
            "resolution": {
              "crypto": {
                "ZIL": {
                  "address": "0xe568f2BB42A77F6508911290d581B3Af107b1e4B"
                },
                "ETH": {
                  "address": "0x20B4564DEB7AF89ece828d843D0Ac2c16934a23e"
                }
              }
            }
          }
        ],
        "payment": {
          "type": "coinbase"
        }
      }
    });

    return jsonString;
  }
}
