import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/history_response.dart';
import 'package:smartville/provider/history_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/history_widget.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = 'history-page';

  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryProvider historyProvider = Provider.of<HistoryProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat',
          style: whiteText.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF70C7BA),
        elevation: 0.0,
        leading: const BackButton(color: Colors.white),
      ),
      body: FutureBuilder(
        future: historyProvider.getListHistory(userProvider.token!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            ListHistory listHistory = snapshot.data as ListHistory;
            if (listHistory.error) {
              return Center(
                child: Text("Error : ${listHistory.message}"),
              );
            } else {
              List<History> history = listHistory.data;
              if (history.isEmpty) {
                return const Center(
                  child: Text("Tidak ada riwayat"),
                );
              }
              return ListView.builder(
                itemCount: (history.length + 2),
                itemBuilder: (_, index) {
                  if (index == 0 || index == history.length + 1) {
                    return const SizedBox(
                      height: 15,
                    );
                  } else {
                    return HistoryWidget(
                      title: history[index - 1].deskripsi,
                      date: history[index - 1].updatedAt,
                      status: history[index - 1].status,
                    );
                  }
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
