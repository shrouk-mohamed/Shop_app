import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/shared/cubit/cubit.dart';

import '../../layout/shop_app/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function()? function,
  required String text,
  double radius = 3.0,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40.0,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextBotton({
  required Function()? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  final VoidCallback? onPressed,
  ValueChanged? onChange,
  ValueChanged? onSubmit,
  Function()? onTap,
  bool isPassword = false,
  String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['id']);
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        //NavigateTo(
        //context,
        //WebViewScreen(url: article['url']),
        //);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, {isSreach = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSreach
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//

Widget bulidProductsItem(model, context, {bool isOldPrice = true}) => Container(
      margin: const EdgeInsets.all(20),
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              productImage(
                imageUrl: "${model.image}",
              ),
              /*Image(
                image: NetworkImage(
                  "${model.image}",
                ),
                width: 120,
                height: 120,
              ),*/
              if (model.discount != 0 && isOldPrice)
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.red,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        "${model.oldPrice}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          height: 1.3,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          //  ShopCubit.get(context).changeCartData(productId: model.id!);
                          print(model.id);
                        },
                        icon: const CircleAvatar(
                          radius: 15,
                          // backgroundColor: ShopCubit.get(context).cartProducts[model.id]!? Colors.red: Colors.grey,
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavoritesData(model.id!);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favorites![model.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

productImage({
  required String imageUrl,
  double height = 120,
  double width = 120,
}) =>
    CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
