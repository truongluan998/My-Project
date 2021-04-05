@extends('layout')
@section('content')
<div class="container">
    <h2>Order #{{$orderDetails['id']}} Detail</h2>
    <div class="row">
        <div class="span4">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td colspan="2"><strong>Order details</strong></td>
                </tr>
                <tr>
                    <td>Order date</td>
                    <td>{{ date('d-m-Y', strtotime($orderDetails['created_at'])) }}</td>
                </tr>
                <tr>
                    <td>Order status</td>
                    <td>{{$orderDetails['status']}}</td>
                </tr>
                <tr>
                    <td>Order total</td>
                    <td>$ {{$orderDetails['total']}}</td>
                </tr>
                {{-- <tr>
                    <td>Coupon code</td>
                    <td>{{$orderDetails['coupon_code']}}</td>
                </tr> --}}
                {{-- <tr>
                    <td>Coupon amount</td>
                    <td>{{$orderDetails['coupon_amount']}}</td>
                </tr> --}}
                {{-- <tr>
                    <td>Payment method</td>
                    <td>{{$orderDetails['payment_method']}}</td>
                </tr> --}}
            </table>
        </div>
        <div class="span4">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td colspan="2"><strong>Delivery address</strong></td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>{{$orderDetails['customer_name']}}</td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td>{{$orderDetails['customer_address']}}</td>
                </tr>
                <tr>
                    <td>District</td>
                    <td>{{$orderDetails['customer_district']}}</td>
                </tr>
                <tr>
                    <td>City</td>
                    <td>{{$orderDetails['customer_city']}}</td>
                </tr>

                <tr>
                    <td>Phone</td>
                    <td>{{$orderDetails['customer_phone']}}</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="span8">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Product name</th>
                        {{-- <th>Product size</th>
                        <th>Product color</th> --}}
                        <th>Product quantity</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($orderDetails['orders_items'] as $product)
                        <tr>
                            <td><span>{{$product['product_name']}}</span></td>
                            {{-- <td><span>{{$product['product_size']}}</span></td>
                            <td><span>{{$product['product_color']}}</span></td> --}}
                            <td><span>{{$product['product_quantity']}}</span></td>
                            <td><span></span></td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

@endsection
