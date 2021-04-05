@extends('admin.layout.admin')

@section('title')
<title>Add Roles</title>
@endsection

@section('css')
    <link rel="stylesheet" href="{{ asset('admins/role/add/add.css')}}">
@endsection


@section('js')
    <script src="{{ asset('admins/role/add/add.js')}}">

    </script>
@endsection



@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Roles', 'key' => 'Add'])
    </div>
    <div class="container">
        <form action="{{ route('roles.store')}}" method="POST" enctype="multipart/form-data">
            <div class="content">
                <div class="container-fluid">
                    @csrf
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Role Name:</label>
                                <input type="text" name="name" class="form-control" placeholder="Enter Role Name"
                                    value="{{old('name')}}">
                            </div>

                            <div class="form-group">
                                <label>Decriptions Role:</label>
                                <textarea name="display_name" class="form-control" placeholder="Enter Decriptions Role"
                                    rows="4" value="{{old('display_name')}}"></textarea>
                            </div>
                        </div>

                        <div class="col-md-12 ml-1">
                            <div class="row">

                                <div class="col-md-12">
                                    <label>
                                        <input type="checkbox" class="checkall">
                                        checkall
                                    </label>
                                </div>

                                @foreach ($permissionsParent as $permissionsParentItem)
                                <div class="card border-primary mb-3 col-md-12">
                                    <div class="card-header text-bold">
                                        <label for="">
                                            <input type="checkbox" class="checkbox_wrapper">
                                        </label>
                                        Module {{$permissionsParentItem->name}}
                                    </div>
                                    <div class="row">
                                        @foreach ($permissionsParentItem->permissionChildren as $permissionChildrenItem)
                                        <div class="card-body text-primary col-md-3">
                                            <h5 class="card-title">
                                                <label for="">
                                                    <input name="permission_id[]" class="checkbox_children"
                                                    type="checkbox" value="{{$permissionChildrenItem->id}}">
                                                </label>
                                                {{$permissionChildrenItem->name}}
                                            </h5>
                                        </div>
                                        @endforeach
                                    </div>
                                </div>
                                @endforeach
                            </div>
                        </div>
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-primary float-right"
                                style="margin-bottom: 20px;">Submit</button>
                                <a class="btn btn-danger" href="{{route('roles.index')}}">
                                        Cancel
                                    </a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


@endsection


