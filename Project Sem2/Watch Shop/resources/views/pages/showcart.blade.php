@extends('layout')
@section('title')
<title>Cart</title>
@endsection
@section('content')
	<!--start-breadcrumbs-->
	<div class="breadcrumbs">
		<div class="container">
			<div class="breadcrumbs-main">
				<ol class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li class="active">Checkout</li>
				</ol>
			</div>
		</div>
	</div>
	<!--end-breadcrumbs-->
	<!--start-ckeckout-->
	<?php
	$count = Cart::count();
	if($count > 0){
	?>
	<div class="ckeckout">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-md-10 col-md-offset-1">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Product</th>
								<th>Quantity</th>
								<th class="text-center">Price</th>
								<th class="text-center">Total</th>
								<th> </th>
							</tr>
						</thead>
						<tbody>
							<?php 
							$text = Session::pull('data');
							$text2 = Session::pull('noti');
							$text3 = Session::pull('delete');
							if($text){
							?>
							<div class="alert alert-danger" style="text-align: center" role="alert">
								{{$text}}
							</div>
							<?php
							}else{
								if($text2){
							?>
							<div class="alert alert-success" style="text-align: center;" role="alert">
								{{$text2}}
							  </div>
							<?php
								}
							}
								if($text3){
							?>
							<div class="alert alert-success" style="text-align: center;" role="alert">
								{{$text3}}
							</div>
							<?php
							}
							?>
							@foreach (Cart::content() as $item)
							<tr>
								<td class="col-sm-8 col-md-6">
								<div class="media">
									<a class="thumbnail pull-left" href="#"> <img class="media-object" src="{{URL::to($item->options->image)}}" style="width: 72px; height: 72px;"> </a>
									<div class="media-body">
										<h4 class="media-heading"><a href="#">{{$item->name}}</a></h4>
										<h5 class="media-heading"> by <a href="#">{{$item->options->brand}}</a></h5>
									</div>
								</div></td>
								<td class="col-sm-1 col-md-1" style="text-align: center">
									{{-- <a href="#" style="font-size: 20px;" >+</a>	
									<input type="qty" class="form-control" name="qty" value="{{$item->qty}}">
									<a href="#" style="font-size: 20px;" >-</a>	 --}}
									<form action="{{ route('update-quantity') }}" id = "form" method="post" class="frm-update-quantity" >
										@csrf
										<input type="hidden" name="pid" value="{{ $item->rowId }}">
										<div class="quantity-input">
											<a class="btn btn-primary btn-increase" href="#">+</a>
											<input type="text" class="quantity-input" id="qty" name="product-quantity" 
											value = "{{$item->qty}}"
											 data-max="500" pattern="[0-9]*" >									
											<a class="btn btn-primary btn-reduce" href="#">-</a>
										</div>
									</form>
								</td>
								<td class="col-sm-1 col-md-1 text-center"><strong>{{number_format($item->price)}} VND</strong></td>
								<td class="col-sm-1 col-md-1 text-center"><strong>{{number_format($item->price * $item->qty)}} VND</strong></td>
								<td class="col-sm-1 col-md-1">
								<a type="button" class="btn btn-danger" href="{{URL::to('/delete-cart-item/'.$item->rowId)}}">
									<span class="glyphicon glyphicon-remove"></span> Remove
								</a></td>
							</tr>
							@endforeach
							<tr>
								<td>   </td>
								<td>   </td>
								<td>   </td>
								<td><h5>Subtotal</h5></td>
								<td class="text-right"><h5><strong>{{number_format(Cart::subtotal())}} VND</strong></h5></td>
							</tr>
							<tr>
								<td>   </td>
								<td>   </td>
								<td>   </td>
								<td><h5>Estimated shipping</h5></td>
								<td class="text-right"><h5><strong>Freeship</strong></h5></td>
							</tr>
							<tr>
								<td>   </td>
								<td>   </td>
								<td>   </td>
								<td><h3>Total</h3></td>
								<td class="text-right"><h3><strong>{{number_format(Cart::total())}} VND</strong></h3></td>
							</tr>
							<tr>
								<td>   </td>
								<td>   </td>
								<td>   </td>
								<td><a href="{{URL::to('/all-product-by-brand')}}">
									<button type="button" class="btn btn-default" >
										<span class="glyphicon glyphicon-shopping-cart"></span> Continue Shopping
									</button>
								</a>
								</td>
								<td>
								<a type="button" class="btn btn-success" href = "{{URL::to('/checkout')}}">
									Checkout <span class="glyphicon glyphicon-play"></span>
								</a></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<?php
	} 
	else{
	?>
	<div class="ckeckout">
		<div class="container">
			<h4>There is no item in your cart!</h4>
			<a href="{{URL::to('/all-product-by-brand')}}">
				<button type="button" class="btn btn-default" >
					<span class="glyphicon glyphicon-shopping-cart"></span> Continue Shopping
				</button>
			</a>
		</div>
	</div>
	<?php
	}
	?>
	
	<!--end-ckeckout--> 
@endsection