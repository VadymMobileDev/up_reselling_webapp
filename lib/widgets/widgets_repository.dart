import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/games/bloc.dart';
import 'package:up_reselling_webapp/repository/games_repository.dart';

class HelpCenterWidget extends StatelessWidget {
  const HelpCenterWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: "Have any issues? ", style: TextStyle(color: AppColor.textGreyDark)),
            TextSpan(
                text: "Help Center",
                style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
          ],
        ),
      );
}

class BeckToHomeOpenWidget extends StatelessWidget {
  const BeckToHomeOpenWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image(
                image: AssetImage("assets/icon_light.png"),
                height: Dimens.margeButtonsEdge
            ),
          ),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon:
                Icon(Icons.arrow_back_ios, color: AppColor.black, size: Dimens.paddingMedium),
                onPressed: () async {
                  var games = await GamesRepository().getDomainNameList();

                  print("------result: - " + games.crypto.length.toString());
                },
                label: Text(
                  "Beck To Home",
                  style: TextStyle(color: AppColor.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.borderButtonRadius),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}


class BeckToHomeCloseWidget extends StatelessWidget {
  const BeckToHomeCloseWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image(
              image: AssetImage("assets/icon_light.png"),
              height: Dimens.margeButtonsEdge
          ),
        ),
      ),
      Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              icon:
              Icon(Icons.arrow_back_ios, color: AppColor.black, size: Dimens.paddingMedium),
              onPressed: () {},
              label: Text(
                "Beck",
                style: TextStyle(color: AppColor.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColor.primaryGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.borderButtonRadius),
                ),
              ),
            )),
      ),
    ],
  );
}

class CardUnstoppableWidget extends StatelessWidget {
  const CardUnstoppableWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightBlue,
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage("assets/unstoppable_domains_logo.png"),
                  height: Dimens.iconHeight,
                ),
              ),
              SizedBox(height: Dimens.paddingSemi),
              Text('Replace cryptocurrency addresses with\na human readable name',
                  style: TextStyle(fontSize: 14.0, color: AppColor.textGreyDark)),
            ],
          ),
        ),
      );
}

class TitleExtensionsWidget extends StatelessWidget {
  const TitleExtensionsWidget({Key? key, required this.domainName}) : super(key: key);
  final String domainName;

  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
          child: Text("Extensions for \"" + "$domainName" + "\"",
              style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold))));
}

class CardPurchaseWidget extends StatelessWidget {
  const CardPurchaseWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightGrey,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimens.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Purchase your\nBlockchain Domain",
                  style: TextStyle(
                      fontSize: 22.0, color: AppColor.black, fontWeight: FontWeight.bold)),
              SizedBox(height: Dimens.paddingSemi),
              Text("Please enter at least 6 Characters",
                  style: TextStyle(color: AppColor.textGrey)),
            ],
          ),
        ),
      );
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<GamesBloc>().add(LoadGames());
    return Container(
        child: BlocBuilder<GamesBloc, GamesState>(builder: (_, state) {
          if (state is GamesHasData) {
            print("------resultGamesHasData : ${state.result.crypto}");

            return Text("GamesHasData  ${state.result}");
          } else if (state is GamesLoading) {
            print("------result GamesLoading : ${state}");

            return Text("GamesLoading  ${state}");
          } else if (state is GamesNoData) {
            print("------result GamesNoData : ${state}");

            return Container(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is GamesNoInternetConnection) {
            return Text('No Internet Connection');
          }else if (state is GamesError) {
            return Text('GamesError');
          }
          else {
            return Text("else else else ${state.toString()}");
          }
        }));
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
