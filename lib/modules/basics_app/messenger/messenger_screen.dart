import 'package:flutter/material.dart';

class Messenger_Screen extends StatelessWidget {
  const Messenger_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                  'https://sa.lovepik.com/image-501415803/american-coffee.html'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                child: Icon(
                  Icons.camera_alt,
                ),
              )),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                child: Icon(
                  Icons.edit,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.search,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'search',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildstoryitm(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: 5,
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildchatitem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildchatitem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: const [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://sa.lovepik.com/image-501415803/american-coffee.html'),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 5.0,
                ),
                child: CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bahaa Mohamed',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'hi shosho  hi shoshohi shoshohi shoshohi shosho ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Text(
                      '10.35',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
  Widget buildstoryitm() => Container(
        width: 5.0,
        height: 5.0,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      );
}
