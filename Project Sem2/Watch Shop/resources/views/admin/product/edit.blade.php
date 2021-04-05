@extends('admin.layout.admin')

@section('title')
<title>Edit Product</title>
@endsection

@section('css')
<link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />

<link href="{{asset('admins/product/add/add.css')}}" rel="stylesheet" />

@endsection

<style>

</style>


@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Product', 'key' => 'Edit'])
    </div>
    <div class="container">
        <form action="{{ route('product.update', ['id' => $product->id]) }}" method="POST" enctype="multipart/form-data">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md -6">
                            @csrf
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Product Name:</label>
                                        <input type="text" name="name" class="form-control"
                                            placeholder="Enter Product Name" value="{{$product->name}}">
                                    </div>

                                    <div class="form-group">
                                        <label>Price:</label>
                                        <input type="text" name="price" class="form-control"  placeholder="Enter Price"
                                            value="{{$product->price}}">
                                            {{-- @error('price')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>


                                    <div class="mt-2">
                                        <label>Category:</label>
                                        <select class="form-control" name="category" >
                                            <option value="{{$product->category_id}}">{{$product->category->name}}</option>
                                            @foreach($categories as $category)
                                            <option value="{{ $category->id }}"
                                                >
                                                 {{-- {{ $rolesOfUser->contains('id', $role->id) ? 'selected' : ''}} --}}
                                                {{ $category->name }}
                                            </option>
                                            @endforeach
                                        </select>
                                        {{-- @error('category_id')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>

                                    <div class="mt-2">
                                        <label>Brand:</label>
                                        <select class="form-control"  name="brand">
                                            <label>Brand:</label>
                                            <option value = "{{$product->brand_id}}">{{$product->brand->name}}</option>
                                            @foreach($brands as $brand)
                                            <option value="{{ $brand->id }}">
                                                {{ $brand->name }}
                                            </option>
                                            @endforeach
                                        </select>
                                         {{-- @error('brand_id')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>

                                    <div class="form-group" class="mt-2">
                                        <label>Feature Image:</label>
                                        <input type="file" name="feature_image" class="form-control-file"
                                            style="width:100%;">
                                        <div class="col-md-12 container_image_detail">
                                            <div class="row">
                                                <img class="image_feature_product"
                                                    src="{{URL::to($product->feature_image) }}" alt="">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Detailed Images:</label>
                                        <input type="file" multiple name="image_path[]" class="form-control-file">
                                        <div class="col-md-12 container_image_detail">
                                            <div class="row">
                                                @foreach($product->productImages as $productImageItem)
                                                <div class="col-md-3">
                                                    <img class="image_detail_product"
                                                        src="{{URL::to($productImageItem->image_path) }}" alt="">
                                                </div>
                                                @endforeach
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Quantity:</label>
                                        <input type="number" name="quantity" class="form-control"
                                            placeholder="Enter Quantity" value="{{$product->quantity}}">
                                             {{-- @error('quantity')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Descriptions:</label>
                                        <textarea rows="6" type="text" name="descriptions"
                                            class="form-control tinymce_editor_init"
                                            placeholder="Enter Descriptions">{{$product->content}}</textarea>
                                            {{-- @error('descriptions')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>
                                    <button type="submit" class="btn btn-primary float-right"
                                        style="margin-bottom: 20px;">Submit</button>
                                        <a class="btn btn-danger" href="{{route('product.index')}}">
                                        Cancel
                                    </a>
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
<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script src="{{asset('admins/product/add/add.js')}}"></script>

@endsection
