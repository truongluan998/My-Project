@extends('admin.layout.admin')

@section('title')
<title>List Brand</title>
@endsection

@section('js')
    <script src="{{asset('vendor/sweetAlert2/sweetalert2@10.js')}}"></script>
    <script src="{{ asset('admins/product/index/list.js')}}"></script>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @can('brand-add')
        @include('admin.partials.content-header', ['name' => 'Brand', 'key' => 'List'])
        @endcan
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <a href="{{ route('brands.create')}}" class="btn btn-success float-right m-2">Add</a>
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
                            @foreach($brands as $key => $br)
                            <tr>
                                <th scope="row">{{($brands->currentpage()-1) * $brands->perpage() + $key + 1 }}</th>
                                <td>{{$br->name}}</td>
                                <td>
                                @can('brand-edit')
                                    <a href="{{ route('brands.edit', ['id' => $br->id]) }}"
                                        class="btn btn-default">Edit</a>
                                @endcan
                                @can('brand-delete')
                                  <a href="" data-url="{{route('brands.delete', ['id' => $br->id])}}" class="btn btn-danger action_delete">Delete</a>
                                @endcan
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $brands->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
