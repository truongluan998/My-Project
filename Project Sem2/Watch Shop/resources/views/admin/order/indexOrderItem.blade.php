@extends('admin.layout.admin')

@section('title')
<title>Order Details</title>
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
        @include('admin.partials.content-header', ['name' => 'Order', 'key' => 'Details'])
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
                                <th scope="col">Order Id</th>
                                <th scope="col">Image</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($orderItems as $orderItemDetail)
                            <tr>
                                <td>{{$orderItemDetail->id}}</td>
                                <td>{{$orderItemDetail->orders->id}}</td>
                                <td><img class="product_image_150_100" src="{{URL::to($orderItemDetail->product->feature_image) }}" alt=""></td>
                                <td>{{$orderItemDetail->product->name}}</td>
                                <td>{{$orderItemDetail->product->price}}</td>
                                <td>{{$orderItemDetail->quantity}}</td>
                                <td>
                                    {{-- @can('product-edit') --}}
                                    <a href="{{ route('orders.editOrderItem', ['id' => $orderItemDetail->id]) }}" class="btn btn-default">Edit</a>
                                    {{-- @endcan --}}
                                    {{-- @can('product-delete') --}}

                                    {{-- @endcan --}}
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

@endsection
