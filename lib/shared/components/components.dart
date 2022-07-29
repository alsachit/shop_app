import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';
import '../styles/colors.dart';


void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
  );

  void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
        (route) => false,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  VoidCallback? function,
  String? label,
  bool isUpper = true,
}) => Container(
  width: width,
  color: background,
  padding: const EdgeInsets.symmetric(vertical: 7),
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpper ? label!.toUpperCase() : label!,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),
    ),
  ),
);

Widget defaultTextFormField({
  required TextEditingController? controller,
  required String? Function(String?)? validate,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  required TextInputType? keyboardType,
  required String? label,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  VoidCallback? suffixPressed
}) => TextFormField(
  validator: validate,
  obscureText: isPassword,
  controller: controller,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefixIcon,
    ),
    suffixIcon: suffixIcon != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffixIcon),
    ) : null,
    border: const OutlineInputBorder(),
  ),
  onTap: onTap ,
);

Widget buildListProduct( model, context, {bool isOldPrice = true}) => Container(
  padding: const EdgeInsets.all(20),
  height: 125,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            //fit: BoxFit.cover,
            width: 120,
            height: 120,
          ),
          if(model.discount != 0 && isOldPrice)
            Container(
              padding: const EdgeInsets.all(3),
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
      Expanded(
        child: Column(
          children: [
            const SizedBox(width: 15,),
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${model.price}',
                  style: TextStyle(
                      color: defaultColor
                  ),
                ),
                const SizedBox(width: 5,),
                if (model.discount != 0 && isOldPrice)
                  Text(
                    '${model.oldPrice}',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                const Spacer(),
                IconButton(
                  onPressed: (){
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor: (ShopCubit.get(context).favorites[model.id])! ? defaultColor : Colors.grey ,
                    radius: 15,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    ],
  ),
);
