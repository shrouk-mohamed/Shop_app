
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/models/shop_app/categories_model.dart';
import 'package:untitled1/models/shop_app/home_model.dart';
import 'package:untitled1/models/shop_app/products_model.dart';
import 'package:untitled1/shared/components/components.dart';

import '../../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){
          if(state is ShopSuccessChangeFavoritesState){
            if(!state.changeFavoritsModel!.status!){
              showToast(text: state.changeFavoritsModel!.message!, state: ToastStates.ERROR);
            }
          }
        },
    builder: (context,state){
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context)=> productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context),
              fallback: (context)=> Center(child: CircularProgressIndicator()),
          );
    },
    );
  }

  Widget productsBuilder(HomeModel model ,CategoriesModel categoriesModel, context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.banners.map((e) => Image(image: NetworkImage('${e.image}'),
          width: double.infinity,
            fit: BoxFit.cover,

          ),).toList() ,
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,


          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                    physics:  BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index)=>buildCategoriesItem(categoriesModel.data.data![index]) ,
                    separatorBuilder: (context ,index )=> SizedBox(width: 10.0,),
                    itemCount: categoriesModel.data.data!.length),
              ),
              SizedBox(
                height: 20.0,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.72,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
          children: List.generate(model.data.products.length,
                (index) => buildGridProduct(model.data.products[index],context),
          ),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoriesItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image:NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100.0,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,

            ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0,),
              child: const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 14.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount!=0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(

                    onPressed: (){
                      ShopCubit.get(context).changeFavoritesData(model.id);
                       print(model.id);

                    },
                    icon:  CircleAvatar(
                      backgroundColor:ShopCubit.get(context).favorites?[model.id]?? true ? defaultColor : Colors.grey,
                      radius: 15.0,
                      child: const Icon(
                          Icons.favorite,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
