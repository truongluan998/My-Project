@extends('layout')
@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>My order history</h2>
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Order id</th>
                        <th>Order products</th>
                        <th>Payment method</th>
                        <th>Total</th>
                        <th>Created on</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($orders as $order)
                    <tr>
                        <td><a style="text-decoration: underline;"
                                href="{{url('orders/'.$order['id'])}}">#{{$order['id']}}</a></td>
                        <td>
                            @foreach ($order['orders_items'] as $pro)
                            {{$pro['product_name']}}<br>
                            @endforeach
                        </td>
                        <td>{{$order['payment_method']}}</td>
                        <td><span>${{$order['total']}}</span></td>
                        <td><span>{{ date('d-m-Y', strtotime($order['created_at'])) }}</span></td>
                        <td><a style="text-decoration: underline;"
                            href="{{url('/user/orders/'.$order['id'])}}">View details</a></td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

@endsection
