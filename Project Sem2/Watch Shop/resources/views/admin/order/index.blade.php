@extends('admin.layout.admin')

@section('title')
<title>List Order</title>
@endsection

@section('css')
<link rel="stylesheet" href="{{ asset('admins/product/index/list.css')}}">
@endsection

@section('js')
<script src="{{asset('vendor/sweetAlert2/sweetalert2@10.js')}}"></script>
<script src="{{ asset('admins/product/index/list.js')}}"></script>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Order', 'key' => 'List'])
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    {{-- @can('product-add') --}}
                    {{-- <a href="{{route('product.create')}}" class="btn btn-success float-right m-2">Add</a> --}}
                    {{-- @endcan --}}
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Username</th>
                                <th scope="col">Customer Name</th>
                                <th scope="col">Address</th>
                                <th scope="col">Phone</th>
                                <th scope="col">Email</th>
                                <th scope="col">City</th>
                                <th scope="col">District</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($orders as $key => $order)
                            <tr>
                                <th scope="row">{{($orders->currentpage()-1) * $orders->perpage() + $key + 1 }}</th>
                                <?php
                                try{
                                    $test = $order->user->username;
                                }catch(Exception $e){
                                    $test = 0;
                                }
                                if($test){
                                ?>
                                <td>{{$order->user->username}}</td>
                                <?php
                                }else{
                                ?>
                                <td>Visistors order</td>
                                <?php
                                }
                                ?>
                                <td>{{$order->customer_name}}</td>
                                <td>{{$order->customer_address}}</td>
                                <td>{{$order->customer_phone}}</td>
                                <td>{{$order->customer_email}}</td>
                                <td>{{$order->customer_city}}</td>
                                <td>{{$order->customer_district}}</td>
                                <td>@if($order->status) Accepted @else Cancel @endif</td>
                                <td>
                                    {{-- @can('product-edit') --}}
                                    <a href="{{ route('orders.edit', ['id' => $order->id]) }}"
                                        class="btn btn-default">Edit</a>
                                    {{-- @endcan --}}
                                    {{-- @can('product-delete') --}}
                                    <a href="{{ route('orders.indexOrderItem', ['id' => $order->id]) }}"
                                        class="btn btn-warning ">Details</a>
                                    {{-- data-url="{{route('product.delete', ['id' => $product->id])}}" --}}
                                    {{-- @endcan --}}
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $orders->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
