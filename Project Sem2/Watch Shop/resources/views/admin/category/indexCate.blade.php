@extends('admin.layout.admin')

@section('title')
<title>List Category</title>
@endsection

@section('js')
    <script src="{{asset('vendor/sweetAlert2/sweetalert2@10.js')}}"></script>
    <script src="{{ asset('admins/product/index/list.js')}}"></script>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'category', 'key' => 'List'])
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    @can('category-add')
                    <a href="{{ route('categories.create')}}" class="btn btn-success float-right m-2">Add</a>
                    @endcan
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Name</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($categories as $key => $cate)
                            <tr>
                                <th scope="row">{{($categories->currentpage()-1) * $categories->perpage() + $key + 1 }}</th>
                                <td>{{$cate->name}}</td>
                                <td>
                                     @can('category-edit')
                                    <a href="{{ route('categories.edit', ['id' => $cate->id]) }}"
                                        class="btn btn-default">Edit</a>
                                    @endcan

                                    @can('category-delete')
                                     <a href="" data-url="{{route('categories.delete', ['id' => $cate->id])}}" class="btn btn-danger action_delete">Delete</a>
                                    @endcan

                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $categories->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
