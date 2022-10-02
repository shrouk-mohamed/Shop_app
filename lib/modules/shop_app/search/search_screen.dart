import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/shop_app/search/cubit/cubit.dart';
import 'package:untitled1/modules/shop_app/search/cubit/states.dart';
import '../../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      type:TextInputType.text,
                      validate: (value){
                        if(value !=null|| value!.isEmpty){
                          return 'enter text to search';
                        }
                        return null;
                      },
                    onSubmit: (text){
                        SearchCubit.get(context).search(text);
                    },
                      label: 'Search',
                      prefix: Icons.search,

                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if(state is SearchLoadingState)
                  const LinearProgressIndicator(),
                  const SizedBox(height: 15),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => bulidProductsItem(
                          SearchCubit.get(context).searchModel!.data!.data![index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
