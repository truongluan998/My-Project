@extends('admin.layout.admin')

@section('title')
<title>List Role</title>
@endsection

@section('js')
    <script src="{{asset('vendor/sweetAlert2/sweetalert2@10.js')}}"></script>
    <script src="{{asset('admins/product/index/list.js')}}"></script>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @can('role-add')
        @include('admin.partials.content-header', ['name' => 'Role', 'key' => 'List'])
        @endcan
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <a href="{{route('roles.create')}}" class="btn btn-success float-right m-2">Add</a>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Role Name</th>
                                <th scope="col">Description Role</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($roles as $key => $role)
                            <tr>
                                <th scope="row">{{($roles->currentpage()-1) * $roles->perpage() + $key + 1 }}</th>
                                <td>{{$role->name}}</td>
                                <td>{{$role->display_name}}</td>
                                <td>
                                    @can('role-edit')
                                    <a href="{{ route('roles.edit', ['id' => $role->id])}}"
                                        class="btn btn-default">Edit</a>
                                    @endcan

                                    {{-- @can('role-delete')
                                    <a href="" data-url="{{route('roles.delete', ['id' => $role->id])}}" class="btn btn-danger action_delete">Delete</a>
                                    @endcan --}}
                                </td>
                            </tr>

                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $roles->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
