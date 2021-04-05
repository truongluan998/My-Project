@extends('admin.layout.admin')

@section('title')
<title>Edit Order Details</title>
@endsection

@section('css')
<link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />
<link href="{{asset('admins/user/add/add.css')}}" rel="stylesheet" />

@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Order Details', 'key' => 'Edit'])
    </div>
    <div class="container">
        <form action="{{ route('orders.updateOrderItem', ['id' => $orderItems->id]) }}" method="POST">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md">
                            @csrf
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Order Id:</label>
                                        <input type="text" name="customer_name" class="form-control"
                                            readonly value="{{$orderItems->orders->id}}">
                                    </div>

                                    <div class="form-group">
                                        <label>product Name:</label>
                                        <input type="text" name="customer_email" readonly class="form-control"
                                            value="{{$orderItems->product->name}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Price:</label>
                                        <input type="number" readonly name="price" class="form-control"
                                            placeholder="Enter Price" value="{{$orderItems->product->price}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Quantity:</label>
                                        <input type="number" name="quantity" class="form-control"
                                            placeholder="Enter Quantity" value="{{$orderItems->quantity}}">
                                    </div>

                                    <button type="submit" class="btn btn-primary float-right"
                                        style="margin-bottom: 20px;">Submit</button>
                                    <a class="btn btn-danger" href="{{route('orders.index')}}">
                                        Cancel
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    </form>
</div>
</div>

@endsection

@section('js')
<script src="{{asset('vendor/select2/select2.min.js')}}"></script>
<script src="{{asset('admins/user/add/add.js')}}"></script>


@endsection
