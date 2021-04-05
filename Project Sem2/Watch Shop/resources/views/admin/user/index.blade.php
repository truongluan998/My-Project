@extends('admin.layout.admin')

@section('title')
<title>List User</title>
@endsection

@section('js')
    <script src="{{asset('vendor/sweetAlert2/sweetalert2@10.js')}}"></script>
    <script src="{{ asset('admins/product/index/list.js')}}"></script>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @can('user-add')
        @include('admin.partials.content-header', ['name' => 'User', 'key' => 'List'])
        @endcan
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <a href="{{route('users.create')}}" class="btn btn-success float-right m-2">Add</a>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped mt-4">
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Username</th>
                                <th scope="col">Address</th>
                                <th scope="col">Email</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($users as $key => $user)
                            <tr>
                                <th scope="row">{{($users->currentpage()-1) * $users->perpage() + $key + 1 }}</th>
                                <td>{{$user->username}}</td>
                                <td>{{$user->address}}</td>
                                <td>{{$user->email}}</td>
                                <td>
                                    @can('user-edit')
                                    <a href="{{ route('users.edit', ['id' => $user->id]) }}"
                                        class="btn btn-default">Edit</a>
                                    @endcan
                                    @can('user-delete')
                                    <a data-url="{{ route('users.delete', ['id' => $user->id])}}" href="" class="btn btn-danger action_delete">Delete</a>
                                    @endcan
                                </td>
                            </tr>

                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-12">
                {{ $users->links() }}
            </div>
        </div>
    </div>
</div>

@endsection
