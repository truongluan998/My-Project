<?php

namespace App\Http\Controllers;
use App\Models\Product;
use App\Models\Brand;
use App\Models\OrderItems;
use Illuminate\Http\Request;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Facades\Redirect;
use App\Models\Orders;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use Exception;
session_start();
class CartController extends Controller
{
    public function showCart(){
        return view('pages.showcart');
    }
    public function addToCart($id){
        $product = Product::find($id);
        $brand_id = $product->brand_id;
        $brand = Brand::find($brand_id);
        $data['id'] = $product->id;
        $data['name'] = $product->name;
        $data['qty'] = 1;
        $data['price'] = $product->price;
        $data['weight'] = 0;
        $data['options']['image'] = $product->feature_image;
        $data['options']['brand'] = $brand->name;
        $data['options']['stock'] = $product->quantity;
        Session::put($data);
        Cart::add($data);
        echo '<pre>';
        print_r(Cart::content());
    }

    public function deleteItem($rowId){
        Cart::remove($rowId);
        Session::flash('delete','Your item has been successfully deleted');
        return Redirect::to('/show-cart');
    }
    //Checkout
    public function checkout(){
        foreach(Cart::content() as $data){
            if(intval($data->qty) > intval($data->options->stock)){
                Session::flash('data','Your quantity is invalid. We only have '.$data->options->stock.' item of ' .$data->name. ' left in stock!');
                return Redirect::to('/show-cart');
            }
        }
        return view('pages.checkout');
    }

    public function updateQuantity(Request $request)
    {
        $id = $request->pid;
        $quantity = $request->input('product-quantity');
        //dd($id,$quantity);
        try{
        Cart::update($id,$quantity);
        Session::flash('noti','Quantity successfully updated!');
        }catch(Exception $e){
            return view('pages.showcart');
        }
        return Redirect::to('/show-cart#form');
        // return view('view-cart');
    }

    public function updateQuantityProduct(Request $request)
    {
        try{
            $id = $request->id;
        $dataP = $request->all();
        $product = Product::find($id);
        $brand_id = $product->brand_id;
        $brand = Brand::find($brand_id);
        $data['id'] = $product->id;
        $data['name'] = $product->name;
        $data['qty'] = $dataP['qty'];
        $data['price'] = $product->price;
        $data['weight'] = 0;
        $data['options']['image'] = $product->feature_image;
        $data['options']['brand'] = $brand->name;
        $data['options']['stock'] = $product->quantity;
        Session::put($data);
        Cart::add($data);
        }catch(Exception $e){
            Session::flash('error','Invalid quantity !');
            return back();
        }
        // if($data['qty']>$data['options']['stock']){
        //     Session::flash('data','Invalid quantity');
        // }
        //dd($data);
        //Cart::update($id,$quantity);
        return back()->with('success');
        // return view('view-cart');
    }
    public function saveShipDetail(Request $request){
        $data = $request->all();
        $order = new Orders();
        $total = Cart::total();
        $order->customer_name = $data['name'];
        $order->customer_email = $data['email'];
        $order->customer_address = $data['address'];
        $order->customer_phone = $data['phone'];
        $order->customer_city = $data['city'];
        $order->customer_district = $data['district'];
        $order->total = (double)$total;
        $order->save();
        $c_name = $order->customer_name;
        $c_email = $order->customer_email;
        foreach(Cart::content() as $item){
            $orderItem = new OrderItems();
            $orderItem->order_id = $order->id;
            $orderItem->product_id = $item->id;
            $orderItem->quantity = $item->qty;
            $orderItem->save();
            $product = Product::find($item->id);
            $product->quantity = $product->quantity - intval($item->qty);
            $product->sold_quantity = $product->sold_quantity + intval($item->qty);
            //dd($product->sold_quantity);
            $product->save();
        }
        //dd($orderItem);
        Session::put('order',$order);
        Cart::destroy();
        Mail::send('email.order',[
            'name' => $c_name,
            'item' => OrderItems::where('order_id',$order->id)->with('product')->get(),
            'order' => $order,

        ],function($mail) use($c_email, $c_name){
            $mail->to($c_email,$c_name);
            $mail->from('watchshopgr3@gmail.com');
            $mail->subject('Confirm your order at Watchshop');
        });
        return Redirect::to('/success');
    }

    public function success(){
        return view('pages.success');
    }
}
