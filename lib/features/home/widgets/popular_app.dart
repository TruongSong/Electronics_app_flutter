import 'package:electronics_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class PopularApps extends StatefulWidget {
  const PopularApps({super.key});

  @override
  State<PopularApps> createState() => _PopularAppsState();
}

class _PopularAppsState extends State<PopularApps> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular apps',
                  style: TextStyle(
                    color: Colors.cyan[800],
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 0,
                ),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            GlobalVariables.popularApps[index]['image']!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 5,
                            top: 10,
                            right: 15,
                          ),
                          child: Text(
                            GlobalVariables.popularApps[index]['title']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
