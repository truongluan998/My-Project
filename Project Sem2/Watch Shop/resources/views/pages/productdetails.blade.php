@extends('layout')
@section('title')
@foreach ($pro as $item)
<title>{{$item->name}}</title>
@endforeach
@endsection
@section('content')
    <!--start-breadcrumbs-->
    @foreach ($pro as $item)
	<div class="breadcrumbs">
		<div class="container">
			<div class="breadcrumbs-main">
				<ol class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li class="active">{{$item->name}}</li>
				</ol>
			</div>
		</div>
	</div>
	<!--end-breadcrumbs-->
	<!--start-single-->
	<div class="single contact">
		<h2>{{Session::get('data')}}</h2>
		<div class="container">
			<div class="single-main">
				<div class="col-md-1"></div>
				<div class="col-md-9 single-main-left">
				<?php
				$text = Session::pull('error');
				if($text){
				?>
				<div class="alert alert-danger" style="text-align: center" role="alert">
					{{$text}}
				</div>
				<?php
				}
				?>
				<div class="sngl-top">
					<div class="col-md-5 single-top-left">
						<div class="flexslider">
							  <ul class="slides">
								@foreach ($image as $img)
								<li data-thumb="{{URL::to($img->image_path)}}">
									<div class="thumb-image"> <img src="{{URL::to($img->image_path)}}" data-imagezoom="true" class="img-responsive" alt=""/> </div>
								</li>
								@endforeach
							  </ul>
						</div>
						<!-- FlexSlider -->
						<script src="{{asset('frontend/js/imagezoom.js')}}"></script>
						<script defer src="{{asset('frontend/js/jquery.flexslider.js')}}"></script>
						<link rel="stylesheet" href="{{asset('frontend/css/flexslider.css')}}" type="text/css" media="screen" />

                        <script>
                            // Can also be used with $(document).ready()
                            $(window).load(function () {
                                $('.flexslider').flexslider({
                                    animation: "slide",
                                    controlNav: "thumbnails"
                                });
                            });
                        </script>
                    </div>
                    <div class="col-md-7 single-top-right">
                        <div class="single-para simpleCart_shelfItem">
                            <h2>{{$item->name}}</h2>
                            <div class="star-on">
                                {{-- <ul class="star-footer">
                                    <li><a href="#"><i> </i></a></li>
                                    <li><a href="#"><i> </i></a></li>
                                    <li><a href="#"><i> </i></a></li>
                                    <li><a href="#"><i> </i></a></li>
                                    <li><a href="#"><i> </i></a></li>
                                </ul> --}}
                                <div class="review">
                                    {{-- <a href="#"> 1 customer review </a> --}}
								</div>
							<div class="clearfix"> </div>
							</div>
							{{-- <script>
								$(document).ready(function() {

								// If cookie is set, scroll to the position saved in the cookie.
								if ( $.cookie("scroll") !== null ) {
									$(document).scrollTop( $.cookie("scroll") );
								}

								// When a button is clicked...
								$('#submit').on("click", function() {

									// Set a cookie that holds the scroll position.
									$.cookie("scroll", $(document).scrollTop() );

								});//end of submit 

								});
							</script> --}}
							<h5 class="item_price">{{number_format($item->price)}} đ</h5>
						<form action="{{ route('update-quantity-product') }}" id = "form" name ="myForm" method="post" class="frm-quantity">
							<ul class="tag-men">
								<li><span>TAG</span>
								<span>: {{$item->Category->name}}</span></li>
								<li><span>BRAND</span>
								<span>: {{$item->Brand->name}}</span></li>
								<?php 
									if ($item->quantity > 0) {
								?>
								<li><span>STOCK</span>
									<span>: {{$item->quantity}}</span></li>
									<li>
										@csrf
										<input type="hidden" name="id" value="{{ $item->id }}">
										<span>QUANTITY : </span><input type="text" id="qty" name="qty" value="1" min = "1" data-max="{{$item->quantity}}" pattern="[0-9]*" >
										<p id="demo"></p>
										
									</li>
									<button type="submit" class="add-cart">ADD TO CART</button>
								<?php
									}else{
								?>
									<li><span style="font-size: 25px;">OUT OF STOCK</span></li>
								<?php
									}
								?>
							</ul>
						</form>
						</div>
					</div>
					<div class="clearfix"> </div>
				</div>
				<div class="tabs">
					<ul class="menu_drop">
				<li class="item1"><a href="#"><img src="images/arrow.png" alt="">Description</a>
					<ul>
						<li class="subitem1"><a href="#">{{$item->content}}</a></li>
					</ul>
				</li>
	 		        </ul>
				</div>
                @endforeach
				<div class="logo">
					<h2>Related Items</h2>
				</div>
				<div class="latestproducts">
					<div class="product-one">
						@foreach ($test as $item)
						<div class="col-md-4 product-left p-left">
							<div class="product-main simpleCart_shelfItem">
								<a href="{{URL::to('/product-details/'.$item->id)}}" class="mask"><img class="img-responsive zoom-img" src="{{URL::to($item->feature_image)}}" alt="" />
								<div class="product-bottom">
									<h3>{{$item->name}}</h3>
									<p>Explore Now</p>
									<h5>
										<span>
										<?php
										if($item->quantity > 0){
											echo 'IN STOCK';
										}else{
											echo 'OUT OF STOCK';
										}
											
										?>
									</span>
									</h5>
									<h4><span class=" item_price">{{$item->price}}</span></h4>
								</div>
								</a>
							</div>
						</div>
						@endforeach
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<br>

@endsection
