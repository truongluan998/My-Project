<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Brand;
use App\Models\Categories;
use App\Models\ProductImage;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function ProductDetail($product_id)
    {
        $pro = Product::where('id', $product_id)->with('category')->with('brand')->get();
        $pro1 = Product::find($product_id);
        //dd($pro->id);
        $image = ProductImage::where('product_id',$product_id)->get();
        $test = Product::where('category_id',$pro1->category_id)->limit(3)->get();
        //dd($relate);
        return view('pages.productdetails', compact('pro','image','test'));
    }

    function search(Request $req)
    {
        $data = Product::where('name','like','%'.$req ->input('query').'%')->get();
        return view('pages.search',['products'=>$data]);
    }
}