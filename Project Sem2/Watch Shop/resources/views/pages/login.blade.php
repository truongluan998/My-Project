@extends('layout')
@section('content')
<div class="container custom-login">
    <div class="row">
        <div class="col-sm-4 col-sm-offset-4">
            <h2>Login form</h2>
            @if(Session::has('error_message'))
                <div class="alert alert-danger" role="alert">
                    {{Session::get('error_message')}}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times</span>
                    </button>
                </div>
            @endif
            <form id="loginForm" action="{{url('/user/login')}}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Enter email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" name="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd" required>
                </div>

                <button type="submit" class="btn btn-default">Login</button>
            </form>
        </div>
    </div>
</div>

@endsection
