<?php

namespace App\Http\Controllers;

use App\Models\Orders;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OrdersController extends Controller
{
    public function orders()
    {
        $orders = Orders::with('orders_items')->where('user_id', Auth::user()->id)->orderBy('id', 'Desc')->get()->toArray();
        // dd($orders);
        // die;
        return view('pages.ordershistory')->with(compact('orders'));
    }


    public function orderDetails($id)
    {
        $orderDetails = Orders::with('orders_items')->where('id',$id)->first()->toArray();
        // dd($orderDetails);die;
        return view('pages.orderdetails')->with(compact('orderDetails'));
    }
}