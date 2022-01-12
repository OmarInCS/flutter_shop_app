
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  const EditProductScreen({Key? key}) : super(key: key);


  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product.empty();
  var _isInit = true;

  void _saveForm() {
    bool isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    if (_editedProduct.id.isEmpty) {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    else {
      Provider.of<Products>(context, listen: false).didUpdateProduct();
    }
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        setState(() {

        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _editedProduct.title,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct.title = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter a title";
                  },
                ),
                TextFormField(
                  initialValue: _editedProduct.price.toString(),
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct.price = double.parse(newValue!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter a price";
                    if (double.tryParse(value) == null) return "Enter a valid price";
                    if (double.parse(value) <= 0) return "Enter a number greater than zero";
                  },
                ),
                TextFormField(
                  initialValue: _editedProduct.description,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (newValue) {
                    _editedProduct.description = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter a description";
                    if (value.length < 10) return "too short description";
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: _imageUrlController.text.isEmpty
                            ? Text("Enter a URL")
                            : FittedBox(
                        child: Image.network(_imageUrlController.text),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Image URL",
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (value) => _saveForm(),
                        onSaved: (newValue) {
                          _editedProduct.imageUrl = newValue!;
                        },
                        onEditingComplete: () {
                          setState(() {

                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Enter a Image URL";
                          if (!value.toLowerCase().startsWith("http")) return "Enter a valid URL";
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

