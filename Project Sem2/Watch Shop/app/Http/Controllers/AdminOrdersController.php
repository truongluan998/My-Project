<?php

namespace App\Http\Controllers;

use App\Models\OrderItems;
use App\Models\Orders;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class AdminOrdersController extends Controller
{

    private $order;
    private $orderItem;
    private $product;

    public function __construct(Orders $order, OrderItems $orderItem, Product $product, User $user)
    {
        $this->order = $order;
        $this->orderItem = $orderItem;
        $this->product = $product;
        $this->user = $user;
    }

    public function index()
    {
        $orders = $this->order->latest()->paginate(5);
        return \view('admin.order.index', compact('orders'));
    }

    public function edit($id)
    {
        $order = $this->order->find($id);
        return \view('admin.order.edit', \compact('order'));
    }

    public function update(Request $request, $id)
    {
        $this->order->find($id)->update([
            'customer_name' => $request->customer_name,
            'customer_email' => $request->customer_email,
            'customer_phone' => $request->customer_phone,
            'customer_address' => $request->customer_address,
            'customer_city' => $request->customer_city,
            'customer_distrcit' => $request->customer_distrcit,
            'status' => $request->status
        ]);
        return redirect()->route('orders.index');
    }

    public function orderItemIndex($id)
    {
        $orderItems = $this->orderItem->where('order_id', $id)->get();
        return \view('admin.order.indexOrderItem', compact('orderItems'));
    }

    public function editOrderItem($id)
    {
        $orderItems = $this->orderItem->find($id);
        return \view('admin.order.editOrderItem', \compact('orderItems'));
    }

    public function updateOrderItem(Request $request, $id)
    {
        $this->orderItem->find($id)->update([
            'quantity' => $request->quantity
        ]);
        return redirect()->route('orders.index');
    }
}
