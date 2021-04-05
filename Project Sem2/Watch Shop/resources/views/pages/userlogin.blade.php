@extends('layout')
@section('content')
    <!--account-starts-->
	<div class="account">
		<div class="container">
		<div class="account-top heading">
				<h2>ACCOUNT</h2>
			</div>
			<div class="account-main">
				<div class="col-md-6 account-left">
					<h3>Existing User</h3>
					<form action="{{URL::to('/postlogin')}}" method="POST">
						{{ csrf_field() }}
						<div class="account-bottom">
							<input placeholder="Userr" name = "username" type="text" tabindex="3" required>
							<input placeholder="Password" name = "password" type="password" tabindex="4" required>
							<div class="address">
								<input type="submit" value="Login">
							</div>
						</div>
					</form>
				</div>
				<div class="col-md-6 account-right account-left">
					<h3>New User? Create an Account</h3>
					<p>By creating an account with our store, you will be able to move through the checkout process faster, store multiple shipping addresses, view and track your orders in your account and more.</p>
					<a href="{{URL::to('/register')}}">Create an Account</a>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<!--account-end-->
@endsection