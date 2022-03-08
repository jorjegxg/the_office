import 'package:flutter/material.dart';

class ViewRemoteRequest extends StatelessWidget {
  const ViewRemoteRequest({required this.nume, required this.imagine});
  final String nume, imagine;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text("popescu gheorghe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    imagine,
                  ),
                  radius: 30,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  nume,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Remote work procentage: 200%",
                style: TextStyle(fontSize: 15),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: const Text(
                      "Remote work procentage: 200%Expanded(child: Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),child: ListView.builder(: user_list.length,itemBuilder: (BuildContext context, int index) {return user_list[index];},),",
                      style: TextStyle(fontSize: 15),
                      textHeightBehavior: TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                //refuse button
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Refuse",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      ///TODO refuse
                    },
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                //accept button
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
