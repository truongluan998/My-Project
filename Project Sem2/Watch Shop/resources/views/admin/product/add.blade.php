@extends('admin.layout.admin')

@section('title')
<title>Add Product</title>
@endsection

@section('css')
<link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />

<link href="{{asset('admins/product/add/add.css')}}" rel="stylesheet" />

@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Product', 'key' => 'Add'])
        <div class="col-md-12">
            {{-- @if ($errors->any())
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                    <li>{{$error}}</li>
                    @endforeach
                </ul>
            </div>
            @endif --}}
        </div>
    </div>
    <div class="container">
        <form action="{{ route('product.store') }}" method="POST" enctype="multipart/form-data">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md">
                            @csrf
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Product Name:</label>
                                        <input type="text" name="name" class="form-control" @error('name') is-invalid
                                            @enderror placeholder="Enter Product Name" value="{{old('name')}}">
                                        @error('name')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                    </div>

                                    <div class="form-group">
                                        <label>Price:</label>
                                        <input type="text" name="price" class="form-control" @error('price') is-invalid
                                            @enderror placeholder="Enter Price" value="{{old('price')}}">
                                        @error('price')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                    </div>

                                    <div>
                                        <label>Category:</label>
                                        <select class="form-control" name="category">
                                            <option disabled selected>Select Category</option>
                                            @foreach($categories as $category)
                                            <option value="{{ $category->id }}"> {{ $category->name }}</option>
                                            @endforeach
                                        </select>
                                        {{-- @error('category_id')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>
                                    <div class="mt-2">
                                        <label>Brand:</label>
                                        <select class="form-control" name="brand">
                                            <label>Brand:</label>
                                            <option disabled selected>Select Brand</option>
                                            @foreach($brands as $brand)
                                            <option value="{{ $brand->id }}"> {{ $brand->name }}</option>
                                            @endforeach
                                        </select>
                                        {{-- @error('brand_id')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror --}}
                                    </div>

                                    <div class="form-group mt-2">
                                        <label>Feature Image:</label>
                                        <input type="file" name="feature_image" class="form-control-file"
                                            style="width:100%;">
                                    </div>

                                    <div class="form-group">
                                        <label>Detailed Images:</label>
                                        <input type="file" multiple name="image_path[]" class="form-control-file">
                                    </div>

                                    <div class="form-group">
                                        <label>Quantity:</label>
                                        <input type="number" name="quantity" class="form-control" @error('quantity')
                                            is-invalid @enderror placeholder="Enter Quantity" value="{{old('quantity')}}">
                                        @error('quantity')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Descriptions:</label>
                                        <textarea rows="6" type="text" name="descriptions" @error('descriptions') is-invalid
                                            @enderror class="form-control tinymce_editor_init"
                                            placeholder="Enter Descriptions" value="{{old('descriptions')}}"></textarea>
                                        @error('descriptions')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
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
