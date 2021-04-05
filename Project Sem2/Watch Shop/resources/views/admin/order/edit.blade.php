@extends('admin.layout.admin')

@section('title')
<title>Edit Order</title>
@endsection

@section('css')
<link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />
<link href="{{asset('admins/user/add/add.css')}}" rel="stylesheet" />

@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Order', 'key' => 'Edit'])
    </div>
    <div class="container">
        <form action="{{ route('orders.update', ['id' => $order->id]) }}" method="POST">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md">
                            @csrf
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Customer name:</label>
                                        <input type="text" name="customer_name" class="form-control"
                                            placeholder="Enter Product Name" value="{{$order->customer_name}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Email:</label>
                                        <input type="text" name="customer_email" class="form-control" placeholder="Enter Email"
                                            value="{{$order->customer_email}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Phone:</label>
                                        <input type="text" name="customer_phone" class="form-control"
                                            placeholder="Enter Phone" value="{{$order->customer_phone}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Address:</label>
                                        <input type="text" name="customer_address" class="form-control"
                                            placeholder="Enter Address" value="{{$order->customer_address}}">
                                    </div>

                                    <div class="form-group">
                                        <label>City:</label>
                                        <input type="text" name="customer_city" class="form-control" placeholder="Enter City"
                                            value="{{$order->customer_city}}">
                                    </div>

                                    <div class="form-group">
                                        <label>District:</label>
                                        <input type="text" name="customer_distrcit" class="form-control"
                                            placeholder="Enter District" value="{{$order->customer_district}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Category:</label>
                                        <select class="form-control" name="status">
                                            <option disabled selected>Select Status</option>
                                            <option value="1" selected='selected'>Accepted</option>
                                            <option value="0">Cancel</option>
                                        </select>
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
