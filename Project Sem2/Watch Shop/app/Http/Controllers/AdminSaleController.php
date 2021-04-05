<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminSaleController extends Controller
{


    // public function __construct()
    // {
    // }

    public function index()
    {
        return view('admin.sale.index', compact('sales'));
    }

    // public function edit($id)
    // {
    //     $order = $this->order->find($id);
    //     return \view('admin.order.edit', \compact('order'));
    // }

    // public function update(Request $request, $id)
    // {
    //     $this->order->find($id)->update([
    //         'customer_name' => $request->customer_name,
    //         'customer_email' => $request->customer_email,
    //         'customer_phone' => $request->customer_phone,
    //         'customer_address' => $request->customer_address,
    //         'customer_city' => $request->customer_city,
    //         'customer_distrcit' => $request->customer_distrcit,
    //         'status' => $request->status
    //     ]);
    //     return redirect()->route('orders.index');
    // }

    // public function orderItemIndex($id)
    // {
    //     $orderItems = $this->orderItem->where('order_id', $id)->get();
    //     return \view('admin.order.indexOrderItem', compact('orderItems'));
    // }

    // public function editOrderItem($id)
    // {
    //     $orderItems = $this->orderItem->find($id);
    //     return \view('admin.order.editOrderItem', \compact('orderItems'));
    // }

    // public function updateOrderItem(Request $request, $id)
    // {
    //     $this->orderItem->find($id)->update([
    //         'quantity' => $request->quantity
    //     ]);
    //     return redirect()->route('orders.index');
    // }
}