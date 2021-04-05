@extends('admin.layout.admin')

@section('title')
<title>Add Product</title>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'User', 'key' => 'List'])
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <a href="{{route('product.create')}}" class="btn btn-success float-right m-2">Add</a>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Username</th>
                                <th scope="col">Address</th>
                                <th scope="col">Email</th>
                                <th scope="col">Role</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {{-- @foreach($categories as $cate) --}}
                            <tr>
                                <th scope="row">1</th>
                                <td>hongluan98</td>
                                <td>Gia LAi</td>
                                <td>truong998@gmail.com</td>
                                <td>User</td>
                                <td>Active</td>
                                <td><a href=""
                                        class="btn btn-default">Edit</a>

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
