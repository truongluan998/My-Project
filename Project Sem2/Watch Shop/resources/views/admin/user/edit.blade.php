    @extends('admin.layout.admin')

    @section('title')
    <title>Edit User</title>
    @endsection

    @section('css')
    <link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />
    <link href="{{asset('admins/user/add/add.css')}}" rel="stylesheet" />


    <style>

    </style>

    @endsection



    @section('content')
    <div class="content-wrapper">
        <div class="content-header">
            @include('admin.partials.content-header', ['name' => 'User', 'key' => 'Edit'])
        </div>
        <div class="container">
            <form action="{{ route('users.update', ['id' => $user->id])}}" method="POST" enctype="multipart/form-data">
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md">
                                @csrf
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Username:</label>
                                            <input type="text" readonly name="username" class="form-control"  placeholder="Enter Product Name" value="{{$user->username}}">

                                        </div>

                                        <div class="form-group">
                                            <label>Email:</label>
                                            <input type="email" name="email" class="form-control"  @error('email') is-invalid
                                            @enderror placeholder="Enter Email" value="{{$user->email}}">
                                            @error('email')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                        </div>

                                        <div class="form-group">
                                            <label>Password:</label>
                                            <input type="password" name="password" class="form-control" @error('password') is-invalid
                                            @enderror placeholder="Enter Password">
                                            @error('password')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                        </div>

                                        <div class="form-group">
                                            <label>Address:</label>
                                            <input type="text" name="address" class="form-control"  @error('address') is-invalid
                                            @enderror placeholder="Enter Address" value="{{$user->address}}">
                                             @error('address')
                                        <p class="pt-1" style="color: red">{{ $message }}</p>
                                        @enderror
                                        </div>

                                        <div class="form-group">
                                            <label>Role:</label>
                                            <select name="role_id[]" class="form-control select2_init" multiple>
                                                <option value=""></option>
                                                @foreach ($roles as $role)
                                                <option
                                                    value="{{$role->id}}"
                                                    {{ $rolesOfUser->contains('id', $role->id) ? 'selected' : ''}}>
                                                    {{$role->name}}
                                                </option>
                                                @endforeach
                                            </select>
                                        </div>


                                        <button type="submit" class="btn btn-primary float-right"
                                            style="margin-bottom: 20px;">Submit</button>
                                            <a class="btn btn-danger" href="{{route('users.index')}}">
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
    <script src="{{asset('admins/user/add/add.js')}}"></script>


    @endsection
