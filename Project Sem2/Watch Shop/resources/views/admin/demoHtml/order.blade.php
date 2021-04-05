@extends('admin.layout.admin')

@section('title')
<title>Add Product</title>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Order', 'key' => 'Management'])
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">

                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Order Id</th>
                                <th scope="col">Product</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Amount</th>
                                <th scope="col">Status</th>
                                <th scope="col">Created At</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {{-- @foreach($categories as $cate) --}}
                            <tr>
                                <th scope="row">1</th>
                                <td>2</td>
                                <td>Vertur</td>
                                <td>15000</td>
                                <td>3</td>
                                <td>45000</td>
                                <td>Created</td>
                                <td>2021-03-05 16:42:24</td>
                                <td><a href=""
                                        class="btn btn-danger">Delete</a>
                                </td>
                            </tr>

                            {{-- @endforeach --}}
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{-- {{ $categories->links() }} --}}
            </div>
        </div>
    </div>
</div>

@endsection
