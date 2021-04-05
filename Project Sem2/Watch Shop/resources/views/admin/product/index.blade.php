@extends('admin.layout.admin')

@section('title')
<title>List Product</title>
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
        @include('admin.partials.content-header', ['name' => 'Product', 'key' => 'List'])
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    @can('product-add')
                    <a href="{{route('product.create')}}" class="btn btn-success float-right m-2">Add</a>
                    @endcan
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Feature Image</th>
                                {{-- <th scope="col">Description</th> --}}
                                <th scope="col">Category</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Brand</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($products as $key => $product)
                            <tr>
                                <th scope="row">{{($products->currentpage()-1) * $products->perpage() + $key + 1 }}</th>
                                <td>{{$product->name}}</td>
                                <td>{{ number_format($product->price)}}</td>
                                <td><img class="product_image_150_100" src="{{URL::to($product->feature_image) }}" alt=""></td>
                                {{-- <td>{{$product->content}}</td> --}}
                                <td>{{ optional($product->category)->name}}</td>
                                <td>{{$product->quantity}}</td>
                                <td>{{$product->brand->name}}</td>
                                <td>
                                    @can('product-edit')
                                    <a href="{{ route('product.edit', ['id' => $product->id]) }}" class="btn btn-default">Edit</a>
                                    @endcan
                                    @can('product-delete')
                                    <a href="" data-url="{{route('product.delete', ['id' => $product->id])}}" class="btn btn-danger action_delete">Delete</a>
                                    @endcan
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $products->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
